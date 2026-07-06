class Edikt < Formula
  desc "Lossless, format-preserving editor for JSONC, TOML, YAML, KDL, INI, and .env"
  homepage "https://github.com/jhheider/edikt"
  url "https://github.com/jhheider/edikt/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "27059f804e27113c39413f7611ea5480cc41c2039d80302f8fc1e216ce7a5558"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/jhheider/edikt.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/edikt")

    # The binary generates its own man page and completions (clap_mangen /
    # clap_complete), so packagers do not carry extra build tooling.
    generate_completions_from_executable(bin/"edikt", "--completions", shell_parameter_format: :arg)
    (buildpath/"edikt.1").write Utils.safe_popen_read(bin/"edikt", "--manpage")
    man1.install "edikt.1"
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
