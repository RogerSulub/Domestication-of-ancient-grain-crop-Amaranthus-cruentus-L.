#!/bin/bash -l
#SBATCH -D /scratch/asingh3/Cruentus_Demo/BootCI/2PopSplit_maxL/
#SBATCH -o /scratch/asingh3/Cruentus_Demo/logs/Fsc_BootCI-Log-%j.txt
#SBATCH -e /scratch/asingh3/Cruentus_Demo/logs/FSC_BootCI-Log-%j.err
#SBATCH -t 7-10:00:00
#SBATCH -J BootCI
#SBATCH --partition=smp
#SBATCH --mem 4g
#SBATCH --array=0-99
#SBATCH --mail-type=ALL # if you want emails, otherwise remove
#SBATCH --account=ag-stetter
#SBATCH --mail-user=asingh3@uni-koeln.de # receive an email with updates



PREFIX="2PopSplit_maxL"
   #mkdir ${PREFIX}_$SLURM_ARRAY_TASK_ID
   cp ${PREFIX}.tpl ${PREFIX}.est ${PREFIX}.pv ${PREFIX}_$SLURM_ARRAY_TASK_ID"/"
   cd ${PREFIX}_$SLURM_ARRAY_TASK_ID
   for Rep in {1..100}
     do
       mkdir run${Rep}
       cp ${PREFIX}.tpl ${PREFIX}.est ${PREFIX}.pv ${PREFIX}_jointMAFpop*.obs run${Rep}"/"
       cd run${Rep}
   /home/asingh3/TOOLS/fsc27_linux64/fsc27093 -t ${PREFIX}.tpl -n200000 -m -e ${PREFIX}.est -M -L 40  -C 10 -c 4 --removeZeroSFS --–initvalues ${PREFIX}.pv
   cd ..
   done
   cd ..
