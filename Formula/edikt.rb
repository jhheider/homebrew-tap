class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.8.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.1/edikt-macos-aarch64.tar.gz"
      sha256 "098312bdf6897d3741f681d1f44fcb775aa02428b1e357276f69e26a77e07ea6"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.1/edikt-macos-x86_64.tar.gz"
      sha256 "1c536a83fdb338da148ff366d752affc3268ee206ab3a68ca2d7cd75d1c90710"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.1/edikt-linux-aarch64.tar.gz"
      sha256 "0d1194bda0b91a17fe992d015b26eddf80352213e8312cdae4a46e263dfc6986"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.1/edikt-linux-x86_64.tar.gz"
      sha256 "c9609b32596c47443c0849b8215a75c7c5e8e8c0ad707b009a8dd24fcbd88602"
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
