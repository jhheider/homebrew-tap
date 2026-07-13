class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.6.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.0/pdcst-macos-aarch64.tar.gz"
      sha256 "47e8a91e8e10fd28e8a21bf7690124bac4adb359329e58afab43a3d426a9a146"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.0/pdcst-macos-x86_64.tar.gz"
      sha256 "91057a094ba3b5f803b6a556e28b9de2908509da7e1859ca8f4c245189627e6d"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.0/pdcst-linux-x86_64.tar.gz"
      sha256 "53612f16796c423c895c7612d751e24387f5f96a937735dceccb5ff3bfedb897"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
