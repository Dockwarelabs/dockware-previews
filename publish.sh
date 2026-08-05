#!/bin/bash
GITHUB_USER="Dockwarelabs"
REPO_NAME="dockware-previews"
DOWNLOADS="$HOME/Downloads"

echo "→ Looking for new preview files in $DOWNLOADS ..."
shopt -s nullglob
FILES=("$DOWNLOADS"/*.html)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No .html files found in $DOWNLOADS — download from the Studio first."
  exit 1
fi

for f in "${FILES[@]}"; do
  cp "$f" .
  echo "  copied: $(basename "$f")"
done

echo "→ Committing and pushing..."
git add .
git commit -m "Add preview(s): $(date '+%Y-%m-%d %H:%M')" --quiet
git push --quiet

echo ""
echo "✅ Live links:"
for f in "${FILES[@]}"; do
  name=$(basename "$f")
  echo "  https://${GITHUB_USER}.github.io/${REPO_NAME}/${name}"
done
echo ""
echo "Copy the link(s) above and send to the client."
