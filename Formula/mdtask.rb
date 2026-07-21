class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.0/mdtask-macos-aarch64.tar.gz"
      sha256 "e01c44cbd211febe23e48834f7977c25d2e76d5bbd44da1b978a25b284eca88e"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.0/mdtask-macos-x86_64.tar.gz"
      sha256 "40ab21bf97b1d40f2f9295f92933f579647b212e73f9ba74aa498ee5b49af938"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.0/mdtask-linux-aarch64.tar.gz"
      sha256 "6b7f3601a27fe12d1c7fe694c0d48976ca531732530100dc40a4b18ca6fac5f4"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.1.0/mdtask-linux-x86_64.tar.gz"
      sha256 "ad86beb5e0a2f945876f51436c9fb15a52d596c638a32bf4de1342a7287c8d39"
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
