class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.3.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.3.1/pdcst-macos-aarch64.tar.gz"
      sha256 "a18d10b3c6c19769032fe11e9d6470e0ae55831d5d7d461ec4c5cd530874ff1d"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.3.1/pdcst-macos-x86_64.tar.gz"
      sha256 "597d9d3cc013dc0777e80324c32644de8637cfc3e16797403f8ed1c513ca7ede"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.3.1/pdcst-linux-x86_64.tar.gz"
      sha256 "05f7dfc1d99f4bb900a6caa3f31f3f1cfc3ea85e4a95b83529a5b9e7d9b0b6c5"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
