class Mdtask < Formula
  desc "Embeddable, execution-capable markdown task runner (heading = task, fence = script)"
  homepage "https://github.com/jhheider/mdtask"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.0/mdtask-macos-aarch64.tar.gz"
      sha256 "c3e330356ca1714382633cb615fbc7c15c84b7789c0164c95abcdd41da4e6a40"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.0/mdtask-macos-x86_64.tar.gz"
      sha256 "fefdf5c3d083d6a62299209631a60183abb4fb41aa2ba8bc9f4c8ce3085a1a80"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.0/mdtask-linux-aarch64.tar.gz"
      sha256 "0649d784f9366e09faba8e771ae0397e68e348832e2d3080e315e06f31d2e562"
    end
    on_intel do
      url "https://github.com/jhheider/mdtask/releases/download/v0.6.0/mdtask-linux-x86_64.tar.gz"
      sha256 "349b48175bc00481acfeb0b553a8632f7fcb7b0769c2c581e5cd70f1ab76e010"
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
