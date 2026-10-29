# OpenDAP workspace

OpenDAP is an Open Source, Open Hardware Digital Audio Player (DAP) that runs 100% on Linux. Beyond playback, it is a general-purpose Linux device that HATs extend. **OpenDAP** is the brand; **OpenDAP T1** is the first device. Faceplates are interchangeable front modules (default: touch); HATs are accessories mounted on the back.

This folder is the public `workspace` repository. Every folder under `public/` and `private/` is its own git repository. Commit and push each repository separately.

The rules for every repository are in the contributor guide:

@CONTRIBUTING.md

## Reconstructing the workspace

People and agents have different access: public only, all private repositories, or only some of them.

- Run `scripts/bootstrap.sh` (add `--json` for a machine-readable report, `--update` to fast-forward, `--public-only` to skip private repositories). It clones every public repository from `repos.tsv`, then the private overlay `private/workspace-private` and each private repository listed there **that your git credentials can reach**; the rest are reported as `skipped`. It never prompts for passwords.
- Never assume a repository exists locally: check the bootstrap report or the folder before reading, editing or referencing it. A private repository missing locally means no access, not an error.
- Never copy private content into a public repository, and never mention private-only details in public ones.

## Layout

- `public/` → public repositories in [opendap-project](https://github.com/opendap-project); `repos.tsv` maps every folder to its repository. Generic repositories sit at the top: `blackbird` (Blackbird OS and its software: `os/`, `system/`, `ui/`, `emulator/`), `host` (what runs on the user's computer: `cli/`, the user-side `opendap` CLI, like adb, and `desktop/`, OpenDAP Desktop), `rfcs`, `claude-plugins`. `public/t1` to `t1`: what is specific to the OpenDAP T1, one repository (`product/`, `board/`, `case/`, `faceplates/<name>`). `public/hats` to `hats` (one repository: `standard/`, the HATs in design such as `radio/`, and `concepts/<hat>/`), `public/libs` to `libs` (one repository, a folder per tool: `kicad/`, `parts/`, `freecad/`, `blender/`). `public/tools` to `tools`: the Developer Toolkit is for maintainers, one repository with a folder per tool domain (`host`, `image`, `hardware`, `verify`, `hooks`), reached through one command, `odapkit <tool>` (`odapkit-<tool>` executables, RFC 0009). It is not the CLI: `opendap` never needs `odapkit`, and `odapkit` may use `opendap`. Device binaries keep `odap-*`.
- Tools find other repositories through `repos.tsv`, or `ODAP_<REPO>_DIR` (for example `ODAP_BLACKBIRD_DIR`) outside a workspace checkout. Links between repositories are GitHub URLs, never relative paths.
- `private/` → private repositories in the same organization, listed in the private overlay `private/workspace-private/repos.tsv`.

## Maintainers

Maintainers with access to the private overlay also follow its agent instructions, loaded below when `private/workspace-private` is cloned (skipped silently otherwise):

@private/workspace-private/agents/workspace.md
