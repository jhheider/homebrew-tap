class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.2.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.2/penknife-macos-aarch64.tar.gz"
      sha256 "d87efadd9a937039e6a5e6e1b6ed743d9e3ad8bd29c5867cc02883e11b74ec84"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.2/penknife-macos-x86_64.tar.gz"
      sha256 "fd6cfaad7ded3d23bbc3e36a3af27b103bf5846d36b3594a66aee1ea9fd9a19d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.2/penknife-linux-aarch64.tar.gz"
      sha256 "eb6882a41c304c970fd8f37366b7f4f119a3dce71b456265e521e2a7486d9b4b"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.2/penknife-linux-x86_64.tar.gz"
      sha256 "b8c3d73b7c8da8d1f6d8d99f5d8016c5bef01b981645addb449c0470f9a4d09d"
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
