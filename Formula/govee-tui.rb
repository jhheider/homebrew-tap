class GoveeTui < Formula
  desc "Clean, colorful TUI for controlling Govee smart devices"
  homepage "https://github.com/jhheider/govee-tui"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.1/govee-tui-macos-aarch64.tar.gz"
      sha256 "a243a1a624f6ee8b076aca78fa02029aa14901c3368ad8d2c2495fa0becec5a1"
    end
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.1/govee-tui-macos-x86_64.tar.gz"
      sha256 "375ab5de7e1a12d520cdc6582953e6fd4879868efc35bfe9bb073aa165a845c7"
    end
  end

  on_linux do
    # Static musl builds (x86_64 + aarch64).
    on_arm do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.1/govee-tui-linux-aarch64.tar.gz"
      sha256 "ebfb45f960f0073a665930040d53f0b2cedf76c36d1debfa0e73d68cb43385ce"
    end
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.1/govee-tui-linux-x86_64.tar.gz"
      sha256 "269640afbb2c728f8e5d33f9160de7d1f20a27aad90d60e15cb467c573d57758"
    end
  end

  def install
    bin.install "govee-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/govee-tui --version")
  end
end
