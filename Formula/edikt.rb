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
      sha256 "4fa9c28c4874182f0eebc72fce990139ebca24624943ca0045070531066a03d6"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-macos-x86_64.tar.gz"
      sha256 "c3134915c1b386b99d593b97ae42309adbcd676cb7251bb46b620dcd253cdb6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-linux-aarch64.tar.gz"
      sha256 "be7ab911bb8c5338059d80cc55b7aba76dfd37ec1efe9b92ef2aea75e01101ca"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.1/edikt-linux-x86_64.tar.gz"
      sha256 "8d17f6e4a7e6feda57c377fa2e731e80775f68a157d91825e479c151af756bfe"
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
