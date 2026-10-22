# OpenDAP workspace

OpenDAP is an open-source, open-hardware digital audio player (DAP) that runs 100% on Linux. Beyond playback, it is a general-purpose Linux device that HATs extend. **OpenDAP** is the brand; **OpenDAP T1** is the first device. Faceplates are interchangeable front modules (default: touch); HATs are accessories mounted on the back.

This folder is the public `workspace` repository. Every folder under `public/` and `private/` is its own git repository. Commit and push each repository separately.

## Reconstructing the workspace

People and agents have different access: public only, all private repositories, or only some of them.

- Run `scripts/bootstrap.sh` (add `--json` for a machine-readable report, `--update` to fast-forward, `--public-only` to skip private repositories). It clones every public repository from `repos.tsv`, then the private overlay `private/workspace-private` and each private repository listed there **that your git credentials can reach**; the rest are reported as `skipped`. It never prompts for passwords.
- Never assume a repository exists locally: check the bootstrap report or the folder before reading, editing or referencing it. A private repository missing locally means no access, not an error.
- Never copy private content into a public repository, and never mention private-only details in public ones.

## Brand and voice

The project is in **early open development**: say so plainly, and never present plans as products or prototypes as finished.

- **Names.** OpenDAP (brand) · OpenDAP T1 (the DAP; "the T1" after first mention) · OpenDAP OS · OpenDAP HATs · OpenDAP Developer Toolkit · faceplates · DIY edition and Commercial edition. Never "DAP OS", and never a product name the maintainers have not confirmed.
- **Engineering before promises.** A claim needs evidence: a measurement, a datasheet, a simulation, a working system. Write what it does and how, with numbers and sources; mark the unverified as **UNVERIFIED**.
- **A DAP first.** OpenDAP is a DAP: lead with that, in plain words, before any abstraction. The advanced uses (general-purpose Linux, HATs, developer platform) come after, as what the DAP can also do, never as the headline.
- **Precise and restrained.** No superlatives, hype, marketing adjectives or exclamation marks. Character comes from clear, deliberate decisions, not from tone.
- **Integration before accumulation.** Explain how parts work together; do not pad with feature lists.
- **Complexity available, never imposed.** Lead with the plain answer; put depth (tables, derivations, alternatives) after it, for whoever wants it.
- **Openness is architectural.** Show it through documented interfaces, reproducible builds and specifications, not by repeating the word "open".
- **Visual work** (renders, previews, diagrams, UI): deliberate geometry, contemporary and legible type, clear hierarchy, a restrained palette with functional colour accents, and faithful depiction of the real product. Technical drawings, diagrams and exploded views are part of the identity.

## Rules

- **English only** in everything written to a repository: code, docs, commit messages, names, GitHub descriptions. Talk to the user in whatever language they use.
- **Confirmed information only.** Record what the maintainers stated. Do not infer specs, numbers or wording. Earlier experiments (old claude.ai artifacts) are not a source.
- **Product priority.** The audiophile experience is never sacrificed (100 %). Everything else is balanced by cost and benefit to make the best product and use the hardware fully. No decision depends on getting a dev kit.
- **100 % of the hardware, never software limits.** Software exposes everything the hardware can do; features are never locked, capped or hidden to segment products. The only limits are for safety (BRD-049), and they are documented and visible to the user, never silent.
- **Scale and endurance.** Large libraries and long sessions never degrade the experience: no indexing limits, no glitches with lots of data, no slowdowns after hours or days without a restart (T1-046, T1-047). Design for bounded memory and time, and test it on every release.
- **Hardware parts:** always prefer commercial, highly available, easy-to-source parts, of the most recent generation that stays compatible (mainline support, SoC interfaces).
- **Hardware–software co-design.** The T1 is specific portable hardware, and OpenDAP co-designs its hardware and software to get the most out of it through optimisation and deep integration. That is why OpenDAP prefers its own ecosystem over generic third-party software. It builds on the shoulders of giants: open standards, Linux and Rust practices, and mature upstream projects are the foundation; OpenDAP's own work is the integration and the optimisation on top, never a reinvention of what a standard or a mature project already does well.
- **Software:** the foundation is the most standard Linux, open-source and trick-less (mainline kernel, Debian, upstream drivers); the product layer on top (services, audio engine, UI, optimised packages) is OpenDAP's own and co-designed with the hardware. What is general goes back upstream, but OpenDAP never depends on a third party accepting it: while a change is under review upstream (mainline, Slint, Smithay, winit…), the product ships it through DKMS or patches carried in OpenDAP's own packages (OS-023).
- **Rust architecture.** All Rust is crates-first and layered (domain model, application core with ports, adapters, interfaces), with one shared domain model per context and a platform-agnostic core, so every surface (CLI, OpenDAP Desktop, device services) reuses the same code. Standard: [Rust crate architecture](https://github.com/opendap-project/system/blob/main/docs/specs/rust-crate-architecture.md).
- **Don't get ahead.** Do not propose software stacks or technology choices until the maintainers open that topic.
- **Priorities.** Every requirement is **must** or **should**, and the difference is strict. *Must*: the product fails its promise without it; it blocks a release and is never dropped for cost. *Should*: nice to have; delivered when cost, schedule and the hardware allow, and the first candidate to drop or to make a population option (BRD-053). A *should* hardware feature whose cost is small next to the production BOM (indicatively about 1 % each) stays in production: drop only what moves the price materially. Priorities the maintainers confirmed change only with their decision.
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
