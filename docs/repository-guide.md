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
        ├── senity-1.0.0-1-x86_64.hpkg
        └── ...
```

## 2. Architecture Metadata (x86_64/repo.info)

Each architecture directory requires a repo.info file defining the repository attributes for pkgman:

```
name            SEN Labs Kiri (x86_64)
vendor          SEN Labs
summary         Official package repository for SEN extensions and native Haiku apps
priority        1
url             [https://kiri.sen-labs.org/x86_64](https://kiri.sen-labs.org/x86_64)
architecture    x86_64
```

3. Building the Repository Index Locally

To create or update the binary repository index (repo), run the Haiku tool package_repo inside the specific architecture folder.
See the [Local Build Script](../x86_64/build-repo.sh)

4. Automated Deployment via GitHub Actions

A [GitHub Workflow](../.github/workflows/deploy.yaml) automatically rebuilds the package index whenever new .hpkg files are pushed to any architecture path.
