# I set two pockets, one is 10A, the other is 12A
for thr in "10" "12"; do
python ../scripts/build_data/prepare_pdb_ids_center_scaffold.py \
4xli_out.csv test \
-o 4xli-bin/t$thr -t $thr \
--scaffold-file 'seed_cmpd_4xli.txt' \
--pdb-path "./"
done