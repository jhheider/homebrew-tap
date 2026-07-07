class GoveeTui < Formula
  desc "Clean, colorful TUI for controlling Govee smart devices"
  homepage "https://github.com/jhheider/govee-tui"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-macos-aarch64.tar.gz"
      sha256 "0ef4343b42ac2008e6ec4dc87f802e044681c68807ddc7ed0057b43b8e038e61"
    end
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-macos-x86_64.tar.gz"
      sha256 "89eb2785c00a3cd37884d3cb2e741d1aea8c7fcde2645c1afb3f29cb7752ac85"
    end
  end

  on_linux do
    # Static musl builds (x86_64 + aarch64).
    on_arm do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-linux-aarch64.tar.gz"
      sha256 "1a5a4e0ec35b07e9770091f2cfa4a01106961e4fd2b468aaae2a847f1acae439"
    end
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-linux-x86_64.tar.gz"
      sha256 "5c5b2013a1fca543fd330f7934ec746b29e2044d237b3f166dec8c4ec767d362"
    end
  end

  def install
    bin.install "govee-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/govee-tui --version")
  end
end
