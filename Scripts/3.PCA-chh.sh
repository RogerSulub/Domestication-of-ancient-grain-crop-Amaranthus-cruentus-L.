#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/Analysis
#SBATCH -o /scratch/rsulubtu/PCA_chh/logs/PCALog_chh-%j.txt
#SBATCH -e /scratch/rsulubtu/PCA_chh/logs/PCALog_chh-%j.err
#SBATCH -t 2-12:00:00
#SBATCH -J PCA_chh
#SBATCH --partition=smp-rh7
#SBATCH --cpus-per-task=5
#SBATCH --mem 200g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

### Get genotype likelihoos in beagle format
/home/rsulubtu/tools/plink/plink \
  --allow-extra-chr
  --bfile filter_Amaranthus-No.outg_V2.pruned.98miss
  --out Amaranthus_filtered-PCA
  --pca 20
