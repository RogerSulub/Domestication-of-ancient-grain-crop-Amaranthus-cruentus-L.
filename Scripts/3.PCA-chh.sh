#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/Analysis
#SBATCH -o /scratch/rsulubtu/PCA_cru/logs/PCALog_chh-%j.txt
#SBATCH -e /scratch/rsulubtu/PCA_cru/logs/PCALog_chh-%j.err
#SBATCH -t 2-12:00:00
#SBATCH -J PCA_chh
#SBATCH --partition=smp-rh7
#SBATCH --cpus-per-task=5
#SBATCH --mem 200g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

### Get genotype likelihoos in beagle format
/home/rsulubtu/tools/angsd/angsd \
-bam /scratch/rsulubtu/PCA_cru/BamFileList_cru.txt \
-GL 2 \
-out /scratch/rsulubtu/Analysis/PCA_amaranthus_chh \
-nThreads 12 \
-doGlf 2 \
-doMajorMinor 1 \
-doMaf 2 \
-SNP_pval 1e-6 \
-minMapQ 30 \
-minQ 20 
#-minInd 88 \
#-only_proper_pairs 1 \
#-trim 0 \
#-setMinDepth 88 \
#-setMaxDepthInd 150
#### pca covariants from beagle file
module load miniconda
conda activate pcangsd2

pcangsd \
-b PCA_amaranthus_chh.beagle.gz \
-o PCA_amaranthus_covariants_chh \
-t 10
