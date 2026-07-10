#!/bin/bash -l
#SBATCH -D /scratch/asingh3/Cruentus_Demo/NEW_HPC_FINAL/Multiple/
#SBATCH -o /scratch/asingh3/Cruentus_Demo/logs/Fsc_Multiple-Log-%j.txt
#SBATCH -e /scratch/asingh3/Cruentus_Demo/logs/FSC_Multiple-Log-%j.err
#SBATCH -t 10:00:00
#SBATCH -J Multiple_FSC
#SBATCH --partition=smp
#SBATCH --mem 4g
#SBATCH --array=0-99
#SBATCH --mail-type=ALL # if you want emails, otherwise remove
#SBATCH --account=ag-stetter
#SBATCH --mail-user=asingh3@uni-koeln.de # receive an email with updates


PREFIX="Multiple"
   mkdir ${PREFIX}_run$SLURM_ARRAY_TASK_ID
   cp ${PREFIX}.tpl ${PREFIX}.est ${PREFIX}_jointMAFpop*.obs ${PREFIX}_run$SLURM_ARRAY_TASK_ID"/"
   cd ${PREFIX}_run$SLURM_ARRAY_TASK_ID
   /scratch/asingh3/Cruentus_Demo/fsc27_linux64/fsc27_linux64/fsc27093 -t ${PREFIX}.tpl -n200000 -m -e ${PREFIX}.est -M -L 40  -C 10 -c 4 --removeZeroSFS
   cd ..

