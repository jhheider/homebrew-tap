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
      sha256 "643b5de5347e49be2fed5e364f106403078b4ec11572c83773cb8cb28b11e501"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-macos-x86_64.tar.gz"
      sha256 "7e8b67cf54b2064cda8256f520315c614344bb993adaa9d516fbf6c442dad97c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-linux-aarch64.tar.gz"
      sha256 "38f7f6dc48ef2b327124809308277d68106b53d9493b7ec380d630934f230971"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-linux-x86_64.tar.gz"
      sha256 "d4f77b39042de97b12d80ceb7771279b5f6b36bef1a39d5107b8537127d9e566"
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
