# jhheider/homebrew-tap

Homebrew formulae for [@jhheider](https://github.com/jhheider)'s tools.

## Usage

```sh
brew tap jhheider/tap https://github.com/jhheider/homebrew-tap
```

Then install any of the formulae below.

## Formulae

| Formula | Description |
|---------|-------------|
| [`semverator`](Formula/semverator.rb) | Command-line tool for working with semantic versioning (libpkgx implementation) |
| [`gpg-inspector`](Formula/gpg-inspector.rb) | TUI for parsing and inspecting OpenPGP (GPG) packets per RFC 4880 and RFC 9580 |

```sh
brew install jhheider/tap/semverator
brew install jhheider/tap/gpg-inspector
```

All three are built from source with Cargo, so a Rust toolchain is fetched at
build time (`depends_on "rust" => :build`).
