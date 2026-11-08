class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.9.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.9.0/edikt-macos-aarch64.tar.gz"
      sha256 "73275fe20864781492c57e8929a02b7387b9166fa6bbd7c645e5e62173e9ed90"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.9.0/edikt-macos-x86_64.tar.gz"
      sha256 "ebafec0ce5ef4e8be46db4e0887302462d3adb4caad35cec0e310bb01894b9d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.9.0/edikt-linux-aarch64.tar.gz"
      sha256 "b33a57873d464cd9f7c25ada7b95e6a37cd12633bdd6b487820b7722b95082c1"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.9.0/edikt-linux-x86_64.tar.gz"
      sha256 "8fb238f76c45b7fe282e4c2ed5442dce0dd8a87997f5fb9eb1176edaa5d0dfc9"
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
