#!/bin/bash

# SSH Commit Signing Setup Script
# This script helps automate the setup process for SSH commit signing

echo "=== SSH Commit Signing Setup ==="
echo ""

# Check if SSH key already exists
if [ -f ~/.ssh/id_ed25519.pub ]; then
    echo "✓ SSH key already exists at ~/.ssh/d_ed25519.pub"
    echo "Public key content:"
    cat ~/.ssh/id_ed25519.pub
    echo ""
else
    echo "❌ No SSH key found. Please generate one first:"
    echo "ssh-keygen -t ed25519 -C \"your_email@example.com\""
    echo ""
    read -p "Do you want to generate a new SSH key now? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your email address: " email
        ssh-keygen -t ed25519 -C "$email"
        echo ""
        echo "✓ SSH key generated successfully!"
        echo "Public key content:"
        cat ~/.ssh/id_ed25519.pub
        echo ""
    else
        echo "Skipping SSH key generation. Please run this script again after generating your key."
        exit 1
    fi
fi

# Configure Git for SSH signing
echo "Configuring Git for SSH commit signing..."
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgSign true
git config --global gpg.format ssh

echo "✓ Git configuration updated!"
echo ""

# Display current configuration
echo "Current Git signing configuration:"
echo "user.signingkey: $(git config --global user.signingkey)"
echo "commit.gpgSign: $(git config --global commit.gpgSign)"
echo "gpg.format: $(git config --global gpg.format)"
echo ""

echo "=== Next Steps ==="
echo "1. Copy your public key (shown above) to GitHub:"
echo "   → Go to GitHub Settings → SSH and GPG keys"
echo "   → Click 'New SSH key'"
echo "   → Paste your public key and save"
echo ""
echo "2. Test your setup with a signed commit:"
echo "   git commit -S -m \"Test signed commit\""
echo ""
echo "3. Verify your commit is signed:"
echo "   git log --show-signature -1"
echo ""

echo "Setup complete! 🎉" 