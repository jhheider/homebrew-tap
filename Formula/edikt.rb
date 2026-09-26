class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.7.0/edikt-macos-aarch64.tar.gz"
      sha256 "cf22a2af96dd2be9cc3e82e0f5880e3be09add43780898e5d235b346f3f10964"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.7.0/edikt-macos-x86_64.tar.gz"
      sha256 "f7810a89b51f5d71c0ddffb647de0ded41e048ec4b1eed1dc73172a139877f4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.7.0/edikt-linux-aarch64.tar.gz"
      sha256 "418b927af94a54790cb2320b2793498b034b5e12698a81fbe13ec6d7d2c49e7a"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.7.0/edikt-linux-x86_64.tar.gz"
      sha256 "2470b72512b43844c7697bb28a8f60458274ab3d3dff14a1ed033d0ad2132f30"
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
