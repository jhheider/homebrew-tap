class Scriptbox < Formula
  desc "Run a shell script from an immutable copy, so a mid-run edit can't change it"
  homepage "https://github.com/jhheider/scriptbox"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.1/scriptbox-macos-aarch64.tar.gz"
      sha256 "5ae61d2a95239197e40dd09507d79d8734b59970d72e39b50ae38b758269d187"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.1/scriptbox-macos-x86_64.tar.gz"
      sha256 "0d6708b187310b9834376c065fc703270c9e4eaa0f0b117c43482b2d9b3cf679"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.1/scriptbox-linux-aarch64.tar.gz"
      sha256 "6e03066989863048f5a4a60ce4f31167c160d69809dbb9b7f5961801bc314798"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.1/scriptbox-linux-x86_64.tar.gz"
      sha256 "8e7edf395af455d99b2b812b9612d085db7a100f95bba4f282ac5ebe6533f137"
    end
  end

  # The release tarball is just the binary (plus README/licenses); nothing built.
  def install
    bin.install "scriptbox"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scriptbox --version")

    # Args pass through to the real interpreter.
    (testpath/"t.sh").write "#!/bin/bash
echo \"hello from $1\"
"
    assert_equal "hello from world
",
                 shell_output("#{bin}/scriptbox bash #{testpath}/t.sh world")

    # `hash` emits a sha256 pin.
    assert_match(/\Asha256:[0-9a-f]{64}\Z/, shell_output("#{bin}/scriptbox hash #{testpath}/t.sh").strip)
  end
end
