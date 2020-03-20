# Usage: sh scaffold.sh <path> <number-of-problems>

path=$1
problems=$2

if [ ! -d "$path" ]; then
  mkdir -p "$path";
fi;

for ((i=1; i<=problems; i++)); do
  mkdir "$path/$i";
  cp $(dirname "$0")/solution.jl "$path/$i/solution.jl";
  touch "$path/$i/test.in";
done;

