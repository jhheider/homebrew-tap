class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.4.0/mdtask-macos-aarch64.tar.gz"
      sha256 "f5f6d0e0d6000ae9c9be684e40bfe14cbe9c4bbd5661192c2894ed337e974976"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.4.0/mdtask-macos-x86_64.tar.gz"
      sha256 "c5827b660d8665d8d64cd5a9be162bc9694194b80add33ed735a0174c42c21e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.4.0/mdtask-linux-aarch64.tar.gz"
      sha256 "4c1696bc68fa68e30d7c3e862f94f97b57290bc41ea06f62e8c8f9e67a15f870"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.4.0/mdtask-linux-x86_64.tar.gz"
      sha256 "04efe7c11ca2113f81b6896e5d833855caf6fb01889abaf21e20b1ffe3ca9dd1"
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
