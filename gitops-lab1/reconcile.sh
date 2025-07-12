#!/bin/bash
DESIRED=$(<desired-state.txt)
CURRENT=$(<current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
  echo "$(date -u '+%a %b %d %T UTC %Y') - DRIFT DETECTED! Reconciling..."
  cp desired-state.txt current-state.txt
else
  echo "$(date -u '+%a %b %d %T UTC %Y') - OK"
fi
