class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.0/edikt-macos-aarch64.tar.gz"
      sha256 "210d24119dded1963b3b37a390b6aa3f03af768bf573e75979584c5ffb7a2b0e"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.0/edikt-macos-x86_64.tar.gz"
      sha256 "6787415409a5a6bd37508e0e101188313d50d04b66620645aa374fd1a22b8352"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.0/edikt-linux-aarch64.tar.gz"
      sha256 "fafa72910cbb1c1cbf3f9a2ad9904f1cc8392830dca31d3144a97a0f5b129330"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.0/edikt-linux-x86_64.tar.gz"
      sha256 "b714a7bdd4ef4fc555d7df8045e923794c8d0dc26204e026e2769366994cc88a"
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
