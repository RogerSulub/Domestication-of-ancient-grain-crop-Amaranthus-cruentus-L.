#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/bam-files
#SBATCH -o /scratch/rsulubtu/analysis/abba-baba2-V2/logs/abba-baba2-Log-%j.txt
#SBATCH -e /scratch/rsulubtu/analysis/abba-baba2-V2/logs/abba-baba2-Log-%j.err
#SBATCH -t 8-12:00:00
#SBATCH -J abba2-V2
#SBATCH --partition=smp-rh7
#SBATCH --cpus-per-task=5
#SBATCH --mem 250g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

/home/rsulubtu/tools/angsd/angsd -doAbbababa2 1 \
-bam /scratch/rsulubtu/analysis/abba-baba2-V2/BamFileList.txt \
-sizeFile /scratch/rsulubtu/analysis/abba-baba2-V2/sizeFile.txt \
-out /scratch/rsulubtu/analysis/abba-baba2-V2/Amaranthus-abba2 \
-ref /home/rsulubtu/reference/Amaranthus_cruentus.softmasked.fa \
-doCounts 1 \
-domajorminor 1 \
-useLast 1 \
-domaf 1 \
-remove_bads 1 \
-minMapQ 30 \
-minQ 30 \
-gl 2 \
-checkBamHeaders 0 \
-minInd 47 \
-only_proper_pairs 1 \
-trim 0 \
-setMinDepth 47 \
-setMaxDepthInd 150 \
-minMaf 0.02
