class GpgInspector < Formula
  desc "TUI for parsing and inspecting OpenPGP (GPG) packets per RFC 4880 and RFC 9580"
  homepage "https://github.com/jhheider/gpg-inspector"
  url "https://github.com/jhheider/gpg-inspector/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "8f4b3d6ba298843ee2f84e942bbf49ac6d91b9679f865bc689a7a624a78c1c5a"
  license "MIT"
  head "https://github.com/jhheider/gpg-inspector.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/gpg-inspector")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gpg-inspector --version")

    (testpath/"key.asc").write <<~KEY
      -----BEGIN PGP PUBLIC KEY BLOCK-----

      mDMEaknMsxYJKwYBBAHaRw8BAQdAveEBGZGIUobvQVmN4jzDqnLoWkBaQy5tVGCO
      PFxG8zy0IHBrZ3ggdGVzdCA8dGVzdEBleGFtcGxlLmludmFsaWQ+iJMEExYKADsW
      IQRB78GwIj83EQNgSMz0mOgWC5b4CQUCaknMswIbAwULCQgHAgIiAgYVCgkICwIE
      FgIDAQIeBwIXgAAKCRD0mOgWC5b4CWp7AQDBttDKKk6McaSSfalGdYcnZkuRv5ZB
      wnnQugGCQWdNuwD/Wj7/on2OvUPJOP3SWYpDj/7qwfxDQZss6dfWAQXKhQs=
      =6b/0
      -----END PGP PUBLIC KEY BLOCK-----
    KEY

    output = shell_output("#{bin}/gpg-inspector -f key.asc --txt")
    assert_match "Public Key Packet", output
    assert_match "Curve: Ed25519", output
    assert_match "pkgx test <test@example.invalid>", output
    assert_match "Fingerprint (computed): 41EFC1B0223F3711036048CCF498E8160B96F809", output
  end
end
