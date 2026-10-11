# Package Guidelines for Kiri

## Naming Conventions
Follow standard Haiku package naming rules:
`<vendor_or_app>-<version>-<release>-<architecture>.hpkg`

**Example:**
`sen_core-1.0.0~dev-1-x86_64.hpkg`

The name of a package uses underscores (`sen_core`), the version comes from the application resource of the program (a development build is a
pre-release: `1.0.0~dev`, which is older than `1.0.0`).

## Adding a New Package
1. Drop the compiled `.hpkg` into the target architecture folder (e.g., `x86_64/packages/`).
2. Commit and push to `main`.
3. The GitHub Action will re-index the repository and deploy `repo` automatically.
