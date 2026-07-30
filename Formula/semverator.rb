class Semverator < Formula
  desc "Command-line tool for working with semantic versioning (libpkgx implementation)"
  homepage "https://github.com/jhheider/semverator"
  version "0.10.2"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.2/semverator-macos-aarch64.tar.gz"
      sha256 "e05d20af71891494672d4a5f06602e8e14e50464e38a326323c79fd7ab467b3f"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.2/semverator-macos-x86_64.tar.gz"
      sha256 "104103220bc79e6b6470bb522bb158e9251f6b3756d2b8c9c371e1ba2ea9d2cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.2/semverator-linux-aarch64.tar.gz"
      sha256 "b966e68591bd27fec1b7156e62c5c17faba742579eddc2e6ded58879d6bc91bb"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.2/semverator-linux-x86_64.tar.gz"
      sha256 "4f0347bc03c02c572cc74deee4a14a644141445b0071f6d2965807519c49094e"
    end
  end

  def install
    bin.install "semverator"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/semverator --version")

    # Valid inputs and true comparisons succeed.
    assert_equal "1.2.3 is valid", shell_output("#{bin}/semverator validate 1.2.3").strip
    assert_match "versions are equal", shell_output("#{bin}/semverator eq 1.2.3 1.2.3")
    assert_match "versions are not equal", shell_output("#{bin}/semverator neq 1.2.3 1.2.4")
    assert_match "1.2.3 is greater than 1.2.2", shell_output("#{bin}/semverator gt 1.2.3 1.2.2")
    assert_match "1.2.3 is less than 1.2.4", shell_output("#{bin}/semverator lt 1.2.3 1.2.4")

    # An unparseable version is rejected at the CLI boundary (exit 2); false
    # comparisons of valid versions exit 1.
    shell_output("#{bin}/semverator validate 1.2.three", 2)
    shell_output("#{bin}/semverator eq 1.2.3 1.2.4", 1)
    shell_output("#{bin}/semverator gt 1.2.3 1.2.4", 1)
    shell_output("#{bin}/semverator lt 1.2.3 1.2.2", 1)
  end
end
