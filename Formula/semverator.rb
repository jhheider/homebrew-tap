class Semverator < Formula
  desc "Command-line tool for working with semantic versioning (libpkgx implementation)"
  homepage "https://github.com/jhheider/semverator"
  version "0.10.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.1/semverator-macos-aarch64.tar.gz"
      sha256 "257000ebc7f30c347a2b9f2faea01538edc1ee5bd14aa23d183f6b3b9408891e"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.1/semverator-macos-x86_64.tar.gz"
      sha256 "ead760503c127b35a2c54a6c06fa1691c57829a02631170cb5db32d9b67dc958"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.1/semverator-linux-aarch64.tar.gz"
      sha256 "f5bfab63cebe734d054ee6ca1ff9fa9ddb2a4d6f52e8e82f3f5eb29264906321"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.10.1/semverator-linux-x86_64.tar.gz"
      sha256 "3997beeb8c26078d82d3f8488efb0306404436df6a4b86b74768c3ccb8a90d74"
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
