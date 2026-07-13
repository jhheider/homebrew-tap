class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.3.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.0/penknife-macos-aarch64.tar.gz"
      sha256 "df20eca76c08fe1f139f63cefb826f41ae48ffc60c5857d214191ccda017c406"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.0/penknife-macos-x86_64.tar.gz"
      sha256 "2959a6e92497fc863008eb9f261af9c25c51ad0aef51a69241410e8ab1cafa7c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.0/penknife-linux-aarch64.tar.gz"
      sha256 "10b58bba6046a1783a9747c397f9a3713dad49a1ecc65fd9034bb46a2d7bd7bd"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.0/penknife-linux-x86_64.tar.gz"
      sha256 "d40458ffc6b29ba6b603e619eedc26583cd1bf5ba1ff69254e7a73234e01428c"
    end
  end

  # The release tarball is just the binary (plus README/ABOUT/LICENSE), so
  # nothing is built here.
  def install
    bin.install "penknife"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/penknife --version")
  end
end
