class Pdcst < Formula
  desc "Fast, keyboard-driven terminal podcast player with an auto-managed queue"
  homepage "https://github.com/jhheider/pdcst"
  version "0.6.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.2/pdcst-macos-aarch64.tar.gz"
      sha256 "200caa7a82bb47aba931c0121543434654874b30600f7f27d12d2c79d3e367e5"
    end
    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.2/pdcst-macos-x86_64.tar.gz"
      sha256 "595d8a4af55c88cda651f91d6c2f6be02509b205b3545ef1ff2b0701a5146488"
    end
  end

  on_linux do
    # glibc build with dynamic libasound (rodio/ALSA cannot static-link cleanly).
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/jhheider/pdcst/releases/download/v0.6.2/pdcst-linux-x86_64.tar.gz"
      sha256 "ed3162584c96d2df85ee9f95ba6d3b185eb35d674988ad8a0161ff37cc1cc9a7"
    end
  end

  def install
    bin.install "pdcst"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pdcst --version")
  end
end
