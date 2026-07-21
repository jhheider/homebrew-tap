class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.1/mdtask-macos-aarch64.tar.gz"
      sha256 "bf55a7afaf226968fd4114097b69fe6cd65264a491cbd2757fb092645dac5b5a"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.1/mdtask-macos-x86_64.tar.gz"
      sha256 "7fc24791174aa1b07a095ac1dfd4a2d7da7401e721fc5c031d7c6c8acb5c74ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.1/mdtask-linux-aarch64.tar.gz"
      sha256 "cf5b56a16f7ce2e1fae4f6f341b62d2b4e35927bad330b1d2a20768d8b00bd3d"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.1/mdtask-linux-x86_64.tar.gz"
      sha256 "d9b6ef9b15a825872cf54bd302b15dcc02b52085070a01db7a7b7d8bb44b9a84"
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
