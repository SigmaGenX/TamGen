## you need to first give a name of your environment

conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.3 -c pytorch -y
conda install pyg -c pyg -y
conda install pytorch-cluster -c pyg -y
pip install rdkit-pypi
pip install tensorboardX
pip install einops
pip install ipykernel

python -m pip install -e .[chem]
