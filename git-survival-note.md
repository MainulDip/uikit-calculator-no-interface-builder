# Git Notes:

First: on new os set the git’s global config 

- `git config --global user.name <name>`  && `git config --global user.email <email@whatever.com>`
- `git config --list --global` to check if those are set correctly

`git index` is another name for `staged.`  `git add .` will add everything to the index/staged

`git push -u origin a-branch-name` will establish a tracking connection with local & remote. So subsequent push/pull will not requires mentioning branch name

`HEAD` is the current active pointer. This can point to the current branch (the tip/last-commit) or point to a older commit id/sha other than a branch ( the tip/last commit of the current branch ). This pointing to an older commit other than a branch is know as `detached HEAD` state, this happens usually with `git checkout <older-commit-id-or-hash>` command. Checking out to a branch `git checkout <a-branch-name>` will resolve the `detached head`  issue

Branch:

- create a branch using `git branch <newBranchName>`
- rename current HEAD branch `git branch -m new-branch-name`
- rename any branch `git branch -m old-branch-name new-branch-name`
- rename remote branch `git push origin --delete old-branch-name` + `git push -u origin new-branch-name`
- publish a local branch to remote `git push -u origin a-local-branch`
- pull a remote branch `git branch --track branch-name origin/branch-name` or `git checkout --track origin/branch-name`
- `git branch -v` for branch status in comparison with the remote branch, it will show ahed (local commits that not yet been pushed to remote) and behind (remote commits that not yet been pull to local) commits.
- create branch and checkout (make it current/HEAD branch) by `git checkout -b <newBranchName>`
    - `git checkout <older-commit-id-or-hash>` to move the HEAD pointer to a prev state (detached head)
    - `git checkout master^^` to move HEAD 2 commit back from current (detached head)
- create branch from a specific commit `git branch <newBranchName> <commit-id`
- new alternative to git’s `checkout` command to change HEAD to a different branch is `switch`
    - use `git switch <otherBranchName>` as it’s more specific than the ambiguous `checkout`
    - `checkout` is used for so many things, ie, `set HEAD to a previous commit`
- delete a branch (cannot delete a head/current branch)
    - local branch deletion `git branch -d branch-name-to-delete`
    - remote branch deletion `git push origin --delete branch-name-to-delete`
- merging a branch with `merge`: `git checkout/switch master` && `git merge branch-name`
    - merging with `merge` will create a merge commit. So if conflict arises, it will prompt, and the conflicted file/s will be merged with `>>>>>> branch-name <code> ==== <code> <<<<<<< other-branch-name` marking. See the conflicted file/s by `git status` and see what codes are causing this by `cat <conflicted-filename-shown-by-git-status` and look for the conflicting markings and later edit on code editor manually. Then run `git add .` and `git commit -m "merge-commit-message"`. The merge commit can also be aborted by `git merge --aborted`
    - a branch can also `merge` the master branch (use rebase instead) : `git switch other-branch` && `git marge master`
    - merging with `--squash` flag `git merge --squash <branch-name>` will squeeze all commit’s of that branch and put those changes into the staging area of the working/master branch. From there test the app if its working as expected, then do `git commit ...`
- merging branch with `rebase`:  (while HEAD is on other-branch)`git rebase master` or (while HEAD is on master) `git rebase other-branch`
    - `git rebase master-or-any-other-branch`(while HEAD on other-branch) will update/sync the other-branch with master (if any conflict arise, it will prompt for resolution), like the first commit of the other branch will be updated with the last commit of the local master branch.
    - `git rebase other-branch` (while HEAD on master branch) will mount the other-branch on the last commit of the master branch
    - `rebase` will rebase the branch at the HEAD and move the HEAD to the last commit of the rebased branch (like, the other branch with all its commit history will be put at the tip of the master/working branch).
    - rebase will not create a merge commit like the `git merge <branch-name>` cmd
- comparing commits between branches
    - compare between local main and another-branch `git log main..another-branch`
    - compare remote main and local main `git log origin/main..main`

Git Merge Conflict Resolution:

- `git log --merge --online` to see what commits are conflicting
- merging with `merge` will create a merge commit. So if conflict arises, it will prompt, and the conflicted file/s will be merged with `>>>>>> branch-name <code> ==== <code> <<<<<<< other-branch-name` marking. See the conflicted file/s by `git status` and see what codes are causing this by `cat <conflicted-filename-shown-by-git-status` and look for the conflicting markings and later edit on code editor manually. Then run `git add .` and `git commit -m "merge-commit-message"`. The merge commit can also be aborted by `git merge --aborted`

Stash:

- `git stash` to save uncommitted code ( stash means `store something safely and securely`
    - `git stash list` to see all the stashed/stored code
    - `git stash apply` to apply stashed code to HEAD, but not clean the stash container
    - `git stash pop` to apply and clean.
    - `git stash apply @stash{<stashNumber>}` and `git stash pop @stash{<stashNumber>}` for specific stash
    - adding stashed code to the last commit `git add -u` (update index/staged) > `git commit --amend` > `git stash pop`

Reset vs Revert:

`git reset [--soft/hard/mixed] <commit-id/sha>` 

—soft : undo all commits between head and commit id/sha, keep those in staged/index and move head to the specified commit-id/sha

—hard (dangerous) discards all changes between head and the specified commit. If no commit id is specified, it will discard all changes/modification after the last commit.

—mixed default option, same as —soft but will not keep changes in staged. So it needs `git add .` after that

`revert` to make a new commit reverting the mention commit. It’s a safe and easy way to rollback to a previous state, no commit history will be deleted (reset will delete commits up-to mentioned commit). 

- `git revert --no-commit 0d1d7fc3..HEAD` to revert everything from the HEAD back to the commit hash (—no-commit will skip prompt for every reverted commit) && `git commit` && `git push`
- but if there is a merge commit in between `0d1d7fc3..HEAD` , `git revert` will require some extra steeps, ie,`git revert -m 1 HEAD` where HEAD is the tip after merging, see https://stackoverflow.com/questions/5970889/why-does-git-revert-complain-about-a-missing-m-option

`git diff --staged` 

`git log` & `git reflog` (reference log). Reflog will display any change which updated the `HEAD` and checking out the desired reflog entry will set the `HEAD` back to this commit. Every time the HEAD is modified/moved there will be a new entry in the **`reflog`.** 

- workflow : `git reflog` > `git checkout HEAD{<number>}`.......