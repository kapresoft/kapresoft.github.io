---
title: "Git Reset Like a Pro"
title_style: title2w
section_style: article1
category: software
related: git
canonical_url: https://www.kapresoft.com/software/2024/01/11/git-reset-like-pro.html
description: "Master Git Reset with confidence! Explore use cases, options, and examples to handle your repositories like a pro."
---

## Overview

In this comprehensive guide, we dive into the intricate world of _git reset_, a powerful tool in the Git version control system. We'll explore its various use cases, demystifying the command and its options to empower developers with the confidence to harness its full potential.<!--excerpt--> Whether you're correcting a commit, managing branches, or tidying up your repository, understanding _git reset_ is key to navigating these scenarios with expertise.

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/git-reset-like-pro-cover-73407d7.webp" alt="Image: Git Reset Like Pro">
</div>

Git's reset command can be intimidating, but with the right knowledge, it becomes an indispensable part of your development toolkit. We'll break down each reset option, providing real-world examples and scenarios where each is most effective. By the end of this article, you'll not only grasp the technicalities of _git reset_ but also appreciate its strategic value in managing your codebase.

## Understanding Git Reset

_Git reset_ is a fundamental command in the Git version control system, offering the flexibility to undo changes in a repository's history. This command is crucial for maintaining a clean and accurate project history, an essential aspect of efficient team collaboration and project management in software development.

In the realm of version control, _git reset_ plays a pivotal role. It allows developers to revert to previous states of their code, effectively erasing recent changes while keeping the work intact. This capability is particularly useful for correcting errors, adjusting commits before sharing them, or undoing changes that no longer align with a project's direction.

There are three primary types of resets in Git: _--soft_, _--mixed_, and _--hard_. Each serves a distinct purpose:
- _--soft_ reset moves the current branch's HEAD to a specified commit but leaves the staging area and working directory untouched. It's ideal for redoing the last commit.
- _--mixed_ reset, the default mode, moves HEAD and updates the index (staging area) but preserves the working directory. It's useful for undoing changes in the staging area.
- _--hard_ reset is the most drastic. It moves the HEAD, updates the index, and resets the working directory to match. This erases all changes since the specified commit, so it should be used with caution.

Understanding these types of resets and their implications is key to mastering Git and maintaining a robust version control process.

## Illustration of a Git Reset

Visualizing the effects of a _git reset_ operation can be crucial for understanding how it alters the commit history in a Git repository. Below are PlantUML diagrams that represent the state of a Git repository before and after using _git reset [option]_.

### Before _git reset [option]_
This diagram illustrates the repository's state before executing the _git reset_. It shows HEAD pointing to the latest commit, "Commit B".

**Figure 1.**  The state of the repo before the reset

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/git-reset-like-pro-1-303ba8a.webp">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/RO_12i9034Jl-nM39prKy2gbTAk2_s0zB6ri5zgaxAPNlztjdWIz967c3KFgg2xeEaycKAUEXucmkyWyUuNTmKNOFqw3_UIKeXuoqdmZzvkzPdKxZDacYg98cJFAibj385QCvFggCWtAP5bZM9GG_30gv9MZ2Szh4SyQeTBoJ_knvI49WI8f7hAe5txcsFi4c9guJwzz0000" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=RO_12i9034Jl-nM39prKy2gbTAk2_s0zB6ri5zgaxAPNlztjdWIz967c3KFgg2xeEaycKAUEXucmkyWyUuNTmKNOFqw3_UIKeXuoqdmZzvkzPdKxZDacYg98cJFAibj385QCvFggCWtAP5bZM9GG_30gv9MZ2Szh4SyQeTBoJ_knvI49WI8f7hAe5txcsFi4c9guJwzz0000" target="_blank">PlantText</a>
   </small>
</div>

### After _git reset [option]_
The following diagram demonstrates the state after the reset. HEAD is now pointing to "Commit A". The status of changes from "Commit B" will depend on the reset option used (_--soft_, _--mixed_, or _--hard_).

