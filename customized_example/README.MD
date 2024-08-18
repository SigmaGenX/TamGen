# Customized example

We provide a customized example about how to generate compounds for a given pocket.

We choose the pdb `4xli`, which is used as an example in the [DiffDec](https://pubs.acs.org/doi/10.1021/acs.jcim.3c01466) paper.


## Steps

1. Go to folder `customized_example`

1. Download `4xli.cif` file into this folder. You can use `curl https://files.rcsb.org/download/4XLI.cif > 4xli.cif`

2. Use `get_drug_center_4xli.py` to get the ligand center. You can open this python script using vscode, and it will look like a jupyter notebook (due to the usage of `#%%`). You should get `4xli_out.csv`

3. Use `augment_smiles.py` to augment the SMILES of the reference ligand. This means that, given a SMILES string, we use different ways to represent it. Because we use sequence-based method, we can use it to increase diversity. This is used for conditional optimization. For unconditional generation, you do not need to use it. We also prepare a common scaffold list from the training dataset, and you can consider using them. They are in `misc/scaffold_smiles_top100.txt`

4. Build binary file `build_bindata_4xli.sh`. You should get a folder `4xli-bin/`

5. Go back to the TamGen repo folder, and run `time bash customized_example/generator-4xli.sh`. You should get the results in `customized_example/4xli-results`. It requires about 30 minutes, so using `tmux` is a better choice.

6. Go to `customized_example`. Run `post_process_4xli.py` to post process the outputs. You should get one `pkl` and one `_flatten.tsv`. `pkl` file has all the information, while the `tsv` file has two columns: first column is the SMILES, and the second column is the average normalized log probability. 