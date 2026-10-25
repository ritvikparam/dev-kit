#!/bin/sh
# Check every skill against the Agent Skills format so it loads on any platform.
set -u

root=$(cd "$(dirname "$0")/.." && pwd)
errors=0
fail() { echo "FAIL $1"; errors=$((errors + 1)); }

for dir in "$root"/skills/*/; do
  skill=$(basename "$dir")
  file="$dir/SKILL.md"
  [ -f "$file" ] || { fail "$skill: missing SKILL.md"; continue; }

  # Frontmatter is the block between the first two '---' lines.
  fm=$(awk 'NR==1 && $0!="---"{exit} NR>1 && $0=="---"{exit} NR>1{print}' "$file")
  [ -n "$fm" ] || { fail "$skill: missing YAML frontmatter"; continue; }

  name=$(printf '%s\n' "$fm" | sed -n 's/^name:[[:space:]]*//p' | head -1)
  [ "$name" = "$skill" ] || fail "$skill: frontmatter name '$name' does not match folder name"
  printf '%s\n' "$fm" | grep -q '^description:' || fail "$skill: missing description"

  # Strict YAML parsers (Codex, npx skills) reject an unquoted value containing ': '.
  printf '%s\n' "$fm" | grep -E '^[a-z_-]+:[[:space:]]+[^>|"'"'"'[:space:]].*:[[:space:]]' >/dev/null &&
    fail "$skill: unquoted frontmatter value contains ': '; quote it or use 'description: >'"

  # Symlinks break on Windows and in some installers, so references must be real files.
  if [ -d "$dir/references" ]; then
    for ref in "$dir"/references/*; do
      [ -L "$ref" ] && fail "$skill: $(basename "$ref") is a symlink; copy the file instead"
    done
  fi
done

# Shared HTML templates are duplicated per skill; keep the copies identical.
canonical="$root/skills/html-render/references/TEMPLATES.md"
for copy in "$root"/skills/*/references/TEMPLATES.md; do
  [ "$copy" = "$canonical" ] && continue
  cmp -s "$canonical" "$copy" || fail "${copy#$root/}: out of sync with html-render; run cp $canonical $copy"
done

if [ "$errors" -gt 0 ]; then
  echo "$errors problem(s) found"
  exit 1
fi
echo "All skills valid"
