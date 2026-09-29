class Tuitui < Formula
  desc "Terminal games for two, played over a direct peer-to-peer connection"
  homepage "https://github.com/mr-nitesh-poudel/tui-tui"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.4.0/tui-tui-aarch64-apple-darwin.tar.xz"
      sha256 "dad1f72890de6925a10489bcb80215f045ef8038a710784650179f4fdf0e616b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.4.0/tui-tui-x86_64-apple-darwin.tar.xz"
      sha256 "14d7b48ee1029a8de4eff24f1cb76dfd5b99c360acfb537820916efaa2f3444b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.4.0/tui-tui-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "df72d2e434bee52141ba7c5ac32968e47c28c6b28be07919aaf17f706306870b"
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "stockfish"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tuitui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tuitui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tuitui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
