class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.6.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.1/pdcst-macos-aarch64.tar.gz"
      sha256 "3fe49255ab440b565de02120e5535a760fd7e12f5ed37b58dbce5fff7db2b5f1"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.1/pdcst-macos-x86_64.tar.gz"
      sha256 "08fb699c6a0b0770cb69a95b2722aff57ba37aafa85b7f0ea15ae69fa2176062"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.1/pdcst-linux-x86_64.tar.gz"
      sha256 "fcf8203824b371a7824b75e52c1e7eaf9e8dc15e8bfc4fcce9136123f9359d44"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
