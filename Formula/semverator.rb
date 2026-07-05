class Semverator < Formula
  desc "Command-line tool for working with semantic versioning (libpkgx implementation)"
  homepage "https://github.com/jhheider/semverator"
  url "https://github.com/jhheider/semverator/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "1e78ebc3b6377e5e3578df840e539ed97f0ee6f9c9ceeb2addeea0f17b0b8167"
  license "Apache-2.0"
  head "https://github.com/jhheider/semverator.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "cli")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/semverator --version")

    # Valid inputs and true comparisons succeed.
    assert_equal "1.2.3 is valid", shell_output("#{bin}/semverator validate 1.2.3").strip
    assert_match "versions are equal", shell_output("#{bin}/semverator eq 1.2.3 1.2.3")
    assert_match "versions are not equal", shell_output("#{bin}/semverator neq 1.2.3 1.2.4")
    assert_match "1.2.3 is greater than 1.2.2", shell_output("#{bin}/semverator gt 1.2.3 1.2.2")
    assert_match "1.2.3 is less than 1.2.4", shell_output("#{bin}/semverator lt 1.2.3 1.2.4")

    # Invalid input and false comparisons exit non-zero.
    shell_output("#{bin}/semverator validate 1.2.three", 1)
    shell_output("#{bin}/semverator eq 1.2.3 1.2.4", 1)
    shell_output("#{bin}/semverator gt 1.2.3 1.2.4", 1)
    shell_output("#{bin}/semverator lt 1.2.3 1.2.2", 1)
  end
end
