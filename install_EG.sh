
## COPIAR GENOMA Y GFF3
#!/bin/bash
cd && mkdir -p PRATICA_ENSAMBLAGEM_DE_GENOMAS && cd PRATICA_ENSAMBLAGEM_DE_GENOMAS

# install bbmap (bbduk)
conda create -n bbduk_env -y
conda activate bbduk_env
conda install -c bioconda bbmap -y
#################################

# instalar unicycler en ambiente virtual python 3.6
conda create -n unicycler_env python=3.6 -y
conda activate unicycler_env
conda install -c bioconda unicycler -y
#################################

#instalar bandage
conda create -n bandage_env -y
conda activate bandage_env
conda install -c bioconda bandage -y
#################################

# instal flye
conda create -n flye_env -y
conda activate flye_env
conda install -c bioconda flye -y
#################################

# install quast
conda create -n quast_env python=3.6 -y
conda activate quast_env
conda install -c bioconda quast -y 
#################################

# install busco
conda create -n busco_env -c conda-forge -c bioconda busco=5.3.2 -y
conda activate busco_env
#################################

# install fastqc
conda create -n fastqc_env -y
conda activate fastqc_env
conda install -c bioconda fastqc -y
#################################

# install jellyfish
conda create -n jellyfish_env
conda activate  jellyfish_env
conda install -c conda-forge jellyfish 
#################################
