cat > reconcile.sh << 'EOF'
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
    echo "$(date) - DRIFT DETECTED! Reconciling..."
    cp desired-state.txt current-state.txt
fi