**Figure 2.** The state of the repo after the reset

<div class="uml-diagram">
   <img src="https://cdngh.kapresoft.com/img/git-reset-like-pro-2-19d184f.webp">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/NK_H2eCm37plLno--mD3nCuDzX6-59kr1KsaHlRxQsM3iPVaSidbac5Nb_LO5vDfLiTX8JIZh6jIs0PkX_tjFExsTh8L65CZshQ5nGLTDnyv4oiYET_tnh0e8QSG5V8y9MNiJ2mlR99OTwXC_3NyKzIjOopMjDVoCtMTs6L2ELp9Gp8EBZWKx6aZzea3XA6H89icOJCKjhpu1W00" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=NK_H2eCm37plLno--mD3nCuDzX6-59kr1KsaHlRxQsM3iPVaSidbac5Nb_LO5vDfLiTX8JIZh6jIs0PkX_tjFExsTh8L65CZshQ5nGLTDnyv4oiYET_tnh0e8QSG5V8y9MNiJ2mlR99OTwXC_3NyKzIjOopMjDVoCtMTs6L2ELp9Gp8EBZWKx6aZzea3XA6H89icOJCKjhpu1W00" target="_blank">PlantText</a>
   </small>
</div>

These diagrams provide a clear and concise visual representation of the impact of _git reset_ on a repository, offering a better understanding of how different options affect the commit history and the working directory.

## Git Reset Soft

The _--soft_ option in _git reset_ is a subtle yet powerful tool. It allows you to undo commits on your current branch, but keeps your changes staged (in the index) and your working directory untouched. This is ideal for scenarios where you want to redo your last commit with additional changes or adjustments.

### Example Scenario
Imagine you've just committed changes to your branch, but realize you forgot to include a file or need to make a minor tweak. Instead of creating a new commit for these changes, you can use _git reset --soft_ to rewind to the state just before your last commit.

### Code Snippet
```git
git commit -m "Initial commit"
# Oops, need to add a change
git reset --soft HEAD~1
# Make your changes and then recommit
git commit -m "Revised commit"
```
In this example, _git reset --soft HEAD~1_ takes you back one commit (to Commit A), but keeps the changes of Commit B in the staging area. You can then make any additional changes and recommit, effectively rewriting Commit B.

### What _git status_ might look like after a _git reset --soft_

After executing a _git reset --soft_, the _git status_ command provides insights into the current state of your working directory and staging area. Let's consider an example where you had committed changes (in Commit B) and then performed a _git reset --soft HEAD~1_. Here's how the output of _git status_ might look:

```bash
$ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   file1.txt
        modified:   file2.txt
        new file:   file3.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        file4.txt
```

In this output:
- The "Changes to be committed" section lists changes that were in Commit B and are now staged again due to the _--soft_ reset. These can include modified and newly added files.
- The "Untracked files" section shows files that were untracked before the commit and remain so.
- The message about the branch being behind indicates that your local branch has one fewer commit than the remote, due to the reset.

This status report is a clear snapshot of your repository post-reset, showing that while the last commit was undone, all changes from that commit are ready to be re-committed.

## Git Reset Mixed

The _--mixed_ option in _git reset_ is the default reset behavior. It rolls back the commit history to a specified commit but leaves the changes from the undone commits in your working directory as uncommitted, unstaged changes. This is particularly useful when you need to modify the last few commits or consolidate them into a single commit.

### Practical Example and Code
Suppose you have made several commits but later decide to combine these changes into a single commit for better organization.

```git
git commit -m "Commit A"
git commit -m "Commit B"
# Realizing changes should be combined
git reset --mixed HEAD~2
# Changes from Commit A and B are now unstaged
# Make adjustments if needed and commit
git commit -m "Combined Commit"
```

### Git Status Example After _git reset --mixed_

After executing _git reset --mixed_, the _git status_ command will show something like this:

