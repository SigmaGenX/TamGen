# TamGen

Target-aware Molecule Generation for Drug Design Using a Chemical Language Model

# Introduction

Code base: [fairseq-v0.8.0](https://github.com/facebookresearch/fairseq)

Fairseq(-py) is a sequence modeling toolkit that allows researchers and
developers to train custom models for translation, summarization, language
modeling and other text generation tasks.

# Installation

```bash
conda create -n TamGen python=3.9
conda activate TamGen

bash setup_env.sh
```

# Dataset

## Build customized dataset

You can build your customized dataset through the following methods:

1. Build customized dataset based on pdb ids, the script will automatically find the binding sites according to the ligands in the structure file.

   ```bash
   python scripts/build_data/prepare_pdb_ids.py ${PDB_ID_LIST} ${DATASET_NAME} -o ${OUTPUT_PATH} -t ${threshold}
   ```

   `PDB_ID_LIST` format: CSV format with columns ([] means optional):

   `pdb_id,[ligand_inchi,uniprot_id]`
2. Build customized dataset based on pdb ids using the center coordinates of the binding site of each pdb.

   ```bash
   python scripts/build_data/prepare_pdb_ids_center.py ${PDB_ID_LIST} ${DATASET_NAME} -o ${OUTPUT_PATH} -t ${threshold}
   ```

   `PDB_ID_LIST` format: CSV format with columns ([] means optional):

   `pdb_id, center_x, center_y, center_z, [uniprot_id]`
3. Build customized dataset based on pdb ids using the center coordinates of the binding site of each pdb, and add the provided scaffold to each center

   ```bash
   python scripts/build_data/prepare_pdb_ids_center_scaffold.py ${PDB_ID_LIST} ${DATASET_NAME} -o ${OUTPUT_PATH} -t ${threshold} --scaffold-file ${SCAFFOLD_FILE}
   ```

   `PDB_ID_LIST` format: CSV format with columns ([] means optional):

   `pdb_id, center_x, center_y, center_z, [uniprot_id]`
4. Build dataset from PDB ID list using the residue ids(indexes) of the binding site of each pdb.

   ```bash
   python scripts/build_data/prepare_pdb_ids_res_ids.py ${PDB_ID_LIST} ${DATASET_NAME} -o ${OUTPUT_PATH} --res-ids-fn ${RES_IDS_FN}
   ```

   `PDB_ID_LIST` format: CSV format with columns ([] means optional):

   `pdb_id,[uniprot_id]`

   `RES_IDS_FN` format: residue ids filename, a dict like:

   ```python
   {
     0:
       {
         chain_id_A: Array[res_id_A1, res_id_A2, ...],
         chain_id_B: Array[res_id_B1, res_id_B2, ...],
         ...
       },
     1:
       {
         ...
       },
     ...
   }  
   ```

   stored as pickle file. The order is the same as `PDB_ID_LIST`.

   For customized pdb strcuture files, you can put your structure files to the `--pdb-path` folder, and in the `PDB_ID_LIST` csv file, put the filenames in the `pdb_id` column.

# Model
The checkpoint can be found in the provided url from the paper. You should unzip it, and place it under the folder `TamGen/`


# Run scripts

```bash
# train a new model
bash scripts/train.sh -D ${DATA_PATH} --savedir ${SAVED_MODEL_PATH}

# generate molecules
bash scripts/generate.sh -b ${BEAM_SIZE} -s ${SEED} -D ${DATA_PATH} --dataset ${TESTSET_NAME} --ckpt ${MODEL_PATH} --savedir ${OUTPUT_PATH}

```

# Results

The generated compounds, docking score and related analysis can be find in `compare_different_methods.ipynb`

# Demo

We provide a demo at `interactive_decode.ipynb`

In the first cell of the demo 
```
from TamGen_Demo import TamGenDemo, prepare_pdb_data
import os

os.environ["CUDA_VISIBLE_DEVICES"] = "0"

worker = TamGenDemo(
    data="./TamGen_Demo_Data",
    ckpt="checkpoints/crossdock_pdb_A10/checkpoint_best.pt"
)
```

- Specify the GPU id
- Download the checkpoint and place it into "checkpoints/crossdock_pdb_A10/checkpoint_best.pt" or your specificied position
- Download the pre-trained GPT model and put it into the folder `gpt_model`
