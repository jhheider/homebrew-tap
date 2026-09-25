class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.6.0/edikt-macos-aarch64.tar.gz"
      sha256 "667b819c6acf7cc0c6ac226c325110d2fccebdd65e24e1eea58410ae25ca5ce1"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.6.0/edikt-macos-x86_64.tar.gz"
      sha256 "6f10d9e123b36d2fb06321553a1a80e388f28fc8b67dfa0895a306e851c165bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.6.0/edikt-linux-aarch64.tar.gz"
      sha256 "c3ed75677d3c444f102923b3a4c9b6f002cb487730974c1253c23afae571bc6a"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.6.0/edikt-linux-x86_64.tar.gz"
      sha256 "a20f315ec05622b1385343f3ec4af196c9844ae5623d58e33945d1219b0689c2"
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
