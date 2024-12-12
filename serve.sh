#!/usr/bin/env bash

PYTHON="python3"
VENV="venv"
WIKI="wiki"

# create & activate venv
echo "SDNext-Docs: launch"
if ! "${PYTHON}" -c "import venv" &>/dev/null; then
  echo "Error: python or venv not installed"
  exit 1
fi
if [[ ! -d "${VENV}" ]]; then
  echo "Create"
  "${PYTHON}" -m venv "${VENV}"
  INITIAL=1
fi
if [[ -f "${VENV}"/bin/activate ]]; then
  echo "Activate"
  source "${VENV}"/bin/activate
else
  echo "Error: venv cannot activate"
  exit 1
fi

# install requirements
if [[ ! -z ${INITIAL+x} ]]; then
  echo "Install"
  pip install uv
else
  echo "Verify"
fi
export UV_INDEX_STRATEGY=unsafe-any-match
uv pip install -r requirements.txt

# update wiki
if [[ ! -d "${WIKI}" ]]; then
  git clone https://github.com/vladmandic/automatic.wiki "${WIKI}"
else
  cd "${WIKI}"
  git pull
  cd ..
fi
if [[ ! -f "${WIKI}"/index.md ]]; then
  ln -s "${WIKI}"/HOME.md "${WIKI}"/index.md
fi

# serve docs
echo "Build"
mkdocs serve

echo "Done"
