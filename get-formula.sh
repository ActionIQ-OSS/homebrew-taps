#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ $# -eq 0 ]]; then
  echo "Pull down latest homebrew formula"  
  echo
  echo "Usage: $0 <name>"
  echo "  e.g $0 packer"
  exit
fi

base_dir=$(cd "$(dirname "$0")" && pwd)
formula_dir=$base_dir/Formula

echo $1

curl https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/$1.rb -o /tmp/$1.rb
# Add a line to the formula to make brew download from the correct root url
# Otherwise it adds the name of the tap repo to the URL, which gives brew a 404
awk '/bottle do/ { print; print "    root_url \"https://homebrew.bintray.com/bottles\""; next }1' /tmp/$1.rb > $formula_dir/$1.rb
