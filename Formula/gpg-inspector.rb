class GpgInspector < Formula
  desc "TUI for parsing and inspecting OpenPGP (GPG) packets per RFC 4880 and RFC 9580"
  homepage "https://github.com/jhheider/gpg-inspector"
  version "0.8.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.1/gpg-inspector-macos-aarch64.tar.gz"
      sha256 "b10f3cc7347cd27a2942baf2bdd8767c2dbae918e3326e1418224e98a6d6479e"
    end
    on_intel do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.1/gpg-inspector-macos-x86_64.tar.gz"
      sha256 "d9483bc6039dfef8a64c0006ecee2b279da7a7dba8ff8b1d0e3dfd6ba1987bee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.1/gpg-inspector-linux-aarch64.tar.gz"
      sha256 "020ccc5d620f72d172445303fe54003b66d4ade5c03342e6bcb6af152f30c03e"
    end
    on_intel do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.1/gpg-inspector-linux-x86_64.tar.gz"
      sha256 "8e28c42f0a9338ccec1c8a1979398447e3313a8f5090ec985c587c802a938fcc"
    end
  end

  def install
    bin.install "gpg-inspector"
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
