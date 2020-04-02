# Usage: sh scaffold.sh <path> <number-of-problems>

path=$1
problems=$2

if [ ! -d "$path" ]; then
  mkdir -p "$path";
fi;

for ((i=1; i<=problems; i++)); do
  mkdir "$path/$i";
  cp $(dirname "$0")/solution.jl "$path/$i/solution.jl";
  cp $(dirname "$0")/test.jl "$path/$i/test.jl";
  cp $(dirname "$0")/interactive_runner.py "$path/$i/interactive_runner.py";
  touch "$path/$i/test.in";
done;

