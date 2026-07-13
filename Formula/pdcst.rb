class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.5.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.5.0/pdcst-macos-aarch64.tar.gz"
      sha256 "cedad4bb565d568b12f514b6e9e399d09792fc12c4f87ed7dec44621e29877d2"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.5.0/pdcst-macos-x86_64.tar.gz"
      sha256 "fcc69be03f83ae5ab0107a5bf07a53d7f5c348fa3841b575933d1cc2ba62060a"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.5.0/pdcst-linux-x86_64.tar.gz"
      sha256 "f6d3c26746478e5cd6f3c16312bf05a306c77004a238e7d5cd3af3fe1827b5d6"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
