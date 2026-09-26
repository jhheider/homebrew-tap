class WayfinderMcp < Formula
  desc "MCP server exposing Archives of Nethys PF2e / SF2e data to LLM tools"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.2.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wayfinder-mcp-macos-aarch64.tar.gz"
      sha256 "71a82301894ab470a5b2528e2d79bdc1e9a79bff86ffd9a8498748c753e8aa66"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wayfinder-mcp-macos-x86_64.tar.gz"
      sha256 "1f218cdfbe639bb74d71df83c7718f8e50a4fc0063a4e3a354e66356741d5b29"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wayfinder-mcp-linux-aarch64.tar.gz"
      sha256 "f1eec9a7ce3d0f3a7c5f61c257f9f3470879299a143c717e071565098ca04ca6"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wayfinder-mcp-linux-x86_64.tar.gz"
      sha256 "98ae9efcb366870cbb64a3385ac790fef5950c4a9910953717353fe3630412b4"
    end
  end

  def install
    bin.install "wayfinder-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wayfinder-mcp --version")
  end
end
