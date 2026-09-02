class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.1/edikt-macos-aarch64.tar.gz"
      sha256 "4bd0ef556354c516b4e8bedcddca7a5377aef767c6749a3d182120c60311f590"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.1/edikt-macos-x86_64.tar.gz"
      sha256 "37f12b5fd04c719249b0f62df994f3faaeb80a78b278ec558cac5254e5827c8a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.1/edikt-linux-aarch64.tar.gz"
      sha256 "2f54099bfd720ebba31385d0d39ab5033bf8d417ea6343d7141dbc7b611f1f89"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.3.1/edikt-linux-x86_64.tar.gz"
      sha256 "536dbc14958b6486834c22c449d824f6654aa6f625a50e1b81f465203fd84090"
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
