class Gzip < Formula
  desc "Popular GNU data compression program"
  homepage "https://www.gnu.org/software/gzip"
  url "http://ftpmirror.gnu.org/gzip/gzip-1.8.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gzip/gzip-1.8.tar.gz"
  sha256 "1ff7aedb3d66a0d73f442f6261e4b3860df6fd6c94025c2cb31a202c9c60fe0e"

  bottle do
    cellar :any_skip_relocation
    sha256 "625966e71e8e1f4e7fbf18a04245d8eaa9f19cda4b6ba0a1da225bf2d45fe4f2" => :el_capitan
    sha256 "0c3831ee6a76be8a6bcefbe70ec7110206e7f7d5b6424ff66d955d42c399bb85" => :yosemite
    sha256 "e478304886a15ebf094e58b2c566f87a57729fab686b302018f4493c29185f0e" => :mavericks
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"foo").write "test"
    system "#{bin}/gzip", "foo"
    system "#{bin}/gzip", "-t", "foo.gz"
    assert_equal "test", shell_output("#{bin}/gunzip -c foo")
  end
end
