#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/Analysis/Admixture
#SBATCH -o /scratch/rsulubtu/Analysis/Admixture/logs/admixK4-12-%j.txt
#SBATCH -e /scratch/rsulubtu/Analysis/Admixture/logs/admixK4-12-%j.err
#SBATCH -t 4-12:00:00
#SBATCH -J k2-k12
#SBATCH --array=2-12
#SBATCH --mem 92g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

### Admixture from beagle, k=2-12

echo $SLURM_ARRAY_TASK_ID

/home/rsulubtu/tools/angsd/misc/NGSadmix \
-likes PCA_chh_final.beagle.gz \
-K $SLURM_ARRAY_TASK_ID \
-o Amaranthus_admix_$SLURM_ARRAY_TASK_ID \
-P 10 


