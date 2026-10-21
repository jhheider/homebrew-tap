class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.3.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.2/penknife-macos-aarch64.tar.gz"
      sha256 "a6dd41daa36fdb95d6c628c301336714ab544eb17c2525699fd2d915f56c6109"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.2/penknife-macos-x86_64.tar.gz"
      sha256 "fcb8ec3d8b3eecbc5e06867eb324bfe88e509e136ee0f1cbf1a450e0c735f929"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.2/penknife-linux-aarch64.tar.gz"
      sha256 "a3723ea0d2e9030652daf7a026dc28e77fc1767ab051ef9e13f1635b8d6f97a4"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.2/penknife-linux-x86_64.tar.gz"
      sha256 "089a0b7a751fe936775fc8548bac1332818c0c8cf1198b9344afacf8f47e8f49"
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
