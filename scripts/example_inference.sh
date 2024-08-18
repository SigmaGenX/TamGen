beam=20     # the beamsize of decoding
beta=1.0    # the beta of the VAE
seed=42     # the random seed used for decoding

DATAPATH="data/crossdocked/bin/"
CKPTPATH="/home/yinxia/blob1.v2/v-kehanwu/TamGent/model/crossdocked_model/checkpoint_best.pt"
CKPTPATH="/home/yinxia/S/TamGen/xxx111-fp16/checkpoint_best.pt"

tmpfile=$(mktemp tmpout_file.XXXXXX)
outF="output.csv"
outF="output2.csv"

python generate.py \
$DATAPATH \
-s tg -t m1 \
--task "translation_coord" \
--path $CKPTPATH \
--gen-subset "test" \
--beam $beam --nbest $beam --max-tokens 1024 \
--seed $seed --sample-beta $beta \
--use-src-coord > $tmpfile

python scripts/format_output.py $tmpfile $outF 
rm $tmpfile