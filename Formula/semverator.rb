class Semverator < Formula
  desc "Command-line tool for working with semantic versioning (libpkgx implementation)"
  homepage "https://github.com/jhheider/semverator"
  version "0.11.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-macos-aarch64.tar.gz"
      sha256 "c4c299b9976f0c453b53656c9cb01803a6d713e81766216cd025c13e51c0c9aa"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-macos-x86_64.tar.gz"
      sha256 "eb5c06d70ab10606617c2d91b8ac6bff8c78e79c96bee3fb3ffb95d5330b4c2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-linux-aarch64.tar.gz"
      sha256 "f098f1954ad34bd3529e6605074e4377d0e1f84e24d1000eb14d6c33da8e2c0c"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-linux-x86_64.tar.gz"
      sha256 "d65a326723e50757955b870d2033d72bdef12a0998e821fcb06c88e46e73cda8"
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
