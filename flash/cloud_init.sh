#!/usr/bin/env bash

SSH_KEY_FILE="$HOME/.ssh/rpic.pub"

NODE_NUM=$1
if [ -z "$NODE_NUM" ]; then
  echo "Usage: $0 <node-number>"
  exit 1
fi

if [ ! -f "$SSH_KEY_FILE" ]; then
  echo "SSH key file not found: $SSH_KEY_FILE"
  exit 1
fi

SSH_KEY=$(cat "$SSH_KEY_FILE")

BOOT_MOUNT="/Volumes/system-boot"

if [ ! -d "$BOOT_MOUNT" ]; then
  echo "Could not find boot partition at $BOOT_MOUNT"
  exit 1
fi

sed \
  -e "s|{{SSH_KEY}}|$SSH_KEY|" \
  -e "s|{{NODE_NUM}}|$NODE_NUM|" \
  user-data.template > "$BOOT_MOUNT/user-data"

echo "Configured rpic-$NODE_NUM"
