# Git Merge Strategies Quick Reference

## Visual Comparison

### Standard Merge
```
Before:
main:     A---B---C
feature:    \---D---E

After:
main:     A---B---C-------F (merge commit)
feature:    \---D---E-----/
```

### Squash and Merge
```
Before:
main:     A---B---C
feature:    \---D---E

After:
main:     A---B---C---DE (single commit with D+E changes)
feature:    \---D---E (unchanged)
```

### Rebase and Merge
```
Before:
main:     A---B---C
feature:    \---D---E

After:
main:     A---B---C---D'---E' (commits D and E replayed)
feature:    \---D---E (unchanged)
```

## Command Comparison

| Strategy | GitHub UI | Command Line |
|----------|-----------|--------------|
| Standard Merge | "Create a merge commit" | `git merge feature-branch` |
| Squash and Merge | "Squash and merge" | `git merge --squash feature-branch` |
| Rebase and Merge | "Rebase and merge" | `git rebase main feature-branch` |

## When to Use Each Strategy

### ✅ Standard Merge - Best for:
- **Team collaboration** with multiple contributors
- **Feature branches** that need historical context
- **Long-running features** with multiple commits
- **Debugging** when you need to trace changes
- **Compliance** requirements for audit trails

### ✅ Squash and Merge - Best for:
- **Clean history** requirements
- **Small features** with many small commits
- **Work-in-progress** commits that clutter history
- **Release notes** that should show complete features

### ✅ Rebase and Merge - Best for:
- **Personal workflows** with individual branches
- **Linear history** preferences
- **Small changes** that don't need branch context
- **Repositories** with strict linear history policies

## Repository Settings Checklist

To enforce standard merge only:

- [ ] Go to repository Settings → Pull Requests
- [ ] ✅ Allow merge commits
- [ ] ❌ Allow squash merging
- [ ] ❌ Allow rebase merging

## Pro Tips

1. **Use descriptive merge commit messages** for standard merges
2. **Squash locally** before pushing if you want clean history without losing branch context
3. **Never rebase shared branches** - only rebase personal feature branches
4. **Consider branch protection rules** to enforce your chosen strategy
5. **Document your team's merge strategy** in your repository's README 