#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/bam-files
#SBATCH -o /scratch/rsulubtu/bam-files/logs/angsd-VCF-all-missFilter-Log-%j.txt
#SBATCH -e /scratch/rsulubtu/bam-files/logs/angsd-VCF-all-missFilter-Log-%j.err
#SBATCH -t 8-12:00:00
#SBATCH -J angsd_VCF_all-missFilter
#SBATCH --partition=smp-rh7
#SBATCH --cpus-per-task=5
#SBATCH --mem 250g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

### Get genotype likelihoos in beagle format
/home/rsulubtu/tools/angsd/angsd \
-bam BamFileList.txt \
-out /scratch/rsulubtu/vcf-files/Amaranthus-missFilter-outg_V2 \
-P 5 \
-ref /home/rsulubtu/reference/Amaranthus_cruentus.softmasked.fa \
-doCounts 1 \
-doGeno 3 \
-dopost 2 \
-domajorminor 1 \
-domaf 1 \
-dobcf 1 \
-snp_pval 1e-6 \
-remove_bads 1 \
-minMapQ 30 \
-minQ 30 \
-gl 2 \
-checkBamHeaders 0 \
-minInd 47 \
-only_proper_pairs 1 \
-trim 0 \
-setMinDepth 47 \
-setMaxDepthInd 150
