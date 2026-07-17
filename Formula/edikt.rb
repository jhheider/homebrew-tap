class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.3"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.3/edikt-macos-aarch64.tar.gz"
      sha256 "3352146ef5baa0a51b5669ec56279dbb653554d34752badbad90822a3a09b66e"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.3/edikt-macos-x86_64.tar.gz"
      sha256 "0d9d6291ce19f27bc7b0f860c46536970a4e11be2db94c3e58bd224a57d1194e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.3/edikt-linux-aarch64.tar.gz"
      sha256 "71fec6231a26c8a42ee182ed5d3d4c883c55da5a75989ddea0c294f6b7a90120"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.3/edikt-linux-x86_64.tar.gz"
      sha256 "9f76bb263d0d49bd74e40423c61fdbec5df3cba381c6c52710db93c3d52b45c5"
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
