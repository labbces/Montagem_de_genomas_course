
## COPIAR GENOMA Y GFF3
#!/bin/bash
cd && mkdir -p PRATICA_ENSAMBLAGEM_DE_GENOMAS && cd PRATICA_ENSAMBLAGEM_DE_GENOMAS

# install bbmap (bbduk)
conda create -n bbduk_env -y
conda activate bbduk_env
conda install -c bioconda bbmap -y
conda deactivate
#################################

# instalar unicycler en ambiente virtual python 3.6
conda create -n unicycler_env python=3.6 -y
conda activate unicycler_env
conda install -c bioconda unicycler -y
conda deactivate
#################################

#instalar bandage
conda create -n bandage_env -y
conda activate bandage_env
conda install -c bioconda bandage -y
conda deactivate
#################################

# instal flye
conda create -n flye_env -y
conda activate flye_env
conda install -c bioconda flye -y
conda deactivate
#################################

# install quast
conda create -n quast_env python=3.6 -y
conda activate quast_env
conda install -c bioconda quast -y 
conda deactivate
#################################

# install busco
conda create -n busco_env -c conda-forge -c bioconda busco=5.3.2 -y
conda activate busco_env
conda deactivate
#################################

# install fastqc
conda create -n fastqc_env -y
conda activate fastqc_env
conda install -c bioconda fastqc -y
conda deactivate
#################################

# install jellyfish
conda create -n jellyfish_env
conda activate  jellyfish_env
conda install -c conda-forge jellyfish 
conda deactivate
#################################

# install genomescope2
conda create -n genomescope2
conda activate genomescope2
conda install -c bioconda genomescope2 
conda deactivate
