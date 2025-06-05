# Task 1: SSH Commit Signature Verification
## Benefits of signing commits
In general it is a case of verification.

- As mentioned on lab, signed commits are nowaays acknowledged as proof of authorship ever since the lawsuit between Linus Torwalds and Microsoft (if I remember correctly, could not find the lawsuit in question)
- Acts as a form of 2FA. Supposedly there is a trivial author spoofing possible due to Git's design via `git config user.email/name` [highlighted by Mike Gerwitz in 2012](https://mikegerwitz.com/2012/05/a-git-horror-story-repository-integrity-with-signed-commits). An additional verification via an SSH key used for signature helps ounteract that.
- (Anecdotally) GDPR regulation suggests commit signing as a standard way of signing off authorship. UK Government also requires that [all commits must be signed by the author](https://engineering.homeoffice.gov.uk/standards/signing-code-commits/#all-code-commits-must-be-cryptographically-signed-by-the-author-of-that-commit).
## SSH Key Generation
I did generate it, but I am not showing it because sources tell I shouldn't share anything about my keys.
## Making a Signed Commit
The commit with which this document was pushed is signed.