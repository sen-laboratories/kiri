# qpdf for Kiri

[qpdf](https://qpdf.org) (Apache-2.0) is a library and a set of programs that read and change the *structure* of PDF files: the document structure, the info dictionary and the XMP
metadata, the outlines, pages, annotations and attachments, encryption, repair. It does not extract text or draw pages. HaikuPorts has no recipe for it, and SEN's plugins use it
(`sen_plugin_pdf_extractor` reads the outlines of PDF files), so Kiri brings it as the packages `qpdf` (the library, the programs, the licenses) and `qpdf_devel` (the headers and the
pkg-config file), the way `mupdf1.28` is brought.

```sh
./package.sh [<folder of the qpdf source>]     # run on Haiku; default source: $QPDF_SRC or /Develop/3rd-party/qpdf
```

It builds the source with CMake (shared library only, the crypto of OpenSSL, no documentation) and makes `qpdf-<version>-<revision>-x86_64.hpkg` and `qpdf_devel-...` in `./out`
(`OUT_DIR`). The build needs `cmake`, `zlib_devel`, `libjpeg_turbo_devel` and `openssl3_devel`; the packages require `lib:libz`, `lib:libjpeg`, `lib:libssl` and `lib:libcrypto` (the script
prints what the library and the program need, to check this list). The version is the one of the source; the version of the library (SONAME, `libqpdf.so.30.4.2`) is read from what was built.

Notes: no cmake package files (their relative paths do not survive the move of the library into the development folder; programs use `-lqpdf` and `pkg-config libqpdf`). Programs that link
the library (`sen_plugin_pdf_extractor`) can require `lib:libqpdf` instead of bringing their own copy once the package is in the repository.

This is our own build script, not a HaikuPorts recipe. (HaikuPorts: no policy file about LLM-written contributions, a checkbox "You are not a robot" in the pull request template, and the Haiku
copyright policy that excludes "most content produced with the use of LLMs"; a recipe for HaikuPorts is to be written by a person.)
