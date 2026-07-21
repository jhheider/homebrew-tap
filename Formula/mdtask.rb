class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.2.0/mdtask-macos-aarch64.tar.gz"
      sha256 "591bd1ff3a0788c9b2376f14c3e6d0689f2c8eb570b0ff63abd7aaf31b8b3083"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.2.0/mdtask-macos-x86_64.tar.gz"
      sha256 "9f6933de8b5019ac5555d83d77eeb5a5fbac29e996b560b37ca6cd3a73530d80"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.2.0/mdtask-linux-aarch64.tar.gz"
      sha256 "e07c032bcafd44879f53758e97b81c6db393eccbddca9ff6c4fb7da324b31d46"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.2.0/mdtask-linux-x86_64.tar.gz"
      sha256 "00d08c922dfebc06d4eb1068fe8bd5523b6dc1b144ee46f0ad12cb83e2ba839a"
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
