class Diffutils < Formula
  desc "File comparison utilities"
  homepage "https://www.gnu.org/s/diffutils/"
  url "http://ftpmirror.gnu.org/diffutils/diffutils-3.3.tar.xz"
  mirror "https://ftp.gnu.org/gnu/diffutils/diffutils-3.3.tar.xz"
  sha256 "a25e89a8ab65fded1731e4186be1bb25cda967834b6df973599cdcd5abdfc19c"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"a").write "foo"
    (testpath/"b").write "foo"
    system "#{bin}/diff", "a", "b"
  end
end
