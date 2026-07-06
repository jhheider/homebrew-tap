class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.1.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.1.0/penknife-macos-aarch64.tar.gz"
      sha256 "6f8db2c9f6c5779dd337b74783770b48a1eb1a4c76e111c462b1944a77635f25"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.1.0/penknife-macos-x86_64.tar.gz"
      sha256 "c28b6669984910e2e0c09c7a0a7f1a1ecc794a9329c5c2d243eacb5c3681ed72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.1.0/penknife-linux-aarch64.tar.gz"
      sha256 "6f14c1d9497bdb9cb12a7c7f2739ffbeab01505f76bea69add8165c319d291bb"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.1.0/penknife-linux-x86_64.tar.gz"
      sha256 "db5322ae7fba3a691437b59f3e6002ae5735cc7320ca04136f1e51221b3aad2c"
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
