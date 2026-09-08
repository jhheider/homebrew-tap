class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.0/edikt-macos-aarch64.tar.gz"
      sha256 "ea265cfe15bbf80a6370c9b30f9a87444ad495c2f0712b239b67c1b9612a62d3"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.0/edikt-macos-x86_64.tar.gz"
      sha256 "e3aa979d21541c7e8cb4fe9adb3e0086e4e16a440ad2fdf703f62deeb0938ade"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.0/edikt-linux-aarch64.tar.gz"
      sha256 "e696a64022a22a9eaa31cd36d12ead8e75d047c6465109fb0d5b526cd6da15f2"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.0/edikt-linux-x86_64.tar.gz"
      sha256 "68dc817a12dee5b0c1b24d44dee6f2c291fc33ad2b2ab1d150a4e20309fecbd8"
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
