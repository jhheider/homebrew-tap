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
      sha256 "efa9a9a62b5c2bc41d4f73ca6fcb291372ff7400b8984d2189caf1cc05da5ccd"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-macos-x86_64.tar.gz"
      sha256 "6bf04a42ccf66b01575dd51b8e79a9dbce9084cfc3b79b0ffaf7c0eb183a6acf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-linux-aarch64.tar.gz"
      sha256 "fd703b790eba8d0f4c4d52ed85c99c4c734959e3f095fdbb43173b76e9b30174"
    end
    on_intel do
      url "https://github.com/jhheider/semverator/releases/download/v0.11.0/semverator-linux-x86_64.tar.gz"
      sha256 "74f1bed598b5410738584f32034241b748d805984e59511bcf47afa3e1a2e966"
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
