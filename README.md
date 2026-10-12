<p align="center">
  <img src="images/kiri-repo-logo_small.png" alt="Kiri Repository Package Logo" width="280">
</p>

# 桐 Kiri Package Repository

> **SEN Labs Official Package Repository for Haiku OS**  
> Hosted at [`https://kiri.sen-labs.org`](https://kiri.sen-labs.org)

**Kiri** (桐, inspired by traditional *Kiribako* wood craft boxes) provides native Haiku packages (`.hpkg`) for the SEN ecosystem and related open-source applications.

---

## 🚀 Quick Start for Haiku Users

Add the repository to your Haiku system with `pkgman`, then install what you need:

```bash
# add the repository for 64-bit Haiku
pkgman add-repo https://kiri.sen-labs.org/x86_64

# get the list of packages, and install some
pkgman refresh
pkgman install sen_core
```

`pkgman add-repo` checks the repository against its checksum (`repo.sha256`); packages that are installed from it are updated with `pkgman update`.
To remove the repository again: `pkgman drop-repo "SEN Labs Kiri (x86_64)"`.

### Packages

| Package | What it is |
|---------|------------|
| `sen_core` | the SEN server (relations between files, queries, the item in the Deskbar) and the command `sen`; brings `sen_oni` and `sen_ontology_core` |
| `sen_oni` | the ontology installer: puts the MIME types of the ontology packages into the MIME database (`sen_oni --update`) |
| `sen_ontology_core` | the core ontology of SEN: relations, classifications, entities |
| `sen_ontology_books`, `sen_ontology_movies`, `sen_ontology_music`, `sen_ontology_sourcecode` | ontologies for these domains (they need `sen_ontology_core`) |
| `sen_plugins` | brings all the SENSEI plugins below (one installation for the whole set) |
| `sen_plugin_pdf_extractor`, `sen_plugin_markdown_extractor`, `sen_plugin_sourcecode_extractor`, `sen_plugin_mime_extractor` | extract the relations inside files: PDF bookmarks, Markdown links, includes/imports/modules of source code (C family, Go, Java, JavaScript/TypeScript, Python, Rust), the attributes of a MIME type; the source code plugin also identifies the language |
| `sen_plugin_pdf_navigator`, `sen_plugin_text_navigator`, `sen_plugin_reference_navigator`, `sen_plugin_relation_navigator` | open the target of a relation: a place in a PDF, a text, a reference, a relation file |
| `sen_plugin_book_enricher` | looks up metadata of books online |
| `toji` | a universal document reader for Haiku, extended for SEN |
| `mupdf1.28`, `mupdf1.28_devel` | the MuPDF library that Toji renders with (and its headers) |

More SEN packages (the Akita file manager) come here as they are published. Look at what is there now with
`pkgman search -a` (all repositories) or on [kiri.sen-labs.org/x86_64/packages](https://kiri.sen-labs.org/x86_64/packages/).

---

## 🏛️ Repository Architecture & Layout

Kiri is structured to support multiple CPU architectures cleanly under distinct URL subpaths:

```text
https://kiri.sen-labs.org/
├── x86_64/              # 64-bit Haiku repository
│   ├── repo             # Binary repository index
│   ├── repo.sha256      # Checksum of the index, checked by pkgman add-repo
│   ├── repo.info        # Repository metadata
│   └── packages/        # .hpkg package files
└── docs/                # Architecture & deployment documentation
```

## 📚 Documentation

For detailed information on maintaining, building, and deploying the repository, see the documentation in docs/:
* [Repository Maintenance & Deployment Guide](docs/repository-guide.md)
* [Package Management Guidelines](docs/package-guidelines.md)

🛠️ Maintainer & Contact

* Publisher: [SEN Labs](https://sen-labs.org)
* License: MIT / Open Source
