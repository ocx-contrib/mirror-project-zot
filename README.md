# mirror-project-zot

OCX mirrors for [zot](https://zotregistry.dev) tooling. One repository, one
spec directory per package.

| Package | Spec | Publishes to | Announced as |
|---|---|---|---|
| zot | [`zot/mirror.yml`](zot/mirror.yml) | `ghcr.io/ocx-contrib/project-zot/zot` | `ocx.sh/project-zot/zot` |

Each upstream release is discovered, re-bundled, smoke-tested per
`(version, platform)` and only then pushed with cascade tags, after which the
result is announced into the OCX index.

## Layout

`mirror-base.yml` holds the repo-wide policy every spec inherits via
`extends:` (a **shallow** merge — a spec that sets a top-level key replaces
that block whole). Platforms and container legs live in each package's spec,
next to the libc evidence that decides them.

## Editing

| File | Edit | Regenerate after |
|------|------|------------------|
| `mirror-base.yml`, `zot/mirror.yml` | hand | `ocx-mirror package pipeline generate ci --spec zot/mirror.yml` |
| `zot/tests/smoke.star` | hand | — |
| `zot/metadata.json`, `zot/CATALOG.md`, `logo.*` | hand | — |
| `.github/workflows/*.yml` | **generated — never hand-edit** | re-run when a spec changes |

CI fails on drift via `generate ci --check`. Run `direnv allow` once to put the
pinned toolchain on `PATH`; keep the floating tags in `ocx.toml` and let
`ocx update` move `ocx.lock`.

## Required secrets

`OCX_ANNOUNCE_TOKEN` and `OCX_MIRROR_DISCORD_HOOK`, inherited from the
`ocx-contrib` organisation. GHCR pushes use the run's own `GITHUB_TOKEN`.

## License

Apache-2.0 — see [`LICENSE`](LICENSE). Upstream assets are out of scope; see
[`NOTICE.md`](NOTICE.md).
