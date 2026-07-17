class Scriptbox < Formula
  desc "Run a shell script from an immutable copy, so a mid-run edit can't change it"
  homepage "https://github.com/jhheider/scriptbox"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.1.0/scriptbox-macos-aarch64.tar.gz"
      sha256 "1258c0881ced4430b7acacc6dbd70818569abcf732c2c8816ac614b810940d4f"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.1.0/scriptbox-macos-x86_64.tar.gz"
      sha256 "d412f7298485ec9e2e250a777906af95e4cf406ce11e64a71de8cda61db6cebd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.1.0/scriptbox-linux-aarch64.tar.gz"
      sha256 "b054ecdb0f69113130503dfcce99690fd3dc51dfbb90e8195cd92aae9788d989"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.1.0/scriptbox-linux-x86_64.tar.gz"
      sha256 "9f617d83157d2ca253b9de54eb163fd12a39fe19b632ab80e8d994496856ab29"
    end
  end

  # The release tarball is just the binary (plus README/licenses); nothing built.
  def install
    bin.install "scriptbox"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scriptbox --version")

    # Args pass through to the real interpreter.
    (testpath/"t.sh").write "#!/bin/bash\necho \"hello from $1\"\n"
    assert_equal "hello from world\n",
                 shell_output("#{bin}/scriptbox bash #{testpath}/t.sh world")

    # `hash` emits a sha256 pin.
    assert_match(/\Asha256:[0-9a-f]{64}\Z/, shell_output("#{bin}/scriptbox hash #{testpath}/t.sh").strip)
  end
end
