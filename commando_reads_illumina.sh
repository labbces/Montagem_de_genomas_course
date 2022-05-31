cd
cd PRATICA_ENSAMBLAGEM_DE_GENOMAS
# Creo datos pacbio con parametros nina
conda activate bbduk_env
randomreads.sh ref=complete_genome.fasta out=PacBio.fq pacbio=t pbmin=0.001 pbmax=0.01 coverage=20 minlength=1500 maxlength=30000
# Creo datos illumina paired end
randomreads.sh ref=complete_genome.fasta out1=bbmap_illumina_R1.fq out2=bbmap_illumina_R2.fq illuminanames=t paired=t coverage=20 minlength=150 maxlength=150 minq=18 maxq=40 midq=31 addpairnum=t -Xmx2g
# bbduk limpiar
bbduk.sh in1=bbmap_illumina_R1.fq in2=bbmap_illumina_R2.fq out1=bbduk/bbduk.R1.fq out2=bbduk/bbduk.R2.fq minlength=100 qtrim=w trimq=20 -Xmx2g
conda deactivate
# FASTQ
conda activate fastqc_env
fastqc
conda deactivate

# Unicycler
conda activate unicycler_env
unicycler  -1 ./bbduk/bbduk.R1.fq -2 ./bbduk/bbduk.R2.fq -o ./unicycler/
conda deactivate

# Bandage
conda activate bandage_env
Bandage
conda deactivate

# Flye
conda activate flye_env
flye --pacbio-hifi PacBio.fq -o ./flye
conda deactivate
# Circlator

# QUAST
conda activate quast_env
# QUAST illumina
quast -o ./quast/illumina -r complete_genome.fasta ./unicycler/assembly.fasta
# QUAST pacbio
quast -o ./quast/pacbio -r complete_genome.fasta ./flye/assembly.fasta 
conda deactivate

# BUSCO
conda activate busco_env
# BUSCO illumina
busco -i ./unicycler/assembly.fasta -o illumina -m geno --lineage rhodospirillales_odb10 --out_path ./busco
# BUSCO pacbio
busco -i ./flye/assembly.fasta -o pacbio -m geno --lineage rhodospirillales_odb10 --out_path ./busco

####### UNICYCLER PARA PACBIO
conda activate unicycler_env
unicycler  -l PacBio.fq -o ./unicycler_pacbio/
conda deactivate

### JELLYFISH
mkdir -p ./jellyfish/
jellyfish count -C -m 21 -s 10000000 -t 6 bbmap_illumina_R*.fq -o ./jellyfish/reads.jf
jellyfish histo -t 6 ./jellyfish/reads.jf > ./jellyfish/reads.histo

# Unicycler hibrido
conda activate unicycler_env
unicycler  -1 ./bbduk/bbduk.R1.fq -2 ./bbduk/bbduk.R2.fq -l PacBio.fq -o ./unicycler_hybrid/
conda deactivate
