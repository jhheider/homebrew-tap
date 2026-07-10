class Wf < Formula
  desc "Search and browse Pathfinder 2e / Starfinder 2e data from Archives of Nethys"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.1.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-macos-aarch64.tar.gz"
      sha256 "1088104609fcbd73e4949f53645d867755cf017d10631519ef5318ee3b36d88b"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-macos-x86_64.tar.gz"
      sha256 "85276c3b1e179760b26bd210cbbe3351b1aa46915ef7b826dfcc29e402731ad0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-linux-aarch64.tar.gz"
      sha256 "6295fb305fe4af5ba314a91df17be6169b81d114f6b3b75e2133a5d6db2a1056"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-linux-x86_64.tar.gz"
      sha256 "cee810603d4b8344b3d9eac7f1bc18d1a8956a317fc3719eb5437fb4bf5e5c2f"
    end
  end

  # The release tarball bundles the binary plus the generated man page and shell
  # completions (clap_mangen / clap_complete), so nothing is built here.
  def install
    bin.install "wf"
    man1.install "wf.1"
    bash_completion.install "wf.bash" => "wf"
    zsh_completion.install "wf.zsh" => "_wf"
    fish_completion.install "wf.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wf --version")
    # `categories` needs no network for its help/usage surface.
    assert_match "Categories", shell_output("#{bin}/wf categories 2>&1", 0)
  end
end
