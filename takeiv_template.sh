# iv_curve template script
# Usage: ./takeiv_template.sh [temperature in mK] [datamode] [run number] [show plots (0/1)]
# Example: ./takeiv_template.sh 300 1 1 1
temp=${1:-250} # temperature for reference in mK
datamode=${2:-1} # usually only uses 0, 1 and 10 
runN=${3:-1} # suffix run number, or string
show=${4:-0}

# Change lcname every time you run something
lcname="LC_light_FPU_"$temp"mK_datamode"$datamode"_run"$runN
lcfullpath="/data/cryo/current_data/"$lcname
lcplots=$lcfullpath"/"

# Take iv curve
./ivcurve.py \
  --dataname $lcname \
  --columns 0 4\
  --bias_start 65535 \
  --bias_step -32 \
  --bias_count 2049 \
  --bias_pause 0.02 \
  --bias_final 0 \
  --data_mode $datamode \
  --zap_bias 65535 \
  --zap_time 10 \
  --settle_time 5.0 \
  --settle_bias 65535 \
#  --cooling_time 3600 \
#  --temp $temp
#  --runN $runN

# Produce plots
./showiv.py $lcfullpath

# Show plots
if [ $show -eq 1]; then
  eog $lcplots*.png &
fi

# Titanium
#  --bias_start 10000 \
#  --bias_step -10 \
#  --bias_count 1001 \
#  --zap_bias 10000 \
#  --zap_time 1.0 \

# Aluminum
#  --bias_start 65000 \
#  --bias_step -100 \
#  --bias_count 651 \