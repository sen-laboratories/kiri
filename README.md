# Kiri Package Repository 📦🌸

> **SEN Labs Official Package Repository for Haiku OS**  
> Hosted at [`https://kiri.sen-labs.org`](https://kiri.sen-labs.org)

**Kiri** (桐, inspired by traditional *Kiribako* wood craft boxes) provides native Haiku packages (`.hpkg`) for the SEN ecosystem and related open-source applications.

---

## 🚀 Quick Start for Haiku Users

Add the repository to your Haiku system using `pkgman`:

```bash
# Add the x86_64 architecture repository
pkgman add-repo [https://kiri.sen-labs.org/x86_64](https://kiri.sen-labs.org/x86_64)
```

🏛️ Repository Architecture & Layout

Kiri is structured to support multiple CPU architectures cleanly under distinct URL subpaths:
```
[https://kiri.sen-labs.org/](https://kiri.sen-labs.org/)
├── x86_64/              # 64-bit Haiku repository
│   ├── repo             # Binary repository index
│   ├── repo.info        # Repository metadata
│   └── packages/        # .hpkg package files
└── docs/                # Architecture & deployment documentation
```

📚 Documentation

For detailed information on maintaining, building, and deploying the repository, see the documentation in docs/:
* [Repository Maintenance & Deployment Guide](docs/repository-guide.md)
* [Package Management Guidelines](docs/package-guidelines.md)

🛠️ Maintainer & Contact

* Publisher: [SEN Labs](https://sen-labs.org)
* License: MIT / Open Source
