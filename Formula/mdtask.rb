class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.6.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.1/mdtask-macos-aarch64.tar.gz"
      sha256 "c4fbcb1ddbc870550b1c34b69ab1a29ad0b23d2a325c18d1dfa350e3ec38d6f5"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.1/mdtask-macos-x86_64.tar.gz"
      sha256 "a549806c0b8741d7676bd820743e121dff90792afef1e0a56ae4f70e5b7a6b04"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.1/mdtask-linux-aarch64.tar.gz"
      sha256 "6806cb909f3106440bd386d1bd90ed8fa84ed36405ab3ebba83a55f819030dbf"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.1/mdtask-linux-x86_64.tar.gz"
      sha256 "ee2a6362b5875b928b4751fa6c2dffc8c0d1e80402bc050dc3531761a0846038"
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
