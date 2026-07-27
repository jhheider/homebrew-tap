class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.5.0/mdtask-macos-aarch64.tar.gz"
      sha256 "49ed31518e653ef231b3fab734a2b27baddb512d16331e7c96a587b6abd26fd6"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.5.0/mdtask-macos-x86_64.tar.gz"
      sha256 "2e0f3dcecd9f6bfd92e25e36a64df6e5d083b200c0998867e03b1b94a693aefd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.5.0/mdtask-linux-aarch64.tar.gz"
      sha256 "af9a75554606846bd38ee99b69f0007a1481c12554ab3f310e438f8f6ac05c32"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.5.0/mdtask-linux-x86_64.tar.gz"
      sha256 "5b802990c445f05212ec272b81cc058e9639592bf4df739d84e83befdb6954a5"
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
