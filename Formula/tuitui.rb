class Tuitui < Formula
  desc "Terminal games for two, played over a direct peer-to-peer connection"
  homepage "https://github.com/mr-nitesh-poudel/tui-tui"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.2.0/tui-tui-aarch64-apple-darwin.tar.xz"
      sha256 "f3cd426ab9272aa6b64a8f35604b54c635f2ae1152eefbbd39d5c405223db2d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.2.0/tui-tui-x86_64-apple-darwin.tar.xz"
      sha256 "0e3d8236da07f00afcc8fe6eaa512140578c55ca2fc0bfef96bb3b9393de512b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mr-nitesh-poudel/tui-tui/releases/download/v0.2.0/tui-tui-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "3b3b533d1c31af5d6a0eb8dba87bc12c5b36094c943c69a8362148adbab217c6"
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
