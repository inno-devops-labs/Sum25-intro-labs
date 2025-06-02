1) For the first part of the task, I created an SSH key using the ed25519 algorithm. I added the public key to my GitHub account with the option to sign commits enabled. I configured Git to sign commits using SSH by setting the gpg format and the signing key. The SSH key was also added to the ssh-agent. After this setup, I made a commit using the --gpg-sign option and pushed it to GitHub. The commit was shown as unverified on the GitHub interface, but all the steps required by the assignment were followed correctly.

2) In the second part of the task, I studied three different merge strategies in Git: standard merge, squash merge, and rebase merge. The standard merge creates a separate merge commit that joins the feature branch with the main branch. It keeps the full history of commits and makes it clear when and how each feature was added. The downside is that the history can get cluttered with many merge commits. Still, this method is recommended by Atlassian for team projects because it helps with traceability and understanding the development process.

The squash merge takes all the commits from a feature branch and combines them into a single commit before merging. This makes the history look cleaner and more compact, but it removes the details of individual commits and their messages. It can also replace contributions from multiple authors with just one summary. This method works best for simple or isolated changes.

The rebase merge takes all commits from the feature branch and reapplies them on top of the main branch. It also produces a clean linear history, but it rewrites the commit history, which can be risky if the branch is shared. It’s more suitable for local work before opening a pull request.

To complete the task, I configured the GitHub repository settings to allow only standard merge commits. Squash and rebase merging were both disabled. This way, the full history is preserved, and each integration is recorded clearly, which is better for collaboration and later review.

Sources I used for this part of the assignment included GitHub documentation and Atlassian’s Git tutorials.
