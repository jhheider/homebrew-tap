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
      sha256 "fbafb5d20734ceebd5b289702acb624fb50d36c4d6bfbf7cea92e542aa186222"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-macos-x86_64.tar.gz"
      sha256 "05c5da8783f728fd75c0ad95d2c583d342001b83bc7b40a1cf0d0d81210922da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-linux-aarch64.tar.gz"
      sha256 "6f69881118b2ab1ea17271442d227074a53c9cd14d9b9d63ac7584d03c9d0aa9"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-linux-x86_64.tar.gz"
      sha256 "ea909bec066590f2fe686527f25f140f9629ad9b40441769796ef0c88933bc5e"
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
