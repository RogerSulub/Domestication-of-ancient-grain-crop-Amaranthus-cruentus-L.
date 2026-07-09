#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/Analysis/plink_format/
#SBATCH -o /scratch/rsulubtu/Analysis/plink_format/logs/NJ-plink-%j.txt
#SBATCH -e /scratch/rsulubtu/Analysis/plink_format/logs/NJ-plink-%j.err
#SBATCH -t 12:00:00
#SBATCH -J plink_convert
#SBATCH --partition=smp-rh7
#SBATCH --cpus-per-task=5
#SBATCH --mem 200g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates


####### make recoded raw file for reading into R for tree
/home/rsulubtu/tools/plink2 \
    --bfile Amaranthus_Biallelic.pruned.0.02miss \
    --allow-extra-chr \
    --recode A \
    --out Amaranthus_Biallelic.pruned.0.02miss_NJ 
