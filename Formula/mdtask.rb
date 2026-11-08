class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.7.0/mdtask-macos-aarch64.tar.gz"
      sha256 "144605ac492e8b0194c13d240e7ff93d9eca8b706c9e88582d29fa78be10626d"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.7.0/mdtask-macos-x86_64.tar.gz"
      sha256 "8f99c9ccbf986a09a5a5a8c3f4ce191108361880baf2c78fa425764ad3529301"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.7.0/mdtask-linux-aarch64.tar.gz"
      sha256 "8780b991592cc77a9550c3b52772550feaf32bddfe6e033f3a736fc685957848"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.7.0/mdtask-linux-x86_64.tar.gz"
      sha256 "ac7bcda85b19a96a5d8c07bc571510796ab0ca753d02606680c0f875af6de1a4"
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
