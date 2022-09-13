#!/usr/bin/env bash

TIMESTAMP=$(date -u "+%s")

# Things for this test.
readonly BASENAME="terratest-${TIMESTAMP}"
readonly LOGFILE="${BASENAME}.log"
readonly RESULTDIR="${BASENAME}/"

# Enable IAMLIVE data collection.
export AWS_CSM_ENABLED=true
export AWS_CSM_HOST=127.0.0.1
export AWS_CSM_PORT=31000

# Run background process to collect data from AWS tools.
ACCOUNT_ID=$(aws sts get-caller-identity | jq -Mr '.Account')
IAMLIVE_PID=$(
    iamlive \
        --background \
        --force-wildcard-resource \
        --output-file "${PWD}/required-permissions.policy.json" \
        --refresh-rate 1 \
        --sort-alphabetical \
        --account-id "$ACCOUNT_ID"
)

# Run the tests.
go test -v ./... -count 1 -timeout 30m -parallel 1 | tee "${LOGFILE}"
readonly TESTRESULT=${PIPESTATUS[0]}
terratest_log_parser -testlog "${LOGFILE}" -outputdir "${RESULTDIR}"
rm -f "${LOGFILE}"

# Disable IAMLIVE and write to disk.
kill "$IAMLIVE_PID"
unset AWS_CSM_ENABLED AWS_CSM_HOST AWS_CSM_PORT IAMLIVE_PID ACCOUNT_ID

sleep 3

# If Actions != null...
if [[ "$(jq -r '.Statement[0].Action' < "${PWD}/required-permissions.policy.json")" != "null" ]]; then
    # Generate Markdown/GFM version of the permissions.
    jq -r '["* `" , (.Statement[0].Action | join("`\n* `")) , "`"] | add' < "${PWD}/required-permissions.policy.json" > "${PWD}/required-permissions.md"
fi

exit ${TESTRESULT}
