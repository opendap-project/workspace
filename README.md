# OpenDAP workspace

OpenDAP builds personal audio instruments on an open hardware and software platform. This is the root of its working tree: the shared `CLAUDE.md` (inherited by every repository in Claude Code), the list of public repositories and the bootstrap script.

## Set up

```sh
git clone https://github.com/opendap-project/workspace.git opendap
cd opendap
scripts/bootstrap.sh            # clone every repository you can access
public/toolkit/host/setup.sh    # install the developer host tools
scripts/bootstrap.sh            # run again to install pre-commit in every clone
```

- Public repositories are listed in `repos.tsv` and always cloned.
- Private repositories are listed in the private overlay (`opendap-project/workspace-private`); each one is cloned only if you have access to it. Use `--public-only` to skip them, `--update` to fast-forward existing clones, `--json` for a machine-readable report.

## License

This repository follows the [REUSE](https://reuse.software) layout: license texts live in `LICENSES/` and `REUSE.toml` maps each path to its license.

- Default (docs): **Creative Commons Attribution-ShareAlike 4.0** (`CC-BY-SA-4.0`)
- `scripts/`: **GNU GPL v3.0 or later** (`GPL-3.0-or-later`)

Copyright © 2026 The OpenDAP Project.
