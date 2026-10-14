#!/bin/sh
# Re-encrypt ./hktcg-source into source/hktcg-source.tar.gz.enc after you change it.
# Also refreshes src/dashboard.html.enc from hktcg-source/index.html if you rebuilt it.
set -e
cd "$(dirname "$0")/.."
[ -d hktcg-source ] || { echo "Run scripts/source-unpack.sh first."; exit 1; }
K="$(security find-generic-password -a hktcg-launch-teardown -s hktcg-dashboard-source-key -w)"
if [ -f hktcg-source/index.html ]; then
  K="$K" openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 -salt \
    -in hktcg-source/index.html -out src/dashboard.html.enc -pass env:K
  echo "Updated src/dashboard.html.enc from hktcg-source/index.html"
fi
COPYFILE_DISABLE=1 tar --exclude='index.html' --exclude='artifact.html' --exclude='__pycache__' -czf - hktcg-source | \
  K="$K" openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -md sha256 -salt -out source/hktcg-source.tar.gz.enc -pass env:K
echo "Updated source/hktcg-source.tar.gz.enc. Commit and push to save it."
