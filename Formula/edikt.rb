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
      sha256 "f254492da279acc7cb24d1429fbcaf6834914633cbc69bf0733cbbe6ac991728"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-macos-x86_64.tar.gz"
      sha256 "63639632cb3c89564a5ef920a38a9ce2628cefed76fe72fa6bf781d3956a0446"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-linux-aarch64.tar.gz"
      sha256 "b818462a32799e746ea9471766da6deebad51ae5e1158b3ec86d326197ed08ea"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.4.1/edikt-linux-x86_64.tar.gz"
      sha256 "634342cd5dbbe2e408974e86c143cfa6dc8c6b348ac2844846135c234de897a0"
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
