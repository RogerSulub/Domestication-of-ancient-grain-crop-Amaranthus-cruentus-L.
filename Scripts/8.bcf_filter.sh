#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/Analysis/SNP_call
#SBATCH -o /scratch/rsulubtu/Analysis/SNP_call/logs/bcf_filter-%j.txt
#SBATCH -e /scratch/rsulubtu/Analysis/SNP_call/logs/bcf_filter-%j.err
#SBATCH -t 1-12:00:00
#SBATCH -J bcf_filter
#SBATCH --partition=smp-rh7
#SBATCH --cpus-per-task=5
#SBATCH --mem 250g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates


/home/rsulubtu/tools/bcftools/bcftools view \
-o filter_Amaranthus.vcf.gz \
-O z \
-q 0.01:minor \
-i 'F_MISSING<0.2' \
Ama-chh_genome-missFilter.bcf
