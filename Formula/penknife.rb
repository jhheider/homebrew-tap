class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.0/penknife-macos-aarch64.tar.gz"
      sha256 "7365c46745fa3dcf0d28d0ceaf41b901a1faffce675da96e244ca0d454baa7d3"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.0/penknife-macos-x86_64.tar.gz"
      sha256 "274e4515ea4023b356956958ea711fd991689e26128479ba000efd37b3f24a72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.0/penknife-linux-aarch64.tar.gz"
      sha256 "619bf171a98fedcd14541bd906dccdc4e732c0f6eb7ada1b4e489d95a5ee63ed"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.2.0/penknife-linux-x86_64.tar.gz"
      sha256 "0e4d79343e73b2d4b6cb953cc8f13f1179a6149d2340e4770ac679854e87a714"
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
