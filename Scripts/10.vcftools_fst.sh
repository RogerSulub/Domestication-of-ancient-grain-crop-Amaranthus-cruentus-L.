#!/bin/bash -l
#SBATCH --partition=smp-rh7
#SBATCH -D /scratch/rsulubtu/Analysis/statistics
#SBATCH -o /scratch/rsulubtu/Analysis/statistics/logs/vcftools-FST-%j.txt
#SBATCH -e /scratch/rsulubtu/Analysis/statistics/logs/vcftools-FST-%j.err
#SBATCH -t 4:00:00
#SBATCH -J FST-vcftools
#SBATCH --nodes=1
#SBATCH --ntasks 8
#SBATCH --mem 42gb
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de

### Recode bed to vcf
/home/rsulubtu/tools/plink2 \
  --allow-extra-chr
  --bfile Amaranthus_Biallelic.pruned.0.02miss
  --out amaranthus
  --recode vcf

module load vcftools

vcftools --vcf amaranthus.vcf --weir-fst-pop AC1.txt --weir-fst-pop AC2.txt --out cruentus1_vs_cruentus2
vcftools --vcf amaranthus.vcf --weir-fst-pop AC1.txt --weir-fst-pop AC3.txt --out cruentus1_vs_cruentus3
vcftools --vcf amaranthus.vcf --weir-fst-pop AC1.txt --weir-fst-pop Ahb.txt --out cruentus1_vs_hybridus
vcftools --vcf amaranthus.vcf --weir-fst-pop AC1.txt --weir-fst-pop Ahp.txt --out cruentus1_vs_hypochondriacus
vcftools --vcf amaranthus.vcf --weir-fst-pop AC2.txt --weir-fst-pop AC3.txt --out cruentus2_vs_cruentus3
vcftools --vcf amaranthus.vcf --weir-fst-pop AC2.txt --weir-fst-pop Ahb.txt --out cruentus2_vs_hybridus
vcftools --vcf amaranthus.vcf --weir-fst-pop AC2.txt --weir-fst-pop Ahp.txt --out cruentus2_vs_hypochondriacus
vcftools --vcf amaranthus.vcf --weir-fst-pop AC3.txt --weir-fst-pop Ahb.txt --out cruentus3_vs_hybridus
vcftools --vcf amaranthus.vcf --weir-fst-pop AC3.txt --weir-fst-pop Ahp.txt --out cruentus3_vs_hypochondriacus
vcftools --vcf amaranthus.vcf --weir-fst-pop Ahb.txt --weir-fst-pop Ahp.txt --out hybridus_vs_hypochondriacus
