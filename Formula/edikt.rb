class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.0/edikt-macos-aarch64.tar.gz"
      sha256 "862155aa386d3f45f29c03f7078657b2590567ab304a995af1747f865f4ddc40"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.0/edikt-macos-x86_64.tar.gz"
      sha256 "42ff80848427e37c49967d9da96adebbc4b86c7845dccb7c625be2458747ecbe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.0/edikt-linux-aarch64.tar.gz"
      sha256 "4289f56c9214581030abccf1580f01d1ed978709201dda6e1fb2d5e9f12ed1f8"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.0/edikt-linux-x86_64.tar.gz"
      sha256 "e910ce0e94a90d2046836c8fc00d44dc1b36a3c550ab959d28c7af64bafb396a"
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
