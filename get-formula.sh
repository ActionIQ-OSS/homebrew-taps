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

pushd $formula_dir &>/dev/null
curl https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/$1.rb -o $1.rb
popd &>/dev/null
