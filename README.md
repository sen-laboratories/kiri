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
| `akita` | the Tracker of SEN: the file manager with relations. Replaces Tracker at the next login (the command `akita` switches: `akita start`, `akita stop`) |
| `sen_oni` | the ontology installer: puts the MIME types of the ontology packages into the MIME database (`sen_oni --update`) |
| `sen_ontology_core` | the core ontology of SEN: relations, classifications, entities |
| `sen_ontology_books`, `sen_ontology_movies`, `sen_ontology_music`, `sen_ontology_papers`, `sen_ontology_people`, `sen_ontology_sourcecode` | ontologies for these domains (they need `sen_ontology_core`) |
| `sen_ontology_spatial` | places and locations, and the spatial relations between them: within, covered by, touches, overlaps, equal to, what is nearby a place, located near (needs `sen_ontology_core`) |
| `sen_filetypes` | FileTypes with the fields for lists of values (`SEN:is_list`); `sen_core` needs it |
| `shoji` | the entity editor of SEN: a form for the attributes of a file, from a template for its type (people, papers, books, contacts) or generated from the type |
| `sen_plugins` | brings all the SENSEI plugins below (one installation for the whole set) |
| `sen_plugin_pdf_extractor`, `sen_plugin_markdown_extractor`, `sen_plugin_sourcecode_extractor`, `sen_plugin_mime_extractor` | extract the relations inside files: PDF bookmarks, Markdown links, includes/imports/modules of source code (C family, Go, Java, JavaScript/TypeScript, Python, Rust), the attributes of a MIME type; the source code plugin also identifies the language |
| `sen_plugin_document_reference_navigator`, `sen_plugin_text_reference_navigator`, `sen_plugin_reference_navigator`, `sen_plugin_relation_navigator`, `sen_plugin_authorship_navigator`, `sen_plugin_personal_relation_navigator` | open the target of a relation: a place in a PDF or a text, a reference, a relation file, the author of a book or paper, a person that someone knows (the first two replace `sen_plugin_pdf_navigator` and `sen_plugin_text_navigator`) |
| `sen_plugin_book_enricher` | looks up metadata of books online (OpenLibrary) and makes the authors |
| `sen_plugin_movie_enricher` | Akari: looks up movies at The Movie Database (needs a free API key, set in the settings window of SEN) and makes the director, the crew and the cast people with a Contribution to the movie. *This product uses the TMDB API but is not endorsed or certified by TMDB.* |
| `sen_plugin_paperboy` | identifies scientific papers (PDF, EPUB), looks up their metadata and open access copies (OpenAlex, arXiv, Semantic Scholar, DBLP, Unpaywall), extracts the papers they cite, and makes the authors people (ORCID, Wikidata) |
| `sen_plugin_spatial_navigator` | works out the spatial relations between places when they are opened (GEOS; Wikidata for what contains a place) and lists what is nearby a place (OpenStreetMap, Overpass API: the server is chosen in the settings window of SEN) |
| `sen_plugin_place_enricher` | Spaces: looks up places and locations (OpenStreetMap Nominatim, Wikidata), by name, position or address; makes the places that contain them and finds the places near a position |
| `sen_plugin_person_enricher` | Robin: finds the photo, the profile, the accounts and the posts of a person from the links of its file (Libravatar and Gravatar by the hash of the e-mail address, GitHub, the Fediverse, Bluesky, the feed of a homepage); which services may be asked is set in the settings window of SEN |
| `basho`, `basho_devel` | the location server: where this computer is, roughly (from its internet address, only if you allow it, and only as fine as you allow, for each program); a client class and the command `location`. It does not need SEN, which uses it |
| `toji` | a universal document reader for Haiku, extended for SEN |
| `mupdf1.28`, `mupdf1.28_devel` | the MuPDF library that Toji renders with (and its headers) |
| `qpdf`, `qpdf_devel` | the qpdf library (HaikuPorts has no recipe); the PDF extractor needs it |

More SEN packages come here as they are published. Look at what is there now with
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
