#!/usr/bin/bash
branches=$(git branch -r --format="* [%(refname:lstrip=-1)](%(refname))" | grep -Ev "(HEAD|main)")
echo "## Projects Branches" > README.md
echo "$branches" >> README.md
exit 0