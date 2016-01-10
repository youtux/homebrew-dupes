class Gpatch < Formula
  desc "Apply a diff file to an original"
  homepage "https://savannah.gnu.org/projects/patch/"
  url "http://ftpmirror.gnu.org/patch/patch-2.7.5.tar.xz"
  mirror "https://ftp.gnu.org/gnu/patch/patch-2.7.5.tar.xz"
  sha256 "fd95153655d6b95567e623843a0e77b81612d502ecf78a489a4aed7867caa299"

  bottle do
    cellar :any
    sha256 "ab9aa437d65dec4efc338d2c668dc79afec6bb6fb2c55ef2ece5de090fa04a74" => :yosemite
    sha256 "b2bbd27b9645a1cb997157dcb79ad35d6166d64e28ab0ef19688855245b9ed6b" => :mavericks
    sha256 "4dbe6b5b946f34a0a4a2aa3b493c248a624c2f40a9ccb5bd7ac49a7a59cb80d6" => :mountain_lion
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    testfile = testpath/"test"
    testfile.write "homebrew\n"
    patch = <<-EOS.undent
      1c1
      < homebrew
      ---
      > hello
    EOS
    pipe_output("#{bin}/patch #{testfile}", patch)
    assert_equal "hello", testfile.read.chomp
  end
end