```bash
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)

        modified:   file1.txt
        modified:   file2.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

In this example, _file1.txt_ and _file2.txt_ represent the changes from the undone commits (Commit A and B). These files are now unstaged and appear in the "Changes not staged for commit" section. You can stage and commit these changes as you see fit.

## Git Reset Hard

The _--hard_ option in _git reset_ is the most forceful. It not only reverts the commit history to a specified commit but also discards all changes in the staging area and working directory. This is useful when you need to completely discard all recent changes and return to a clean, previous state of the project.

### Real-world Example and Code Demonstration
Suppose you've made several commits or changes that you now wish to entirely discard. The _git reset --hard_ command can be used to revert your project back to a clean state.

```git
git commit -m "Commit A"
# Realizing all subsequent changes should be discarded
git reset --hard HEAD
```

This command resets your repository to the state it was in at "Commit A", erasing all changes and commits made after it.

### Git Status Example After _git reset --hard_
After executing _git reset --hard_, the _git status_ command typically shows a clean working directory with no pending changes. For example:

```bash
$ git status
On branch master
nothing to commit, working tree clean
```

In this output, "nothing to commit, working tree clean" indicates that there are no staged or unstaged changes in the repository, reflecting the thorough nature of the _--hard_ reset.

## Advanced Scenarios

### Partial Resets
Partial resets in Git allow for more granular control by letting you unstage specific files or directories while keeping others intact. This is particularly useful when you want to split a large commit into smaller, more focused ones or when only certain changes need to be reverted.

#### Example
To unstage a specific file from the last commit:
```git
git add file1.txt file2.txt
git commit -m "Add multiple files"
# Decide to unstage file2.txt
git reset HEAD file2.txt
```
This leaves _file1.txt_ staged and _file2.txt_ unstaged.

### Reset in Branching and Merging
_git reset_ is also a vital tool when dealing with branches and merges. It can be used to undo a merge or changes brought into a branch, allowing you to manage your branch strategy more effectively.

#### Example
To undo a merge:
```git
git merge feature-branch
# Realizing the merge was premature
git reset --hard HEAD~1
```
This command reverts the branch to the state before the merge, effectively undoing it.

## Best Practices and Tips

### When to Use Each Reset Type
- Use _--soft_ for minor corrections to your last commit, like adding forgotten files or small changes, as it keeps all your changes staged.
- Opt for _--mixed_ when you need to redo your commits but want to keep your working directory changes for review and re-staging.
- Reserve _--hard_ for scenarios where you need to completely discard all recent changes and return to a previous, clean state.

### Common Pitfalls to Avoid
- Avoid using _--hard_ reset without checking the status of your working directory and staging area, as it irreversibly deletes uncommitted changes.
- Be cautious with resets on public branches, as it can lead to complex issues when others have already based work on the commits you are resetting.
- Don't use reset to fix a push to the wrong branch; instead, revert the commit and apply the changes to the correct branch.

### Maximizing the Effectiveness of Git Reset
- Regularly commit your work to make smaller, incremental resets possible, reducing the risk of losing significant work.
- Use _git log_ and _git reflog_ to understand your commit history and safely navigate through resets.
- Remember that _git reset_ is a powerful tool for local repository management. For changes that are already public, consider alternatives like _git revert_ to preserve history for collaborators.

## In Conclusion

In conclusion, understanding the nuances of _git reset_ and its various options -- _--soft_, _--mixed_, and _--hard_ -- is essential for effective version control and project management. Each reset type serves distinct purposes, from minor commit tweaks to complete reversal of changes.

Embrace best practices such as choosing the right reset type for the situation, avoiding irreversible actions on public branches, and regularly committing to facilitate easier reversals. Remember, while _git reset_ is powerful for local changes, public history alterations should be approached with tools like _git revert_.

For developers, mastering _git reset_ enhances your ability to manage code efficiently, correct errors swiftly, and maintain a clean project history. It's a testament to the flexibility and control Git offers, empowering you to handle your repositories with confidence and expertise.
