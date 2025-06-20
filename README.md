# IntegriDB – Authenticated Interval Tree (AIT) in OCaml

IntegriDB is a toy authenticated database prototype built using **authenticated interval trees (AITs)** in OCaml. It allows clients to perform verifiable range queries over ordered key-value pairs, such as employee salaries, while maintaining cryptographic integrity of the results.

---

## Features

- Builds an **authenticated binary tree** over sorted key-value data.
- Supports **range queries** over any comparable key type.
- Uses the [BLAKE2b](https://en.wikipedia.org/wiki/BLAKE_(hash_function)) cryptographic hash for node authentication.
- Pure functional OCaml implementation.
- Interactive CLI for user-supplied query bounds.

---

## Requirements

- OCaml ≥ 4.14
- [Opam](https://opam.ocaml.org/) package manager
- [Digestif](https://github.com/mirage/digestif) library for cryptographic hashing

### Install dependencies

```bash
opam install digestif dune
