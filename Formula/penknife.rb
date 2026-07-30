class Penknife < Formula
  desc "Terminal app for markdown writing: browse, share as rich text, sync to gists"
  homepage "https://github.com/jhheider/penknife"
  version "0.3.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The sha256 values are placeholders; the release workflow's bump job
  # recomputes them from the real assets when a version is published.
  on_macos do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.1/penknife-macos-aarch64.tar.gz"
      sha256 "50db24621cba3c0e616d4c62eb9af674658a3d28fd6f63cd1d41928d17faa688"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.1/penknife-macos-x86_64.tar.gz"
      sha256 "9c65b8bca22a930349803356a1af0df6d5338bb944993c03c3fbb01ac4daba04"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.1/penknife-linux-aarch64.tar.gz"
      sha256 "858c1e1bdfc218d5234f24807f86733f19211ba65d59156758c012c7ea5237e3"
    end
    on_intel do
      url "https://github.com/jhheider/penknife/releases/download/v0.3.1/penknife-linux-x86_64.tar.gz"
      sha256 "2973f379af0643b03657eab20e051fe93ef5a67a7042ea68bd05c88242462242"
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
