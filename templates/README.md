# Templates

The boilerplate every OpenDAP repository shares, kept once. [`sync.toml`](sync.toml) says which template goes to which path of which repositories; `odapkit sync --check` reports drift and `odapkit sync --apply` repairs it ([workspace sync](https://github.com/opendap-project/tools/blob/main/host/docs/specs/workspace-sync.md)). Edit a template here, never its copies.

| Template | Copied to |
|---|---|
| `claude/settings.json` | `.claude/settings.json` of every public repository |
| `markdownlint-cli2.jsonc` | `.markdownlint-cli2.jsonc` of every public repository |
| `claude/rules/*.md` | `.claude/rules/` of the repositories that work in that domain (KiCad, FreeCAD, Blender, exports, firmware, simulation) |
| `gitignore/*`, `gitattributes/*` | The managed block at the top of each repository's `.gitignore` and `.gitattributes`, fragment by fragment according to what the repository tracks (KiCad, FreeCAD, Blender, Rust, Python, CAD binaries in LFS, visual outputs declared by an `outputs.toml`) |
| `../owners.tsv` (generated, not copied) | `.github/CODEOWNERS` of the workspace and of every public repository, rendered by the `codeowners` generator |
| `sync.toml` `[[block]]` for `.pre-commit-config.yaml`, `pre-commit/outputs` | The managed block at the end of the pre-commit configuration of each listed repository: the odw check hooks rendered from its `check.toml` files (generator `odw-check`, tools [workspace sync](https://github.com/opendap-project/tools/blob/main/host/docs/specs/workspace-sync.md#odw-check-hooks)), and the visual-output hooks of [RFC 0021](https://github.com/opendap-project/rfcs/blob/main/text/0021-committed-visual-outputs.md) where the repository tracks an `outputs.toml` |
| `claude/contributor` | The managed block after the title and first paragraph of each public repository's `CLAUDE.md`: the link to the contributor guide |

`.pre-commit-config.yaml` profiles and `REUSE.toml` from a licensing policy follow.
