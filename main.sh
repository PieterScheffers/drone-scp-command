#!/bin/sh

set -e

# https://linux.die.net/man/1/scp

# usage: scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
#            [-l limit] [-o ssh_option] [-P port] [-S program]
#            [[user@]host1:]file1 ... [[user@]host2:]file2

# PLUGIN_KEY <required>
# PLUGIN_PUBLIC_KEY <required>
# PLUGIN_PORT <default: 22>
# PLUGIN_SOURCE <required>
# PLUGIN_TARGET <required>
# PLUGIN_RECURSIVE <default: true>
# PLUGIN_COMPRESSION <default: true>
# PLUGIN_PRESERVE_TIMESTAMPS <default: true>

echo "Current working dir: $PWD"
echo
echo "ENVIRONMENT VARIABLES: "
echo
printenv
echo
echo
echo

# create ssh key file
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "$PLUGIN_KEY" | tee ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

recursive="-r"
if [ "$PLUGIN_RECURSIVE" != "false" ] ; then
    recursive=""
fi

compression="-C"
if [ ! "$PLUGIN_COMPRESSION" != "false" ] ; then
    compression=""
fi

preserve_timestamps="-p"
if [ ! "$PLUGIN_PRESERVE_TIMESTAMPS" != "false" ] ; then
    preserve_timestamps=""
fi

port="-P ${PLUGIN_PORT:-22}"

verbose="-vvv"
batch_mode="-B"
identity_file="-i ~/.ssh/id_rsa"
skip_host_validation="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# sshpass

echo "Command: scp $identity_file $recursive $verbose $preserve_timestamps $compression $batch_mode $port $skip_host_validation $PLUGIN_SOURCE $PLUGIN_TARGET"
scp $identity_file $recursive $verbose $preserve_timestamps $compression $batch_mode $port $skip_host_validation $PLUGIN_SOURCE $PLUGIN_TARGET
