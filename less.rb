class Less < Formula
  homepage "http://www.greenwoodsoftware.com/less/index.html"
  url "http://www.greenwoodsoftware.com/less/less-481.tar.gz"
  sha256 "3fa38f2cf5e9e040bb44fffaa6c76a84506e379e47f5a04686ab78102090dda5"

  bottle do
    sha256 "ef45c17dc8cb071902148375850bcb2eb975d1650e15bee6ddc102c8f7156cb4" => :el_capitan
    sha256 "308123f213b20c6208145fc5a621dd408d8f20f43d2712ee44c14d15e23bd20d" => :yosemite
    sha256 "8bd63c5387b88e76bcf0bb091566ea7226963cfc88332cd330c1af2c0742934e" => :mavericks
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
