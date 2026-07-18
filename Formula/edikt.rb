class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.4"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-macos-aarch64.tar.gz"
      sha256 "6eb8ad4c5217c338cc637f6f1260d47f98d593e4b00f124e91de2f2c996590ef"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-macos-x86_64.tar.gz"
      sha256 "e4e4501c704bc1e7aa0974bcae2b26fec3aabaa55dc941df0f67240ae693177e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-linux-aarch64.tar.gz"
      sha256 "46fd57c0243f2855f98d3e4ad99dd7b978110f4da65bacfa8cf83eccc72fd892"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-linux-x86_64.tar.gz"
      sha256 "a5b7594de21dee1cdb879cdf3844250b9895c2d12da4058e18ccd0d39deda71c"
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
