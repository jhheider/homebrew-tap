class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.4.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.4.0/pdcst-macos-aarch64.tar.gz"
      sha256 "980341a2951622bc445550f5a480a2ddfd776d058032aabca334c94d804d1af3"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.4.0/pdcst-macos-x86_64.tar.gz"
      sha256 "f8f27824deecab5a77a90b00b6c9d8790389af3b6987b07622e5a807288bff81"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.4.0/pdcst-linux-x86_64.tar.gz"
      sha256 "0ce0f1ada144feee9c15cf09e64c2850172392ce79957339d882e8c30c36141f"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
