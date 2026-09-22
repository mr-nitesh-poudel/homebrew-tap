class Tuitui < Formula
  desc "Terminal games for two, played over a direct peer-to-peer connection"
  homepage "https://github.com/mr-nitesh-poudel/tui-tui"
  url "https://github.com/mr-nitesh-poudel/tui-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ade0ab4240c529bba357a6b90e4a1a3be23f434562963410bf485a341878e4ea"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/mr-nitesh-poudel/tui-tui.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "tuitui #{version}", shell_output("#{bin}/tuitui --version")
    # Nothing to play against in a test, but the argument parsing is real.
    assert_match "no game called", shell_output("#{bin}/tuitui local draughts 2>&1", 2)
  end
end
