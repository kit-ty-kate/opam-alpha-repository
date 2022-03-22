# OPAM Alpha Repository

This is an [opam](https://opam.ocaml.org) repository that contains packages
compatible with the next release of the OCaml compiler.
This repository is only meant to be used for testing purposes and contains
non-upstreamed patches/branches.

To activate this repository in your current opam switch:
```
opam repo add alpha git://github.com/kit-ty-kate/opam-alpha-repository.git
```

This will add the `alpha` remote as a non-default extra source of opam
packages.

## Side note on the OCaml Beta Repository

To be able to install beta or dev versions of the compiler you will have to
activate the [ocaml-beta-repository](https://github.com/ocaml/ocaml-beta-repository)
as well first.

For instance, to install OCaml 4.10.0beta1 and get access to opam-alpha-repository
right off the bat:
```
opam switch create 4.10.0+beta1 --repo=default,beta=git://github.com/ocaml/ocaml-beta-repository.git,alpha=git://github.com/kit-ty-kate/opam-alpha-repository.git
```
