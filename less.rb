class Less < Formula
  homepage "http://www.greenwoodsoftware.com/less/index.html"
  url "http://www.greenwoodsoftware.com/less/less-458.tar.gz"
  sha256 "e536c7819ede54b3d487f0ffc4c14b3620bed83734d92a81e89f62346db0fcac"

  devel do
    url "http://www.greenwoodsoftware.com/less/less-481.tar.gz"
    sha256 "3fa38f2cf5e9e040bb44fffaa6c76a84506e379e47f5a04686ab78102090dda5"
  end

  depends_on "pcre" => :optional

  def install
    args = ["--prefix=#{prefix}"]
    args << "--with-regex=pcre" if build.with? "pcre"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/lesskey", "-V"
  end
end
