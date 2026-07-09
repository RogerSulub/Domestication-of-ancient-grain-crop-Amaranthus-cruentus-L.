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


######## vcf to bed biallelic
/home/rsulubtu/tools/plink2 \
  --vcf filter_Amaranthus.vcf \
  --allow-extra-chr \
  --keep-allele-order \
  --make-bed \
  --max-alleles 2 \
  --out Amaranthus_Biallelic \
  --set-all-var-ids @:# \
  --snps-only 

 ######## LD pruning
/home/rsulubtu/tools/plink2 \
  --allow-extra-chr \
  --bfile Amaranthus_Biallelic \
  --indep-pairwise 50 5 0.3 \
  --keep-allele-order \
  --out indep-pairwise 

##### extract LD pruned data
/home/rsulubtu/tools/plink2 \
  --allow-extra-chr \
  --bfile Amaranthus_Biallelic \
  --extract indep-pairwise.prune.in \
  --make-bed \
  --out Amaranthus_Biallelic.pruned

############# missing filter
/home/rsulubtu/tools/plink2 \
  --allow-extra-chr \
  --bfile Amaranthus_Biallelic.pruned \
  --geno 0.02 \
  --make-bed \
  --out Amaranthus_Biallelic.pruned.0.02miss
  