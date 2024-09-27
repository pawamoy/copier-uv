#!/usr/bin/env bash
echo "Fetching previous run number..."
previous_run=$(gh run list --repo pawamoy/pawamoy-testing --branch 0.1.0 --limit 1 --workflow "ci.yml" --json number --jq ".[0].number")

echo "Resetting project's Git history..."
rm -rf tests/tmp/*
make reset-history
cd tests/tmp || exit 1

wait_time=20
echo "Waiting project's workflow completion (${wait_time}s iterations)..."
while true; do
    if output=$(gh run list --repo pawamoy/pawamoy-testing --branch 0.1.0 --limit 1 --workflow "ci.yml" --json number,status,conclusion); then
        number=$(jq -r ".[0].number" <<< "$output")
        if [ "${number}" -gt "${previous_run}" ]; then
            status=$(jq -r ".[0].status" <<< "$output")
            if [ "${status}" = "completed" ]; then
                conclusion=$(jq -r ".[0].conclusion" <<< "$output")
                echo "Workflow completed: ${conclusion}"
                if [ "${conclusion}" = "success" ]; then
                    break
                else
                    exit 1
                fi
            else
                echo "Workflow status: ${status}"
            fi
        else
            echo "Workflow not created"
        fi
    else
        echo "Workflow not created"
    fi
    sleep ${wait_time}
done

echo "Deleting all testing releases..."
for tag in $(gh release list --repo pawamoy/pawamoy-testing --json tagName --jq ".[].tagName"); do
    gh release delete "${tag}" --repo pawamoy/pawamoy-testing --yes --cleanup-tag || true
done