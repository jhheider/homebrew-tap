class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.4.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.4.1/pdcst-macos-aarch64.tar.gz"
      sha256 "af8a511e0a21c3cf1246d284f2272997d8beac6529e7caf06b71f96f6be160ac"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.4.1/pdcst-macos-x86_64.tar.gz"
      sha256 "164992ed9630dfb3b20a1dd83662e4dd344419fabb589f713562636f5221b0a7"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.4.1/pdcst-linux-x86_64.tar.gz"
      sha256 "1b7d3df988ba8c14e760f736431ade57a6cabf6ebc364097494184e6c4356fe4"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
