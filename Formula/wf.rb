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
      sha256 "e7f236f2898f02dc30bd7ded478ed9b124c4bd6770afe0da0b5d240f0eb1a4b4"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-macos-x86_64.tar.gz"
      sha256 "739cc8afb3b5339d82e72b70ca652d5d6b252cf420a92519536b8a19f55ce6d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-linux-aarch64.tar.gz"
      sha256 "902271561e3ce3bfca41294e8f82dd6e2817eb3d49a48a5276bfe1dc1c7405a3"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.1.0/wf-linux-x86_64.tar.gz"
      sha256 "c935fd8839df9e7d336391b45008f0a5d5927a2b393eba01b38769f2656e2880"
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
