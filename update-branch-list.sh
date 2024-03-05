#!/usr/bin/bash
branches=$(git branch -r --format="* [%(refname:lstrip=-1)](../../tree/%(refname:lstrip=-1))" | grep -Ev "(HEAD|main)")
echo "## Projects" > README.md
echo "$branches" >> README.md
git add README.md
git commit -m ":robot: Updated the branch list in README.md"
git push origin main
