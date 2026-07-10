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
      sha256 "c060909836eff67f3ef953d1d8e70ddfbae43a2c257d60e558f8e926454829bb"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-macos-x86_64.tar.gz"
      sha256 "be70f1926a0f0a1e8ce29815388331faa506070bf3851791d83df1babb31487f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-linux-aarch64.tar.gz"
      sha256 "b6b18e5f00d44b42780ac81392871bfa4c64ff33a9577d8ed0507a8e581bb3d2"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-linux-x86_64.tar.gz"
      sha256 "75770af3882150d0ad75836b2a086d909bb014540592b1d4efe15fbd3a01ce23"
    end
  end

  def install
    bin.install "wayfinder-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wayfinder-mcp --version")
  end
end
