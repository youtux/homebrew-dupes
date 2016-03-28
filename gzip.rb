class Gzip < Formula
  desc "Popular GNU data compression program"
  homepage "https://www.gnu.org/software/gzip"
  url "http://ftpmirror.gnu.org/gzip/gzip-1.7.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gzip/gzip-1.7.tar.gz"
  sha256 "eccbaa178c7801618c887956f1668d45bb57863a9d2678bfc3e36d01fb951904"

  bottle do
    cellar :any
    revision 1
    sha256 "4f4a5361da0eb9b1f8769e9da586cb21f8b261bbd814afa00773d98c864c4797" => :yosemite
    sha256 "f899ced33032b5fd323c0bc592345f7f2f02dedaadc5a0061b10e8780f1797da" => :mavericks
    sha256 "605ab80dff19ad7dad9e95af772ffe45d5968738d5dbcece62be244acb789137" => :mountain_lion
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
