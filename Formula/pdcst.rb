class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.3.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.3.2/pdcst-macos-aarch64.tar.gz"
      sha256 "e20dab46279fe4014c88957ab9203300272374a099f8424e7d4fa0ff1a93320b"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.3.2/pdcst-macos-x86_64.tar.gz"
      sha256 "61f08350def7015d84bb4d0b83278a6ae5fee6ecb556de51f36e18d711d8088e"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.3.2/pdcst-linux-x86_64.tar.gz"
      sha256 "40e081451c0a40d79e501f39aa3021e60be8a09019922760d1fd61a0b14019f7"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
