#!/bin/sh
# Install dev-kit skills into one or more AI agents' skills directories.
#
#   ./install.sh --agent codex
#   ./install.sh --agent all --project ~/code/my-app
#   curl -fsSL https://raw.githubusercontent.com/ritvikneu/dev-kit/main/install.sh | sh -s -- --agent antigravity

set -eu

REPO_URL="https://github.com/ritvikneu/dev-kit.git"
AGENTS_ALL="claude codex antigravity gemini"

usage() {
  cat <<'EOF'
Usage: install.sh [options]

Options:
  --agent NAME     claude | codex | antigravity | gemini | all  (repeatable, default: all)
  --project DIR    install into DIR's project-level skills folder instead of your home folder
  --skill NAME     install only this skill (repeatable, default: every skill)
  --link           symlink skills instead of copying (for local development)
  --list           list available skills and exit
  -h, --help       show this help

Install locations:
  agent         --project DIR             default (user)
  claude        DIR/.claude/skills        ~/.claude/skills
  codex         DIR/.agents/skills        ~/.agents/skills
  antigravity   DIR/.agent/skills         ~/.gemini/antigravity/skills
  gemini        DIR/.gemini/skills        ~/.gemini/skills
EOF
}

die() { echo "install.sh: $*" >&2; exit 1; }

agents=""
skills=""
project=""
link=0
list=0

while [ $# -gt 0 ]; do
  case "$1" in
    --agent)   [ $# -ge 2 ] || die "--agent needs a value"; agents="$agents $2"; shift 2 ;;
    --project) [ $# -ge 2 ] || die "--project needs a value"; project="$2"; shift 2 ;;
    --skill)   [ $# -ge 2 ] || die "--skill needs a value"; skills="$skills $2"; shift 2 ;;
    --link)    link=1; shift ;;
    --list)    list=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *)         usage >&2; die "unknown option: $1" ;;
  esac
done

# Locate the skills source: this checkout, or a fresh shallow clone when piped from curl.
src=""
case "$0" in
  */*) script_dir=$(cd "$(dirname "$0")" && pwd); [ -d "$script_dir/skills" ] && src="$script_dir/skills" ;;
esac
if [ -z "$src" ]; then
  command -v git >/dev/null 2>&1 || die "git is required to download dev-kit"
  [ "$link" -eq 0 ] || die "--link needs a local checkout of dev-kit"
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  git clone --quiet --depth 1 "$REPO_URL" "$tmp/dev-kit"
  src="$tmp/dev-kit/skills"
fi

available=""
for d in "$src"/*/; do
  [ -f "$d/SKILL.md" ] && available="$available $(basename "$d")"
done

if [ "$list" -eq 1 ]; then
  for s in $available; do echo "$s"; done
  exit 0
fi

[ -n "$skills" ] || skills="$available"
for s in $skills; do
  case " $available " in *" $s "*) ;; *) die "unknown skill: $s (available:$available)" ;; esac
done

[ -n "$agents" ] || agents="all"
case " $agents " in *" all "*) agents="$AGENTS_ALL" ;; esac

if [ -n "$project" ]; then
  [ -d "$project" ] || die "project directory not found: $project"
  project=$(cd "$project" && pwd)
fi

target_dir() {
  if [ -n "$project" ]; then
    case "$1" in
      claude)      echo "$project/.claude/skills" ;;
      codex)       echo "$project/.agents/skills" ;;
      antigravity) echo "$project/.agent/skills" ;;
      gemini)      echo "$project/.gemini/skills" ;;
    esac
  else
    case "$1" in
      claude)      echo "$HOME/.claude/skills" ;;
      codex)       echo "$HOME/.agents/skills" ;;
      antigravity) echo "$HOME/.gemini/antigravity/skills" ;;
      gemini)      echo "$HOME/.gemini/skills" ;;
    esac
  fi
}

install_skill() {
  from="$src/$1"
  to="$2/$1"
  rm -rf "$to"
  if [ "$link" -eq 1 ]; then
    ln -s "$from" "$to"
    return
  fi
  mkdir -p "$to"
  cp "$from/SKILL.md" "$to/"
  # Only runtime files: evals stay behind, symlinks are copied as real files.
  for sub in references scripts assets; do
    [ -d "$from/$sub" ] && cp -RL "$from/$sub" "$to/"
  done
  return 0
}

for a in $agents; do
  case " $AGENTS_ALL " in *" $a "*) ;; *) die "unknown agent: $a (use: $AGENTS_ALL all)" ;; esac
  dest=$(target_dir "$a")
  mkdir -p "$dest"
  for s in $skills; do
    install_skill "$s" "$dest"
  done
  echo "$a: installed$(printf ' %s' $skills) -> $dest"
done
