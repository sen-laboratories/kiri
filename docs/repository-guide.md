# Kiri Repository Maintenance & Deployment Guide

This document explains how the Kiri package repository is structured, generated, and deployed to Cloudflare via GitHub Pages.

## 1. Directory Structure

To support multi-architecture setups (e.g., `x86_64`, `x86_gcc2`, `arm64`), each architecture resides in its own subfolder containing its own `repo.info` and package index.

```text
kiri/
├── README.md
├── docs/
│   ├── repository-guide.md
│   └── package-guidelines.md
└── x86_64/
    ├── repo.info
    ├── build_repo.sh
    └── packages/
        ├── sen_core-1.0.0~dev-1-x86_64.hpkg
        └── ...
```

## 2. Architecture Metadata (x86_64/repo.info)

Each architecture directory requires a repo.info file defining the repository attributes for pkgman:

```
name            SEN Labs Kiri (x86_64)
vendor          SEN Labs
summary         Official package repository for SEN extensions and native Haiku apps
priority        1
url             https://kiri.sen-labs.org/x86_64
architecture    x86_64
```

## 3. Building the Repository Index Locally

To create or update the binary repository index (`repo`), run the Haiku tool `package_repo` inside the specific architecture folder, see the
[local build script](../x86_64/build-repo.sh). The checksum that `pkgman add-repo` verifies is the SHA-256 of the index (`repo.sha256`).

## 4. Automated Deployment via GitHub Actions

A [GitHub Workflow](../.github/workflows/deploy.yaml) automatically rebuilds the package index (and the listing of the packages) whenever new `.hpkg` files
are pushed to any architecture path.

## 5. Publishing a SEN package

The packages of the SEN projects are made by the `package.sh` of each project (e.g. `sen-core`). To publish one:

1. Copy the `.hpkg` to `x86_64/packages/` and remove the older version of the same package: the repository keeps one version of each package.
2. Commit and push to `main`; the workflow makes the index.
3. On a Haiku system: `pkgman refresh && pkgman search -D <name>` shows the new version; `pkgman update` installs it.

If the index was not made (the download of the host tools of the workflow can fail now and then), start the workflow again by hand.
