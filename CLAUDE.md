# OpenDAP workspace

OpenDAP is an open-source, open-hardware digital audio player that runs 100% on Linux, and a general-purpose Linux gadget. **OpenDAP** is the brand; **T1** is the first device. Faceplates are interchangeable front modules (default: touch); HATs are accessories mounted on the back.

This folder is the public `workspace` repository. Every folder under `public/` and `private/` is its own git repository. Commit and push each repository separately.

## Reconstructing the workspace

People and agents have different access: public only, all private repositories, or only some of them.

- Run `scripts/bootstrap.sh` (add `--json` for a machine-readable report, `--update` to fast-forward, `--public-only` to skip private repositories). It clones every public repository from `repos.tsv`, then the private overlay `private/workspace-private` and each private repository listed there **that your git credentials can reach**; the rest are reported as `skipped`. It never prompts for passwords.
- Never assume a repository exists locally: check the bootstrap report or the folder before reading, editing or referencing it. A private repository missing locally means no access, not an error.
- Never copy private content into a public repository, and never mention private-only details in public ones.

## Rules

- **English only** in everything written to a repository: code, docs, commit messages, names, GitHub descriptions. Talk to the user in whatever language they use.
- **Confirmed information only.** Record what the maintainers stated. Do not infer specs, numbers or wording. Earlier experiments (old claude.ai artifacts) are not a source.
- **Product priority.** The audiophile experience is never sacrificed (100 %). Everything else is balanced by cost and benefit to make the best product and use the hardware fully. No decision depends on getting a dev kit.
- **Hardware parts:** always prefer commercial, highly available, easy-to-source parts, of the most recent generation that stays compatible (mainline support, SoC interfaces).
- **Software:** always prefer the most standard Linux, open-source, trick-less option.
- **Don't get ahead.** Do not propose software stacks or technology choices until the maintainers open that topic.
- **Docs.** Each repository keeps its context in `docs/`: requirements first (`docs/requirements/`), then ADRs only for decisions the maintainers have taken (`docs/adr/`). Context, ideas and open options are not ADRs; they go under `## Context` in the requirements file. Use the `/opendap:requirement` and `/opendap:adr` skills.
- **Licensing.** Public repositories follow REUSE. Changes to anything OpenDAP publishes stay open; what others add on top is theirs. CERN-OHL-S-2.0 for our product hardware, CERN-OHL-W-2.0 for hardware building blocks (libraries, HAT reference designs, `export/`), GPL-3.0-or-later for software, MPL-2.0 for software libraries others build on (SDK, design system, schemas), MIT for firmware and templates, CC-BY-SA-4.0 for documentation and project assets, CC-BY-4.0 for generic shared assets (`blender-lib/shared/`). Copyright: "The OpenDAP Project". Use `/opendap:license-check`.
- **Public/private boundary.** `private/` repositories are proprietary. Never copy their content into a `public/` repository.
- **Hierarchical composition.** Every component publishes itself as one unit in `export/`, following the [component export contract](https://github.com/opendap-project/toolkit-hardware/blob/main/docs/specs/component-export.md). Components consume each other's exports where it makes sense; `public/t1` integrates the whole product. Never reach into another repository's sources.
- **Local only.** No CI for now: checks and generated outputs run on the developer machine. Every repository runs pre-commit (REUSE, KiCad ERC/DRC, no fab outputs); never bypass it. Host tools: `public/toolkit/host/setup.sh`. Fab packages: `/opendap:fab-package`; releases: `/opendap:release`.
- **Cross-repository changes** go through an RFC in `public/rfcs` (private-only ones in `private/workspace-private/rfcs/`).
- **Supported hosts.** Toolkit and development officially support only UNIX / POSIX systems, tested on macOS only. No Windows.
- **3D previews.** Blender for renders; standalone HTML documents (three.js, anime.js…) for product-side 3D animations and interactive previews that do not need Blender, built from components' `export/` (glTF, STEP). Presentation videos: those HTML previews captured frame by frame with Playwright (stepping the page clock) and assembled with ffmpeg.

## Layout

- `public/` → public repositories in [opendap-project](https://github.com/opendap-project). `public/hats/<name>` maps to `hat-<name>` (`hats/standard` is `hat-standard`), `public/faceplates/<name>` to `faceplate-<name>`, `public/libs/<name>` to `<name>-lib`. `public/toolkit/<name>` maps to `toolkit-<name>`: the Developer Toolkit is one repository per tool domain (`cli` for the `opendap` CLI, `hooks`, `host`, `hardware`, `verify`).
- `private/` → private repositories in the same organization, listed in the private overlay `private/workspace-private/repos.tsv`.
