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
      sha256 "391e4dbbe7a0cb56813138012b3835805593a5ba97c20c96e22d47918d957960"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-macos-x86_64.tar.gz"
      sha256 "aa67c1867f74e208562fd1ecb8d8ab9c377fb7cbc9747c4c13974bfe57e5f6c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-linux-aarch64.tar.gz"
      sha256 "e27f643efa6a23ff4a06b6e746659b7772c96c7513020a85422c3d6d68f6bb74"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wayfinder-mcp-linux-x86_64.tar.gz"
      sha256 "0040536d5c3568591f401cc10b6451e845bef845f60288757412a0dafdf400be"
    end
  end

  def install
    bin.install "wayfinder-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wayfinder-mcp --version")
  end
end
