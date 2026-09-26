class WayfinderMcp < Formula
  desc "MCP server exposing Archives of Nethys PF2e / SF2e data to LLM tools"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.0/wayfinder-mcp-macos-aarch64.tar.gz"
      sha256 "1076c138e81521608b326439e9c1ebbabc21957d7d9bc8a55b288a3157664850"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.0/wayfinder-mcp-macos-x86_64.tar.gz"
      sha256 "0e0ef738e344d9802da129ec6614500b8cbc3b942452748a3c3e6795333c49db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.0/wayfinder-mcp-linux-aarch64.tar.gz"
      sha256 "dcfb12a53bf0e2b9325942d5b0053a385cd332d1583c4b9a8ffc22883bdb3b1d"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.0/wayfinder-mcp-linux-x86_64.tar.gz"
      sha256 "20e2a2cd0c3612da3d6f8d153b19a3287a77fc70e37db9a1af24ac0a018d2062"
    end
  end

  def install
    bin.install "wayfinder-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wayfinder-mcp --version")
  end
end
