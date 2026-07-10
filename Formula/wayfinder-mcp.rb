class WayfinderMcp < Formula
  desc "MCP server exposing Archives of Nethys PF2e / SF2e data to LLM tools"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.1.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-macos-aarch64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-macos-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-linux-aarch64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-linux-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "wayfinder-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wayfinder-mcp --version")
  end
end
