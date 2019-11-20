import os, sys

##--------------------------------------------------##
## OPTIONS

configfile: './config.json'
#localrules: create_readCountTableCurrent, create_readCountTableCompiled, compile_gwas_hit_results

# Get file names to download (VCF files and not their indeces)
vcf_files = []
downloads = dict()
with open(config['auxiliaryFiles']['vcf_download_list']) as in_file:
    next(in_file)
    for line in in_file:
        line = line.rstrip().split('\t')[0]
        vcf_files.append(os.path.basename(line))
        downloads[vcf_files[-1]]=line
        
vcf_files_no_index=[i for i in vcf_files if not 'tbi' in i]
            
##--------------------------------------------------##
## PIPELINE

rule all:
    input:
        # To download all files
        expand(os.path.join(config['vcf_out_dir'], '{file}'), file=vcf_files),
        # To convert to plink format
        expand(os.path.join(config['plink_files_out_dir'], '{prefix}.bed'), prefix = vcf_files_no_index),
        expand(os.path.join(config['plink_files_out_dir'], '{prefix}.bim'), prefix = vcf_files_no_index),
        expand(os.path.join(config['plink_files_out_dir'], '{prefix}.fam'), prefix = vcf_files_no_index) 
    shell:
        '''
        echo hola
        '''

rule convert_to_plink1:
    input:
        os.path.join(config['vcf_out_dir'], '{prefix}')
    params:
         os.path.join(config['plink_files_out_dir'], '{prefix}')
    output:
        os.path.join(config['plink_files_out_dir'], '{prefix}.bed'),
        os.path.join(config['plink_files_out_dir'], '{prefix}.bim'),
        os.path.join(config['plink_files_out_dir'], '{prefix}.fam')
    shell:
        '''
        plink --vcf {input} --make-bed --out {params}
        '''

rule download_vcf:
    params:
         lambda wildcards:  downloads[wildcards.file]
    output:
        os.path.join(config['vcf_out_dir'], '{file}')
    shell:
        '''
        wget {params} -O {output}
        '''
        
