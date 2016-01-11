class Make < Formula
  desc "Utility for directing compilation"
  homepage "https://www.gnu.org/software/make/"
  url "http://ftpmirror.gnu.org/make/make-4.1.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/make/make-4.1.tar.bz2"
  sha256 "0bc7613389650ee6a24554b52572a272f7356164fd2c4132b0bcf13123e4fca5"

  bottle do
    revision 1
    sha256 "9efa34626066c502083ecb7ddbf033a2a2e118ad807c1ba020bc108169c6e5cb" => :yosemite
    sha256 "0acd403c6ecfc5a3f4fe74f1a76898bb15101871891ee8112e2edcf35c3a4ae0" => :mavericks
    sha256 "f63c015de69286e67e5884fce7a529fc4e9299167dd769414a25651507a7c7cc" => :mountain_lion
  end

  option "with-default-names", "Do not prepend 'g' to the binary"

  depends_on "guile" => :optional

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << "--with-guile" if build.with? "guile"
    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"Makefile").write <<-EOS.undent
      default:
      \t@echo Homebrew
    EOS

    cmd = build.with?("default-names") ? "make" : "gmake"

    assert_equal "Homebrew\n",
      shell_output("#{bin}/#{cmd}")
  end
end
