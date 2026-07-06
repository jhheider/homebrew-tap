class GpgInspector < Formula
  desc "TUI for parsing and inspecting OpenPGP (GPG) packets per RFC 4880 and RFC 9580"
  homepage "https://github.com/jhheider/gpg-inspector"
  version "0.8.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.0/gpg-inspector-macos-aarch64.tar.gz"
      sha256 "e667e0c3163462c8c4df7dc0fa02e2efa429c5bdb02776b96ce54a9227d60c3c"
    end
    on_intel do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.0/gpg-inspector-macos-x86_64.tar.gz"
      sha256 "876260caa468d2bdfb0fa9ce03d1e142661c58f87e59e41c7c1d3db3e7577dc0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.0/gpg-inspector-linux-aarch64.tar.gz"
      sha256 "e7fc2792cf633411ed6059acfc7e4d1ab885df972f1c08a2a5f0a4dce33ddd52"
    end
    on_intel do
      url "https://github.com/jhheider/gpg-inspector/releases/download/v0.8.0/gpg-inspector-linux-x86_64.tar.gz"
      sha256 "718e3534a1ce1bb61b88f33341dff40f2da777886242b991e2622dfedaae2ea1"
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
