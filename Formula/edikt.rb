class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  version "0.2.6"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.6/edikt-macos-aarch64.tar.gz"
      sha256 "80da0a4a6ab14635828505b2d541f4547cf66ce0184b520e2490231ba236fd95"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.6/edikt-macos-x86_64.tar.gz"
      sha256 "ee1813bfac746ae6406964df1aab53dd5792355e68107bbb46656b27efe580f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.6/edikt-linux-aarch64.tar.gz"
      sha256 "006a3c674d5abcf6a8775c62f402725dead3bf0d4a711f50da1ffd6d5df3adbd"
    end
    on_intel do
      url "https://github.com/jhheider/edikt/releases/download/v0.2.6/edikt-linux-x86_64.tar.gz"
      sha256 "fb61e547d33f2f238325419f3c8b1e1324fa4bc1db6aeb5a49f1068e2c0e10d2"
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
