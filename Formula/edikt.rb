class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-macos-aarch64.tar.gz"
      sha256 "fff3881bc5e68d58c1f3b1361765129cd419708ebf2f1bec0a84a88f34a2f51e"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-macos-x86_64.tar.gz"
      sha256 "c2c6a8c582ab37af449da9fbda596ba01dc41d3343e755066d701ee1b6b3f1d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-linux-aarch64.tar.gz"
      sha256 "bb72923aa974d07bb577e410cba6fce68e56b56e50fad6bf85767bf6ac85b342"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-linux-x86_64.tar.gz"
      sha256 "e98bcad88f62dc6b491ff15d6ebbf27fc61d8b4b68c59c9937300dde97ceec51"
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
