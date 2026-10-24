class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.6.3"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.3/pdcst-macos-aarch64.tar.gz"
      sha256 "8facfa980818d628f039299465fb195042bcb6b274b0e7e173aebd1c29e085c7"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.3/pdcst-macos-x86_64.tar.gz"
      sha256 "2b5b29a462e4232548b610791ea920d7a74841c2dde64c6c22d08538e250bf9f"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.3/pdcst-linux-x86_64.tar.gz"
      sha256 "ba0eccc5bc940f808f6bfe52a18f01c3cb807e90bbf6997ecd1814ee05f1cadb"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
