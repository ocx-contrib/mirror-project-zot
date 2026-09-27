---
title: zot
description: Production-ready, vendor-neutral OCI image registry — a single binary serving the OCI Distribution Spec with no external dependencies
keywords: zot,oci,registry,container,distribution,artifacts,cncf,project-zot
---

# zot

zot is an OCI-native container image registry. It implements the OCI
Distribution Specification and stores images in the OCI Image Layout on disk
(or S3), so it serves anything OCI — container images, Helm charts, signatures,
SBOMs and arbitrary artifacts — with no conversion layer in between.

It ships as one binary with no database or sidecar to run. This full build
compiles in zot's extensions: search (GraphQL), sync/mirroring of upstream
registries, image trust (cosign / notation verification), lint, metrics,
scrub, user preferences and the web UI — all switched on per deployment in the
JSON config.

These are the project's own release binaries, republished unmodified.

## What's included

- **zot** — the registry server: `zot serve <config>` runs it,
  `zot verify <config>` validates a config file, `zot scrub <config>` checks
  stored manifest and blob integrity, `zot schema` dumps the config JSON Schema

## Links

Apache-2.0 licensed. A CNCF sandbox project.

- [zot documentation](https://zotregistry.dev)
- [zot on GitHub](https://github.com/project-zot/zot)
- [Configuration reference](https://zotregistry.dev/latest/admin-guide/admin-configuration/)
