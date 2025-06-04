# Task 1 -- ssh commit signature verification

## 1 Benefits of Signing Commits

In short: signing commits keeps things secure and trustworthy in Git.

Signing commits is basically putting a digital stamp on your code using a GPG, SSH, or S/MIME key.

SSH is the easiest -- you just point Git at your public key. GPG takes a bit more work, and S/MIME is usually for bigger orgs. Once you push to GitHub or Bitbucket, any commit with a valid signature gets a Verified badge so everyone knows it's legit. Even if you rotate or revoke your key, GitHub keeps a permanent record of this original verification, so the commit stays trusted.

Signed commits build trust in teams and opensource projects -- because you can enforce it so that only the signed commits are allowed on protected branches. And since only you have your private key, you can't say, "that wasn't me". Signed commits help to know exactly who made each change, and the repo can block anything that isn't verified.

## 2 Set up SSH Commit signing

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB67Ef.../QMwAzZpGnN.../TR... decter49pro@gmail.com

didnt work for the 1st commit, so I'm trying again

tried adding the gpg allowed signers:

mkdir -p ~/.gnupg
touch ~/.gnupg/allowed_signers
chmod 600 ~/.gnupg/allowed_signers

git config --global gpg.format ssh
git config --global user.signingkey /Users/aladdinych/.ssh/id_ed25519.pub
git config --global gpg.ssh.allowedSignersFile ~/.gnupg/allowed_signers
git config --global commit.gpgSign true

still didnt work

фыв
test123
asdfasd

# Task 2 -- merge strategies