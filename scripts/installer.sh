SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Getting dependencies"

if [[ $(uname -s) == "Darwin" ]]; then
 SUFFIX="-mac"
fi

"$SCRIPT_DIR/dependency-installer${SUFFIX}.sh"

echo "Installing NoobVim"
"$SCRIPT_DIR/noobvim-installer.sh"
