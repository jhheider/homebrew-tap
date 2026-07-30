class Wf < Formula
  desc "Search and browse Pathfinder 2e / Starfinder 2e data from Archives of Nethys"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.1.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wf-macos-aarch64.tar.gz"
      sha256 "ee410ea05b9a64fcbceb12ce981e9977b35cae5bedd1b357f2d6635ecc42bc73"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wf-macos-x86_64.tar.gz"
      sha256 "0f57c2c380dbf8c099a6dd7a5828c2f714d8d4d945eaf3120c5e5e4ed721f056"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wf-linux-aarch64.tar.gz"
      sha256 "8f9167ab2a4e167d5aa2c5504572cdb72cdacd2fdb92df7ab8bb47767d707cd2"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.1/wf-linux-x86_64.tar.gz"
      sha256 "ea4ce7e8d8a16d7dd1660c69480b3060644e4234e3d33b2dffc07d1fcdb9a9e1"
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
