cd
cd PRATICA_ENSAMBLAGEM_DE_GENOMAS
# Creo datos pacbio con parametros nina
conda activate bbduk_env
randomreads.sh ref=complete_genoma.fasta out=PacBio.fq pacbio=t pbmin=0.001 pbmax=0.01 coverage=20 minlength=1500 maxlength=30000 midlength=15000
# Creo datos illumina paired end
randomreads.sh ref=complete_genoma.fasta out1=bbmap_illumina_.R1.fq out2=bbmap_illumina_R2.fq illuminanames=t paired=t coverage=20 minlength=150 maxlength=150 midlength=150 minq=18 maxq=40 midq=31 addpairnum=t
# bbduk limpiar
bbduk.sh in1=bbmap_illumina_tes.R1.fq in2=bbmap_illumina_tes.R2.fq out1=bbduk/bbduk.R1.fq out2=bbduk/bbduk.R2.fq minlength=100 qtrim=w trimq=20 

# FASTQ
conda activate fastqc_env
fastq
# Unicycler
conda activate unicycler
unicycler  -1 ./bbduk/bbduk.R1.fq -2 ./bbduk/bbduk.R2.fq -o ./unicycler/
# Bandage
conda activate bandage_env
Bandage

# Mirar unycicler con datos de pacbio para ver si circulariza
# genomescope 2.0 - jellyfish
# Correr Flye para ensamblar reads PacBio  y ensamblaje hibrido
conda activate flye_env
flye --pacbio-hifi PacBio.fq -o ./flye -g 3.6g
# Circlator

# QUAST
conda activate quast_env
# QUAST illumina
quast -o ./quast/illumina -r complete_genoma.fasta -g features.gff3 ./unicycler/assembly.fasta
# QUAST pacbio
quast -o ./quast/pacbio -r complete_genoma.fasta -g features.gff3 ./flye/scaffolds.fasta 

# BUSCO
conda activate busco_env
# BUSCO illumina
busco -i ./unicycler/assembly.fasta -o illumina -m geno --lineage rhodospirillales_odb10 --out_path ./busco
# BUSCO pacbio
busco -i ./flye/scaffolds.fasta -o pacbio -m geno --lineage rhodospirillales_odb10 --out_path ./busco


