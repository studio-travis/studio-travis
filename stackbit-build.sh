#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e3fecf4e32af10019202eef/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e3fecf4e32af10019202eef 
fi
curl -s -X POST https://api.stackbit.com/project/5e3fecf4e32af10019202eef/webhook/build/ssgbuild > /dev/null
npm run build

curl -s -X POST https://api.stackbit.com/project/5e3fecf4e32af10019202eef/webhook/build/publish > /dev/null
