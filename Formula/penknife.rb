class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.2.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.1/penknife-macos-aarch64.tar.gz"
      sha256 "c7981a77d8fff482246e9e72af1d5ed6a430265cf3f88f715bf416d35d8c76d9"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.1/penknife-macos-x86_64.tar.gz"
      sha256 "ea98940182bb96c57ecf3c7dd9551f445da2c572dee7dafe41133d6528924fac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.1/penknife-linux-aarch64.tar.gz"
      sha256 "c4f26ac90f6a791165322698ff996f0d2b428fa14b5650fe370a5ba8699ff532"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.1/penknife-linux-x86_64.tar.gz"
      sha256 "5de4e17eaebf9411da8ed4e785d8396dfa0ede943c75774cc319f0ec23737386"
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
