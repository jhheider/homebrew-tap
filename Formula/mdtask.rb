class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.3.0/mdtask-macos-aarch64.tar.gz"
      sha256 "b2c5c75e6f7256280433bef941300201a41889ce298d82caedfd97957475fecb"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.3.0/mdtask-macos-x86_64.tar.gz"
      sha256 "669e6e21103fc08410f0bf3c60a9bbd99e9ebe2c1a5320e37ac29268d0b5e6cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.3.0/mdtask-linux-aarch64.tar.gz"
      sha256 "7d96221e565d96169d60078e4b568f941d61a49e668d3c897930764aaf6448a9"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.3.0/mdtask-linux-x86_64.tar.gz"
      sha256 "12c804c08bca202f6ef90759687969c0dcdbe6153c1e137f243ccbbee411d1c0"
    end
  end

  def install
    bin.install "mdtask"
  end

  test do
    # A heading is a task and the first fenced block is its script: `greet`
    # should run and substitute its positional argument. `-f` pins the file so the
    # test does not walk up out of the sandbox.
    (testpath/"tasks.md").write <<~MARKDOWN
      ## greet

      Args: name

      ```sh
      echo "hi $name"
      ```
    MARKDOWN
    assert_equal "hi there\n", shell_output("#{bin}/mdtask -f tasks.md greet there")
  end
end
