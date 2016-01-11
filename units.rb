class Units < Formula
  desc "Utility to convert between different systems of units"
  homepage "https://www.gnu.org/software/units/"
  url "http://ftpmirror.gnu.org/units/units-2.01.tar.gz"
  mirror "https://ftp.gnu.org/gnu/units/units-2.01.tar.gz"
  sha256 "138b12c70bffa0e484fdfe579927412b1ac573e8351c17d8938592f9ba9a88f2"

  keg_only :provided_by_osx,
    "OS X provides BSD units, which behaves differently from GNU units."

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "check"

    ENV.deparallelize # units install otherwise races to make some directories
    system "make", "install"
  end

  test do
    assert_match "6\n",
      shell_output("#{bin}/units '(((square(kiloinch)+2.84m2) /0.5) meters^2)^(1|4)' m").strip
  end
end
