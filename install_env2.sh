## you need to first give a name of your environment

conda install pytorch==2.3.0 pytorch-cuda=12.1 -c pytorch -c nvidia
pip install torch_geometric
pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.3.0+cu121.html
pip install rdkit==2024.03.1
pip install tensorboardX
pip install einops
pip install ipykernel

python -m pip install -e .[chem]

pip -y uninstall numpy
pip install numpy==1.26.4
pip install pandas