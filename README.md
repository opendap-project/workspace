# OpenDAP workspace

![OpenDAP T1 concept art: the T1 in graphite with its orange Action button and silver keys, playing "You Only Live Once" by The Strokes on Blackbird OS. Concept art, not a real device.](assets/concept.png)

OpenDAP is an Open Source, Open Hardware Digital Audio Player (DAP) that runs entirely on Linux. This is the root of its working tree: the contributor guide ([`CONTRIBUTING.md`](CONTRIBUTING.md), the rules for every repository, which Claude Code loads through `CLAUDE.md`), the list of public repositories and the bootstrap script.

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

## Templates

[`templates/`](templates/) holds the boilerplate every repository shares (agent settings and rules, lint configuration); `odapkit sync --check` reports copies that drifted and `odapkit sync --apply` repairs them.

## License

This repository follows the [REUSE](https://reuse.software) layout: license texts live in `LICENSES/` and `REUSE.toml` maps each path to its license.

- Default (docs): **Creative Commons Attribution-ShareAlike 4.0** (`CC-BY-SA-4.0`)
- `scripts/`: **GNU GPL v3.0 or later** (`GPL-3.0-or-later`)
- `templates/`: **MIT** (`MIT`)

Copyright © 2026 The OpenDAP Project.
