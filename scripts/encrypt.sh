#!/bin/sh
# Encrypt an updated dashboard page into src/dashboard.html.enc.
# Usage: scripts/encrypt.sh path/to/index.html
# The key is read from the macOS Keychain (item "hktcg-dashboard-source-key")
# and must match the SOURCE_KEY repository secret.
set -e
[ -f "$1" ] || { echo "Usage: $0 path/to/index.html"; exit 1; }
K="$(security find-generic-password -a hktcg-launch-teardown -s hktcg-dashboard-source-key -w)" \
  openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 -salt \
  -in "$1" -out "$(dirname "$0")/../src/dashboard.html.enc" -pass env:K
echo "Encrypted to src/dashboard.html.enc. Commit and push to publish."
