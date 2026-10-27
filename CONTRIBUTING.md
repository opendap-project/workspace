# Contributing to OpenDAP

OpenDAP is an Open Source, Open Hardware Digital Audio Player (DAP) that runs 100% on Linux. **OpenDAP** is the brand; **OpenDAP T1** is the first device. The project is in **early open development**: say so plainly, and never present plans as products or prototypes as finished.

These rules apply to every OpenDAP repository. Each repository adds its own in its `README.md` and `CLAUDE.md`.

## Writing

- **Names.** OpenDAP (brand) · OpenDAP T1 (the DAP; "the T1" after first mention) · Blackbird OS · OpenDAP HATs · OpenDAP Developer Toolkit · faceplates · DIY edition and Commercial edition. Never "DAP OS", and never a product name the maintainers have not confirmed.
- **Evidence.** A claim needs evidence: a measurement, a datasheet, a simulation, a working system. Write what it does and how, with numbers and sources; mark the unverified as **UNVERIFIED**.
- **Visual work** (renders, previews, diagrams, UI) follows the [Engineered Matter design system spec](https://github.com/opendap-project/blackbird-ui/blob/main/docs/specs/design-system.md).

## Rules

- **English only** in everything written to a repository: code, docs, commit messages, names, GitHub descriptions.
- **Cite a source for every value.** Record what the maintainers stated or what a cited source shows. Do not infer specs, numbers or wording.
- **Product rules** are requirements, not conventions: the audiophile experience comes first (T1-040); software exposes everything the hardware can do, with safety limits documented and visible (BRD-049); software adapts to the hardware it runs on (SYS-040); audio defaults serve the listener, with monitoring and analysis one step away (SYS-041); large libraries and long sessions never degrade the experience (T1-046, T1-047).
- **Software:** the foundation is standard Linux, Open Source and trick-less (mainline kernel, Debian, upstream drivers). What is general goes back upstream; while a change is under review upstream, OpenDAP ships it through DKMS or patches carried in its own packages (OS-023).
- **Rust architecture.** All Rust is crates-first and layered (domain model, application core with ports, adapters, interfaces), with one shared domain model per context and a platform-agnostic core. Standard: [Rust crate architecture](https://github.com/opendap-project/system/blob/main/docs/specs/rust-crate-architecture.md).
- **Size.** A Rust file stays within 600 lines of code, a function within 80 lines and a struct within 15 fields (Rust crate architecture); a Python file within 500 lines, with one engine per package; a Slint file within 500 lines, with one component family per file; a spec within 600 lines or one topic, its tables of facts kept as data. Going over one is a split, not a style note.
- **Priorities.** Every requirement is **must** or **should**, and the difference is strict. *Must*: the product fails its promise without it; it blocks a release. *Should*: delivered when the hardware and schedule allow, and the candidate for a population option (BRD-053). Priorities the maintainers confirmed change only with their decision.
- **Docs.** Each repository keeps its context in `docs/`: requirements first (`docs/requirements/`), then specifications (`docs/specs/`) and ADRs only for decisions the maintainers have taken (`docs/adr/`). Context, ideas and open options are not ADRs; they go under `## Context` in the requirements file. An ADR or requirement states the facts it relies on and cites requirement IDs and sources; research notes and plans are not kept in the public repositories. Use the `/opendap:requirement` and `/opendap:adr` skills. Requirement IDs are never renumbered, and each prefix is registered for the repository that owns it in the workspace's [`id-prefixes.tsv`](https://github.com/opendap-project/workspace/blob/main/id-prefixes.tsv); `odapkit req prefixes` and `odapkit req refs` check both.
- **Licensing.** Public repositories follow REUSE. Changes to anything OpenDAP publishes stay open; what others add on top is theirs. CERN-OHL-S-2.0 for our product hardware, CERN-OHL-W-2.0 for hardware building blocks (libraries, HAT reference designs, `export/`), GPL-3.0-or-later for software, MPL-2.0 for software libraries others build on (SDK, design system, schemas), MIT for firmware and templates, CC-BY-SA-4.0 for documentation and project assets, CC-BY-4.0 for generic shared assets (`blender-lib/shared/`). Copyright: "The OpenDAP Project". Use `/opendap:license-check`.
- **Public and private repositories.** Private repositories are proprietary; nothing from them goes into a public repository, and no public document links to them.
- **Hierarchical composition.** Every component publishes itself as one unit in `export/`, following the [component export contract](https://github.com/opendap-project/toolkit-hardware/blob/main/docs/specs/component-export.md). Components consume each other's exports where it makes sense; `public/t1` integrates the whole product. Never reach into another repository's sources.
- **Local only.** No CI for now: checks and generated outputs run on the developer machine. Every repository runs pre-commit: REUSE, markdownlint, shellcheck, the checks that generated files are current, its tests, KiCad ERC/DRC and no fab outputs where they apply; never bypass it. Host tools: `public/toolkit/host/setup.sh`. Fab packages: `/opendap:fab-package`.
- **Cross-repository changes** go through an RFC in `public/rfcs`.
- **Supported hosts.** Toolkit and development officially support only UNIX / POSIX systems, tested on macOS only. No Windows.
