class Scriptbox < Formula
  desc "Run a shell script from an immutable copy, so a mid-run edit can't change it"
  homepage "https://github.com/jhheider/scriptbox"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.2.0/scriptbox-macos-aarch64.tar.gz"
      sha256 "240528908a20aab338c159c8620b135a7edd0742c67c80958643ce239fc7c57a"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.2.0/scriptbox-macos-x86_64.tar.gz"
      sha256 "94527c84e38342a6808c00826deab658dd57b43e79b7bab7012628766b0b48c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.2.0/scriptbox-linux-aarch64.tar.gz"
      sha256 "c2695a1758740f253f36dd1b5a02ade1b57ad055166fe9607253acd54ba503b2"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.2.0/scriptbox-linux-x86_64.tar.gz"
      sha256 "ed078b00549289fd3c63d657b817b6be286ee117eac0a254c374b7545bd524d1"
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
