class GoveeTui < Formula
  desc "Clean, colorful TUI for controlling Govee smart devices"
  homepage "https://github.com/jhheider/govee-tui"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-macos-aarch64.tar.gz"
      sha256 "9d9914b5705aa74a41d5ea7fe3df9e00fb18637fa3d12c2ac52c8c8da53361b4"
    end
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-macos-x86_64.tar.gz"
      sha256 "b0174acea10822d772f2cb098395259718c54f78e5d8c10adcba6ffe2e09a03f"
    end
  end

  on_linux do
    # govee-tui ships a static musl x86_64 build; no linux-aarch64 binary yet.
    on_intel do
      url "https://github.com/jhheider/govee-tui/releases/download/v0.1.0/govee-tui-linux-x86_64.tar.gz"
      sha256 "c7f3b54290b584adcf4ad903855fe7a2057463a4f616fb82a633aff05b44a532"
    end
  end

  def install
    bin.install "govee-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/govee-tui --version")
  end
end
