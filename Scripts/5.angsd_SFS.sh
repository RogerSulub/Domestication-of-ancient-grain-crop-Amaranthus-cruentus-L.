#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/bam_files/  
#SBATCH -o /scratch/rsulubtu/Analysis/SFS/logs/SFSLog-%j.txt
#SBATCH -e /scratch/rsulubtu/Analysis/SFS/logs/SFSLog-%j.err
#SBATCH -t 7-12:00:00
#SBATCH -J angsd-SFS
#SBATCH --partition=smp-rh7
#SBATCH --mem 250g
#SBATCH --array=0-4
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

#FILES=(Analysis/Population_Stats/*.txt)
FILES=(PopulationsLists/*.txt)
#NAME="$(basename ${FILES})"
#FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
FILE="$(basename ${FILES[$SLURM_ARRAY_TASK_ID]})"
echo processing ${FILE}
######## SFS calculation #####
/home/rsulubtu/tools/angsd/angsd \
-bam PopulationsLists/${FILE} \
-ref /home/rsulubtu/reference/Amaranthus_cruentus.softmasked.fa \
-anc /home/rsulubtu/reference/Amaranthus_cruentus.softmasked.fa \
-GL 2 \
-out /scratch/rsulubtu/Analysis/SFS/${FILE}_folded \
-nThreads 12 \
-dosaf 1 \
-minMapQ 30 \
-minQ 30 \
-uniqueOnly 1 \
-remove_bads 1 \
-only_proper_pairs 1 \
-trim 0 \
-c 50 \
-doCounts 1
