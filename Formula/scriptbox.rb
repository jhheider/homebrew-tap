class Scriptbox < Formula
  desc "Run a shell script from an immutable copy, so a mid-run edit can't change it"
  homepage "https://github.com/jhheider/scriptbox"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.0/scriptbox-macos-aarch64.tar.gz"
      sha256 "0cc77a2f46740ebdda05c81f156ce776a07962b85479dff71b487966eaa76cd3"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.0/scriptbox-macos-x86_64.tar.gz"
      sha256 "da8013cf3cfe6ed1c24a5b13acc56b91c4f98b819d08236bf06fa3a7c563b946"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.0/scriptbox-linux-aarch64.tar.gz"
      sha256 "ffc9061366ea98e4a5f5a2b6803243bb6b7f5e68afbab87bd33c9af8cd4d98cf"
    end
    on_intel do
      url "https://github.com/jhheider/scriptbox/releases/download/v0.3.0/scriptbox-linux-x86_64.tar.gz"
      sha256 "d14ba2fbd617e6b11af39c83e03470a35b7cf11ca8db48a74dc62b4b283927c4"
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
