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
      sha256 "5636d4ea615172b2950312d97851bb502ceda9e83ddb14e0a68cb754a3c886d3"
    end
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-macos-x86_64.tar.gz"
      sha256 "19162f407990b1a22cb5f550f41280ebdc91af117a41c0e5b9ff9aae950ed771"
    end
  end

  on_linux do
    # govee-tui ships a static musl x86_64 build; no linux-aarch64 binary yet.
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-linux-x86_64.tar.gz"
      sha256 "7a39e4f639e57f40b764a60e6c992beddaf50323de56440cbc0111df71e23004"
    end
  end

  def install
    bin.install "govee-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/govee-tui --version")
  end
end
