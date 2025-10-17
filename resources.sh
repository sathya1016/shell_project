#!/usr/bin/env bash
# resources.sh - List AWS resources (EC2, S3, IAM)
# Author : Sathya
# Date   : 2025-10-17
# Version: 1.1
#
# Usage:
#   ./resources.sh [--all] [--ec2] [--s3] [--iam] [--profile NAME] [--region REGION] [--debug]
#
# Examples:
#   ./resources.sh --all --profile myprofile --region us-east-1
#   ./resources.sh --ec2 --debug

set -euo pipefail
IFS=$'\n\t'

SCRIPT_NAME="$(basename "$0")"
PROFILE="${AWS_PROFILE:-}"
REGION="${AWS_REGION:-}"
DEBUG=false

log()   { printf '%s\n' "$*"; }
err()   { printf '%s\n' "ERROR: $*" >&2; }
die()   { err "$*"; exit 1; }
debug() { $DEBUG && printf 'DEBUG: %s\n' "$*" >&2; }

usage() {
    cat <<EOF
$SCRIPT_NAME - List AWS resources
Options:
    --all           Run all checks (EC2, S3, IAM)
    --ec2           List EC2 instances
    --s3            List S3 buckets
    --iam           List IAM users
    --profile NAME  Use AWS CLI profile NAME (overrides AWS_PROFILE)
    --region NAME   Use region (overrides AWS_REGION)
    --debug         Enable debug output
    --help          Show this help
EOF
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || die "Required command '$1' not found. Please install it."
}

check_aws_credentials() {
    if ! aws sts get-caller-identity ${PROFILE:+--profile "$PROFILE"} >/dev/null 2>&1; then
        die "Unable to get AWS identity. Check credentials and profile (profile='$PROFILE')."
    fi
}

list_ec2() {
    debug "Listing EC2 instances (profile='$PROFILE' region='$REGION')"
    aws ec2 describe-instances ${PROFILE:+--profile "$PROFILE"} ${REGION:+--region "$REGION"} --output json \
        | jq '[.Reservations[].Instances[].InstanceId ]
}

list_s3() {
    debug "Listing S3 buckets (profile='$PROFILE')"
    # aws s3 ls does not accept --region; keeping it simple
    aws s3 ls ${PROFILE:+--profile "$PROFILE"} --output json 2>/dev/null || \
        aws s3api list-buckets ${PROFILE:+--profile "$PROFILE"} --query 'Buckets[].{Name:Name,CreationDate:CreationDate}' --output json
}

list_iam() {
    debug "Listing IAM users (profile='$PROFILE')"
    aws iam list-users ${PROFILE:+--profile "$PROFILE"} --output json \
        | jq '[.Users[] | {UserName,UserId,CreateDate,Arn}]'
}

# Parse args
if [[ $# -eq 0 ]]; then
    usage
    exit 0
fi

DO_EC2=false
DO_S3=false
DO_IAM=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --all) DO_EC2=true; DO_S3=true; DO_IAM=true; shift ;;
        --ec2) DO_EC2=true; shift ;;
        --s3)  DO_S3=true; shift ;;
        --iam) DO_IAM=true; shift ;;
        --profile) PROFILE="$2"; shift 2 ;;
        --region)  REGION="$2"; shift 2 ;;
        --debug) DEBUG=true; shift ;;
        -h|--help) usage; exit 0 ;;
        *) err "Unknown argument: $1"; usage; exit 2 ;;
    esac
done

# Safety checks
require_command aws
require_command jq
check_aws_credentials

# Execute requested actions
if $DO_EC2; then
    log "EC2 Instances:"
    list_ec2
fi

if $DO_S3; then
    log "S3 Buckets:"
    list_s3
fi

if $DO_IAM; then
    log "IAM Users:"
    list_iam
fi