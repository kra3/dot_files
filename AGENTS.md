# Repository Guidelines

## Project Structure & Module Organization
This chezmoi source tree mirrors the target home directory. Top-level `dot_*` files render to dotfiles (for example `dot_zshrc.tmpl` → `~/.zshrc`). Machine- or tool-specific assets live under `dot_config/`, `dot_local/`, and `dot_tmux/`, while executable helpers belong in `dot_local/bin/` with the `executable_` prefix. Reference material sits in `docs/`; update the relevant note when changing a tool so contributors can trace rationale quickly.

## Build, Test, and Development Commands
- `chezmoi diff` — preview template changes against the live home directory; use before every apply.
- `chezmoi apply --dry-run` — validate templating logic without writing files; pair with `--verbose` when debugging conditionals.
- `chezmoi doctor` — run after major updates to catch missing dependencies or platform detection issues.
- `./run_once_install-tools.sh.tmpl | sh` — simulate provisioning logic; never commit secrets or machine-specific edits into this script.

## Coding Style & Naming Conventions
Write shell templates in POSIX bash with 4-space indent for control blocks and keep conditionals idempotent. YAML/TOML configs stay two spaces per level; JSON remains compact but stable-sorted. Name new templates with `.tmpl` when they contain logic, otherwise drop the suffix for literal files so chezmoi avoids needless processing. Follow existing prefixes (`dot_`, `private_`, `executable_`) to preserve automatic permissions and filtering. Run `shellcheck` on new shell scripts and `yamllint` (if available) on YAML additions.

## Testing Guidelines
Prefer `chezmoi apply --dry-run` on both macOS and Linux targets when touching host conditionals. For scripts, add adhoc tests (e.g., `shellcheck -x dot_shell_common.sh.tmpl`) and verify executable bits via `chezmoi managed --include=Scripts`. When editing docs, render Markdown locally (`markdownlint-cli` optional) and ensure links resolve. High-impact changes should include a manual smoke test summary in the pull request body.

## Commit & Pull Request Guidelines
Commit messages follow the existing short, imperative style (`add`, `fix`, `remove`). Group related template and documentation changes together; keep machine-specific values in ignored `.toml` locals. Pull requests should describe the motivation, summarize validation steps (doctor, diff, dry-run), and link to any referenced docs. Include screenshots only when visual themes change (e.g., terminal or tmux previews).

## Security & Configuration Tips
Never embed secrets; instead, rely on `private_` templates or off-repo secrets management. Guard work-only settings behind hostname or data conditionals in `.chezmoi.toml.tmpl`. Review `run_once_install-tools.sh.tmpl` for idempotence after tool additions so repeated applies remain safe.
