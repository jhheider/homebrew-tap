class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.8.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.0/edikt-macos-aarch64.tar.gz"
      sha256 "00712bb3ee99edac842c22eb22d80c2ab61518e94047913e5300b5a5975a2b34"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.0/edikt-macos-x86_64.tar.gz"
      sha256 "c38318fed91381827bc91842c45dd656d780b889981f881f556c14efd11122c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.0/edikt-linux-aarch64.tar.gz"
      sha256 "26c0c778ac56af77e77b60be69ca681d10cbe4874b9f9a9db0e85b7d7241c106"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.8.0/edikt-linux-x86_64.tar.gz"
      sha256 "c69770b3c358e11cd6459ae07bfc1a271f1f58e2c3002975649d04f36232a8b5"
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
