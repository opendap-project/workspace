# Templates

The boilerplate every OpenDAP repository shares, kept once. [`sync.toml`](sync.toml) says which template goes to which path of which repositories; `odapkit sync --check` reports drift and `odapkit sync --apply` repairs it ([workspace sync](https://github.com/opendap-project/toolkit-host/blob/main/docs/specs/workspace-sync.md)). Edit a template here, never its copies.

| Template | Copied to |
|---|---|
| `claude/settings.json` | `.claude/settings.json` of every public repository |
| `markdownlint-cli2.jsonc` | `.markdownlint-cli2.jsonc` of every public repository |
| `claude/rules/*.md` | `.claude/rules/` of the repositories that work in that domain (KiCad, FreeCAD, Blender, exports, firmware, simulation) |
| `gitignore/*`, `gitattributes/*` | The managed block at the top of each repository's `.gitignore` and `.gitattributes`, fragment by fragment according to what the repository tracks (KiCad, FreeCAD, Blender, Rust, Python, CAD binaries in LFS) |
| `claude/contributor` | The managed block after the title and first paragraph of each public repository's `CLAUDE.md`: the link to the contributor guide |

`.pre-commit-config.yaml` profiles and `REUSE.toml` from a licensing policy follow.
