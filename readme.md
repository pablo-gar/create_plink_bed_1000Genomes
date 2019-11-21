###Pipeline to download and create pinkv1.9 input files from the 1000 genomes CEU population.

## Requires
- snakemake 
- plink v1.9

## Set up
Modify `config.json` in the following fieds to your desired output folders:
```json
    "vcf_out_dir" : "<insert path>",
    "plink_files_out_dir" : "<insert path>"
```

First folder will contain the vcf files from 1000 genomes -- [these files](https://github.com/pablo-gar/create_plink_bed_1000Genomes/blob/master/data/igsr_Utah_residents_CEPH_with_Northern_and_Western_Europea_ancestry_undefined.tsv).
Second folder will contain the plink input files.

## Run
To run with 8 cores
```bash
snakemake --cores 8
```
