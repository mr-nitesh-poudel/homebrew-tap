class Tuitui < Formula
  desc "Terminal games for two, played over a direct peer-to-peer connection"
  homepage "https://github.com/mr-nitesh-poudel/tui-tui"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.1.2/tui-tui-aarch64-apple-darwin.tar.xz"
      sha256 "301df03ad4d912dd4fdd72b0d663d0e4e7b5d19274f3ac300f5805751ea20db8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.1.2/tui-tui-x86_64-apple-darwin.tar.xz"
      sha256 "a7ba9e7ede6c053713faf8cefe78175340968214fedfa11576aa868cb6315aeb"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.1.2/tui-tui-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "2091b96a71d2e0a91d41f19e02a582fbbd225e41b79b664fbfeab464944101f0"
  end
  license any_of: ["MIT", "Apache-2.0"]

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
