# Completion Report "Lab 1: Introduction to DevOps using Git"

## Task 1: Verifying the SSH commit signature

To complete the task, the xubuntu 24.04 virtual machine was raised on Oracle VirtualBox

1. **Examine the importance of signed commits**:

The importance of signed commits was studied for the assignment. A brief description explaining the benefits of signing commits is located in the following file submission1.md .

2. **Set up SSH signing of commits.**:

The command was executed using the ed25519 format

```
ssh-keygen -t ed25519
```

![image](https://github.com/user-attachments/assets/b88debd7-b067-483b-b1ed-6a4017278d63)

and uploaded to your GitHub account

![image](https://github.com/user-attachments/assets/dd9fef10-2d4d-4360-80b0-6905c3eeb25f)

Now further execution will occur using a local change from commit to git.

The command to clone the repository was executed using the command

```
git clone git@github.com:Kulikova-A18/Sum25-intro-labs.git
```

![image](https://github.com/user-attachments/assets/ee1cbf6a-73a3-4b25-a218-74b75c2fdcef)


The command was executed for git to use the SSH key to sign commits (SSH key replaced with *****)

```
vboxuser@xubu:~/Sum25-intro-labs$ git config --global user.signingkey "ssh-ed25519 ********* vboxuser@xubu"
vboxuser@xubu:~/Sum25-intro-labs$ git config --global commit.gpgSign true
vboxuser@xubu:~/Sum25-intro-labs$ git config --global gpg.format ssh
```

3. **Create a signed commit**:

```
git commit -S -m "My signed commit message"
```

![image](https://github.com/user-attachments/assets/089c70ab-6e3f-4ca8-89b3-412da15d7497)

Check

![image](https://github.com/user-attachments/assets/eac4736e-4d35-4dba-ab57-4a1dfe3c5623)

## Task 2: Merge strategies in Git

1. **Explore merger strategies:**

The short description is located in the following file submission1.md .

2. **Change the repository settings**:

Disabling squash and re-merging in the "Options" section of the repository on GitHub

![image](https://github.com/user-attachments/assets/cdc1cce3-65f5-4f06-aca3-695d68a40cb2)

## Information about the author

The report was made by Kulikova Alyona specifically for "Integration and automation of the software development process (advanced course)".

If you have any questions or suggestions for improvement, do not hesitate to contact us!

Link to git: https://github.com/Kulikova-A18
