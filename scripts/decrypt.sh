#!/bin/sh
# Decrypt src/dashboard.html.enc to build/index.html for local editing.
set -e
cd "$(dirname "$0")/.."
mkdir -p build
K="$(security find-generic-password -a hktcg-launch-teardown -s hktcg-dashboard-source-key -w)" \
  openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 \
  -in src/dashboard.html.enc -out build/index.html -pass env:K
echo "Decrypted to build/index.html (ignored by git)."
