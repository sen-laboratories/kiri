# Package Guidelines for Kiri

## Naming Conventions
Follow standard Haiku package naming rules:
`<vendor_or_app>-<version>-<release>-<architecture>.hpkg`

**Example:**
`senity-0.1.0-1-x86_64.hpkg`

## Adding a New Package
1. Drop the compiled `.hpkg` into the target architecture folder (e.g., `x86_64/packages/`).
2. Commit and push to `main`.
3. The GitHub Action will re-index the repository and deploy `repo` automatically.
