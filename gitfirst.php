# Git repository बनाना
git init                  # नई repo बनाएं
git clone <url>           # GitHub/GitLab से clone करें

# Changes track करना
git status                # Current status देखें
git add <file>            # Single file stage करें
git add .                 # सभी files stage करें
git commit -m "message"   # Stage files commit करें
git log                   # Commit history देखें
git diff                  # Unstaged changes देखें

# Branches
git branch                # सभी branches देखें
git branch <branch-name>  # नई branch बनाएं
git checkout <branch>     # किसी branch पर switch करें
git checkout -b <branch>  # नई branch बनाकर switch करें

# Merge & Delete
git merge <branch>        # किसी branch को merge करें
git branch -d <branch>    # Branch delete करें

# Branch history visualize
git log --oneline --graph --all

💡 Tip:

नई branch current commit से शुरू होती है।

Merge conflicts आए तो resolve करना पड़ता है।



pull = fetch + merge

push = local changes को remote में भेजना

git config --global init.defaultBranch main

# Undo & revert
git reset --soft HEAD~1       # Last commit undo, changes रखो
git reset --hard HEAD~1       # Last commit और changes delete
git revert <commit>           # किसी commit को उलटना

# Temporary save
git stash                     # Current changes save
git stash pop                 # Stash recover

# Pick & rebase
git cherry-pick <commit>      # किसी commit को दूसरी branch में apply
git rebase <branch>           # Branch को base commit के ऊपर ले जाएँ

# Tags & visual
git tag <tagname>             # Release/version mark
git log --graph --decorate --all

git remote -v
mkdir newapp && cd newapp && touch index.html && git init

git fetch origin
git status

👉 Shows commits that are ahead (local commits not pushed).
git log origin/main..main


Shows commits behind (remote commits not yet pulled).
git log main..origin/main

#add advnaced coomands for github
