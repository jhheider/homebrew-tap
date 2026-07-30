class WayfinderMcp < Formula
  desc "MCP server exposing Archives of Nethys PF2e / SF2e data to LLM tools"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.1.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wayfinder-mcp-macos-aarch64.tar.gz"
      sha256 "b02c06926a419d006a125c9c00c3e14f701f3c13c917d966f8b7cb8abbc83d45"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wayfinder-mcp-macos-x86_64.tar.gz"
      sha256 "3450dcf0fec94ca3df214af17828bd96dba1b6b3061f8970e5897923944441d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wayfinder-mcp-linux-aarch64.tar.gz"
      sha256 "47071a179ad4335fb1a2369dbf1f6e3e417aa15503071f93389e00ca7f328cda"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wayfinder-mcp-linux-x86_64.tar.gz"
      sha256 "045e855a43c5318dabbff0effec78fc92ddcf40f8c1f15da9dcdb1c2312f78c9"
    end
  end

  def install
    bin.install "wayfinder-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wayfinder-mcp --version")
  end
end
