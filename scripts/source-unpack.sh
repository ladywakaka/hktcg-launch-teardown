#!/bin/sh
# Decrypt and unpack the private source into ./hktcg-source (ignored by git).
# Needs the key in your macOS Keychain (item "hktcg-dashboard-source-key").
set -e
cd "$(dirname "$0")/.."
K="$(security find-generic-password -a hktcg-launch-teardown -s hktcg-dashboard-source-key -w)" \
  openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 \
  -in source/hktcg-source.tar.gz.enc -pass env:K | tar -xzf -
echo "Unpacked to ./hktcg-source. Rebuild with: cd hktcg-source && python3 build.py"
