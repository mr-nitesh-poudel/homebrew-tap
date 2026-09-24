class Tuitui < Formula
  desc "Terminal games for two, played over a direct peer-to-peer connection"
  homepage "https://github.com/mr-nitesh-poudel/tui-tui"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.2.1/tui-tui-aarch64-apple-darwin.tar.xz"
      sha256 "1f63f947bc2c6aeebd1402564820396c3a7e5ea27c372d3742b5684d11f0cb06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.2.1/tui-tui-x86_64-apple-darwin.tar.xz"
      sha256 "a99dfcbe1c90ea7064945c300a0da9854a2d56de6e138f8beb710fe8574fe669"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.2.1/tui-tui-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "954997a26e6ed030e9b55f3a05a516f05462059b847d4149e08aa77dbd887d57"
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
