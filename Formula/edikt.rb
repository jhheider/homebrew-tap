class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.2/edikt-macos-aarch64.tar.gz"
      sha256 "857bb01894a6b4b415064b52b666d672efb3d53fe90ecd310d6be5c07a12cc5d"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.2/edikt-macos-x86_64.tar.gz"
      sha256 "691cc1c66029dd9054d8f09273188879fe3c25b49fe1455ba9bad48576e8b1bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.2/edikt-linux-aarch64.tar.gz"
      sha256 "842ccd8a065115bb2fcf3dc844c8c92ac71836b382a86efed0c1851b774b3423"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.2/edikt-linux-x86_64.tar.gz"
      sha256 "b7d20c158253a51642fe8cbb84f087e072d28cbb35789a51d28fb1ca52a7efd8"
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
