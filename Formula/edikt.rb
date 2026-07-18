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
      sha256 "125d87fb9ca435875946e6d0e916e1987a4cc5f2ebad60ce7626e649597abb2a"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-macos-x86_64.tar.gz"
      sha256 "6598bf06143045732ee1258c4b60bd2d9add4ec13307db251c47216915bd1489"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-linux-aarch64.tar.gz"
      sha256 "76fc0823334f782f766860343f176aa8d58fd11ae60c281c9d9535460c3493a7"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.4/edikt-linux-x86_64.tar.gz"
      sha256 "36db9f20d7b1cf3fa080df651184df4cbcb56009dae018ba8a842057948de344"
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
