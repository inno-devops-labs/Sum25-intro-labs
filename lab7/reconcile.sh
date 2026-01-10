#!/bin/bash
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
  echo "$(date) - DRIFT DETECTED! Reconciling..." >> reconcile.log
  cp desired-state.txt current-state.txt
fi
