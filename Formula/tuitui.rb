class Tuitui < Formula
  desc "Terminal games for two, played over a direct peer-to-peer connection"
  homepage "https://github.com/mr-nitesh-poudel/tui-tui"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.3.0/tui-tui-aarch64-apple-darwin.tar.xz"
      sha256 "2f34a84688472ce784f02cca6801e53f6b82f4703f1c3ad0ad7fb0df648b7121"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.3.0/tui-tui-x86_64-apple-darwin.tar.xz"
      sha256 "2aac9f5468fbd048112ac6bb376bcf8829558775c666db173a688fecfd0a2a8c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.3.0/tui-tui-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d768d54bffb1a933a475ac83202a732acc397dc526a96403b20a279dedfa40ca"
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
