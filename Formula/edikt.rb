class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.7"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.7/edikt-macos-aarch64.tar.gz"
      sha256 "0ee92eecd7a8803f3f6b18d755a88810ba9a3d4138b6d619f91dc520578151e7"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.7/edikt-macos-x86_64.tar.gz"
      sha256 "0260a4a16e1a2407e3f71c225244412962b9b278233ad501bfd4928705cfc196"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.7/edikt-linux-aarch64.tar.gz"
      sha256 "cf869a86afea50f0a3ab3f79f2f71eb9f22907700fd03600f73cb848ce7f234c"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.7/edikt-linux-x86_64.tar.gz"
      sha256 "8f1708cfded3bbe4472a2d9620d335d9d6abbec385e7465333b2a0fe2df178b7"
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
