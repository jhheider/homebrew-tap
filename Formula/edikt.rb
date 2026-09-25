class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.1/edikt-macos-aarch64.tar.gz"
      sha256 "f53c7d57a42e2244a25799385035d14c91c62cd523d2e34e0eeac13138b745df"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.1/edikt-macos-x86_64.tar.gz"
      sha256 "9e0be5ee752c272206e8d059515a9fbbd75b172f857c608592cd1a6ac7c331fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.1/edikt-linux-aarch64.tar.gz"
      sha256 "a41661df78440208d202b6c3ae55020088c41fda6b878f164b55fa60b5d6f8c9"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.5.1/edikt-linux-x86_64.tar.gz"
      sha256 "06fe28b2110f3995d314ee9fb07a71b14c8a40293dea206c1a8c7d0c98a931ec"
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
