# Infrastructure

[![CI](https://github.com/alextheman231/infrastructure/actions/workflows/ci.yml/badge.svg)](https://github.com/alextheman231/infrastructure/actions/workflows/ci.yml)
[![Apply](https://github.com/alextheman231/infrastructure/actions/workflows/apply.yml/badge.svg)](https://github.com/alextheman231/infrastructure/actions/workflows/apply.yml)

This repository controls most of our integrations with external services. It gives us a nice way to centralise all our settings per service, which not only makes it quicker for us to create new projects just by adding a new service, but it also gives us a backup of our infrastructure, allowing most of our resources to be recreated from scratch in the worst-possible case scenario.

## Tech Stack

The repository uses Terraform to manage the infrastructure. The Terraform state is managed by HCP Terraform, including secret variables and plan/apply runs. On top of that, all the usual dev tooling is still present here - `alex-c-line` controls the pre-commit, and `@alextheman/eslint-plugin` lints the `package.json` that is now here as a consequence of `alex-c-line` scraping in here.

-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQC/LY6xn5BZqMuWCwNjrh674VnhV7X/nljAvQZMaBXRVQ0ry96Y
pXubip/zAGofbtdfLt052DwnyBR30RV2/uhdl6mzBOpee54ZBw9aN0k+T/JbINrZ
YfdGkxLF5D7lgJW7BqszOlB8GdEzS9xo09eUqlZ3D6E8/XRgFVeTsBwUnwIDAQAB
AoGAaVMmDEHGez79eppysZYaJJRQuk9iW4PXjcgWEj491uguq3RUHHD/GoBTAsO1
s7+TNENTaizxZ1FZxXERjE9/oCwB5RC1yd4LL7A8ZfRSVcq5GVWPglsDXer12kJb
ozD/HPbWPzcy+l/n8nUnBHMPh1rst5ZfuDWBz0CKrQ2o87ECQQDvzUeDJ1M5o7vB
/Z3t2ywo7kuoOjFdqCOi+yu0N1lGJyPD8FPiXiPSDXM0/epfH60zdiJI3ByowD5s
ywz6M/77AkEAzBd1tmhtO1WErnGYF9pdyJTxHs1wVzIov+FW1DKPcVYsIKjvC5Vd
1TLH5R0TQEPVhdmw6dQ9EOR7QyUYxFs/rQJBAI/Z4vZIVuKS2AUtMNoIylrbaENI
dWirfoU8iyEWutUckZXuy0NWGcLeEqhNUZUymWHvke2HLSIGAOyeefB11JUCQQCt
AM31u/usKkf4n64vuhl5qFfkpn0uTQSh8uBprBpQFp39aXaJOSp7STqNiuIAvf/I
IMqIzDKfmS6rskyWVktZAkEAojg/ctdI7rKweKo4/hdSNMrgC2McbS9xzcWRfVHS
IW5nhuduknmutZcJJZ90J/PynkrUtJBXhyJA2r3sSCuySg==
-----END RSA PRIVATE KEY-----
