class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.5"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.5/edikt-macos-aarch64.tar.gz"
      sha256 "5ea39e3c114ba7106dfa3ae56893a86dc511c47c396412aad9169df3e9faf26e"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.5/edikt-macos-x86_64.tar.gz"
      sha256 "e5ec254f1349c291bcf3cc2516d9b71cfa7feba8774cc7313c16bb8606cd5b63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.5/edikt-linux-aarch64.tar.gz"
      sha256 "2391f5a2b1f8a0de8bcd0b249dc57f6c93f9b89aa1bd4e35ece95254a74736de"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.5/edikt-linux-x86_64.tar.gz"
      sha256 "8a32146d4b5a97d38f3ba05070a0ba958f0e153d5b3f0858e255239d978145af"
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
