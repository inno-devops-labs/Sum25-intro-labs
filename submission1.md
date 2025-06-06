# Merge Strategies Summary

## Strategies review

### Standard Merge

Creates a merge commit that shows when and why branches were merged.

**Pros**:
- Simple as felt boots
- Preserves the commit history of both branches
- Shows the merge moment clearly in the history

**Cons**:
- An additional merge commit appears (exculuding one case of fast-forward merge)
- The history can become complicated 


### Squash and Merge

All changes from the feature branch are concatenated ("squashed") into a single commit. The commit history of the feature branch is not preserved in target branch. 

**Pros**:
- Clean — one change/feature = one commit

**Cons**:
- Harder to track details of feature evolution
- Impossible to undo individual commits

### Rebase and Merge

Commits are moved from the feature branch to the target branch, with the changes applied on top of the target branch. The history becomes continuous. 

**Pros**:
- Clear continuous (linear) commit history without branching and merge commits
- The history is preserved — you can still track or undo small changes

**Cons**:
- More conflicts can occur when working in a team
- The SHA sums of commits change during the rebase, so if someone else is working on the branch, the history becomes inconsistent and you may even break the branch

## Conclusion

Each strategy may be useful in different scenarios, but Standard Merge seems to be the most practical choice in most cases. 

- **Squash and Merge** - useful when there are many small features, but each one contains many commits, or the commit history is messy. Also useful when there is no need to undo parts of the feature. 

- **Rebase and Merge** - may be useful for feature branch which is not shared, or with controlled history

- **Stangard Merge** - the most widely used and most stable strategy, suitable for almost all development cases. It preserves history, avoids excessive conflicts, and simply works.

~ Thank you for reading! ~