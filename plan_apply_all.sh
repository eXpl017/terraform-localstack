#!/usr/bin/env bash

expected_dir="/home/witguy10/terraform-prac"

if [[ "$PWD" != "${expected_dir}" ]]; then
    printf "Please run script from %s\n" "${expected_dir}"
    exit 1
fi

AUTO_APPROVE=0

mkdir -p "${expected_dir}"/plan

function show_help {
    printf "Usage: $(basename "$0") [OPTIONS]\n"
    printf "OPTIONS:\n"
    printf "\t-h\t\tshow this help\n"
    printf "\t-a\t\tauto-approve all, no plan generated\n"
}


function tf_plan {
    terraform -chdir="$1" init
    terraform -chdir="$1" plan -out "${expected_dir}/plan/$1_plan"
    printf "Plan file present in %s/plan directory\n" "${expected_dir}"
}


function tf_apply {
    if [[ $AUTO_APPROVE -eq 1 ]]; then
        printf "Auto-approve specified\nInitializing and applying terraform config for %s" "$1"
        terraform -chdir="$1" init
        terraform -chdir="$1" apply -auto-approve
    else
        printf "Creating plan for %s\n" "$1"
        tf_plan "$1"
        read -rp "Apply config for $1? (Y/n) " confirm
        case ${confirm:0:1} in
            y|Y|"")
                printf "Applying config\n"
                terraform -chdir="$1" apply "plan/$1_plan"
                ;;
            n|N) printf "Aborting, did not apply config for %s\n" "$1" ;;
            *)
                printf "Unknown input, exiting\n"
                exit 1
                ;;
        esac
    fi
    printf "=%.0s" {1..20}
}


printf "Script to apply terraform config from all tasks\n"

while getopts "ha" opt; do
    case $opt in
        h) show_help; exit 0 ;;
        a) AUTO_APPROVE=1 ;;
        *) show_help; exit 1 ;;
    esac
done

task_dirs=(task*)

for dir in "${task_dirs[@]}"; do
    tf_apply "$dir"
done

