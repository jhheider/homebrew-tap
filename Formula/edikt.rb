class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.8"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.8/edikt-macos-aarch64.tar.gz"
      sha256 "440ff07c404ab3c33c686804cac57666706d7e26fe45513395cda40d7d678024"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.8/edikt-macos-x86_64.tar.gz"
      sha256 "f43d102afabb7da9977c9d09fbd927e9e89f5115d3944201cf8c52d0fd8616de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.8/edikt-linux-aarch64.tar.gz"
      sha256 "a53e18a77da60a010537e1ed11902fe8d67ee9193a7e358fee17e98ab1ef2558"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.8/edikt-linux-x86_64.tar.gz"
      sha256 "3022c68c8c8ee0bc79308fd03eee62b6c06b3925b2e97dd68ed533a37c35e17c"
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
