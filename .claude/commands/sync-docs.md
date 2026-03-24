Review the git diff since the last synced commit recorded in CLAUDE.md and update CLAUDE.md to reflect any changes to project structure, architecture, conventions, or key files. After updating, bump the "Last synced at commit" line to the current HEAD commit hash. Run `git rev-parse HEAD` to get it.

Use `git diff <last-synced-commit>..HEAD -- ':!.godot' ':!*.uid'` to see what changed. Ignore .godot cache files and .uid files.

Only update sections that are actually affected by the diff. Do not rewrite unchanged sections.
