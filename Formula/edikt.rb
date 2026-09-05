class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.4.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-macos-aarch64.tar.gz"
      sha256 "1d7e06a4449689b93e26d88af165922b7148d062ff6a530c554840506b72b3d0"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-macos-x86_64.tar.gz"
      sha256 "f6d990cd3164d70f7f4a8aec7afbe748e68bac39499d4ebd1087e8e1dcf8c25f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-linux-aarch64.tar.gz"
      sha256 "4e108c14b8f03172031b83680bdec8d2791b4cd66e9beb9898aca8f5ef8719cc"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-linux-x86_64.tar.gz"
      sha256 "89b220bf990443c2e98fd594e3afe393f2d685bc4199102bee425b0058c74210"
    end
  end

  # The release tarball bundles the binary plus the generated man page and shell
  # completions (clap_mangen / clap_complete), so nothing is built here.
  def install
    bin.install "edikt"
    man1.install "edikt.1"
    bash_completion.install "edikt.bash" => "edikt"
    zsh_completion.install "edikt.zsh" => "_edikt"
    fish_completion.install "edikt.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/edikt --version")

    # Query a scalar (stdin needs an explicit format).
    assert_equal "1\n", pipe_output("#{bin}/edikt -t json .a", "{\"a\":1}")

    # The whole point: a lossless in-place edit keeps comments and layout.
    (testpath/"c.jsonc").write <<~JSONC
      {
        // keep me
        "port": 8080,
      }
    JSONC
    system bin/"edikt", "-i", ".port = 9090", testpath/"c.jsonc"
    assert_match "// keep me", (testpath/"c.jsonc").read
    assert_match "9090", (testpath/"c.jsonc").read
  end
end
