class Wf < Formula
  desc "Search and browse Pathfinder 2e / Starfinder 2e data from Archives of Nethys"
  homepage "https://github.com/jhheider/wayfinder"
  version "0.2.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wf-macos-aarch64.tar.gz"
      sha256 "12412175179c659a9f5dcd3bb2f8540279185732bf0760036d2df4de35a9c667"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wf-macos-x86_64.tar.gz"
      sha256 "4d353bd648bf576b72bf340e083f41468d6b5a55e1626262fbc98c01b2b3a754"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wf-linux-aarch64.tar.gz"
      sha256 "c5934df0ba429a404768758c887a953d8d10dff7639c67a5d6768d82fd352752"
    end
    on_intel do
      url "https://github.com/jhheider/wayfinder/releases/download/v0.2.1/wf-linux-x86_64.tar.gz"
      sha256 "2955f06c0807a1fa9685819420e79b19f3bd25f6e889e36be6c54379e8cd7038"
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
