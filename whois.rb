class Whois < Formula
  desc "Lookup tool for domain names and other internet resources"
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.12.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/whois/whois_5.2.12.tar.xz"
  sha256 "b26d4027b8987d9911466aa06ce2c167a50017cd59a622a429bd506222f6cdf1"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "eafa98fa8f1b09b5339ea684cd0231abbca301aa2bd5397cc4ca67bd3752f3a6" => :el_capitan
    sha256 "8b0dd75a7b4b8bdc1416ea925d41f551b1dff915de2cfe3543258f2c642bfbb6" => :yosemite
    sha256 "bc20602cba3eba5eb471996236375ca07462ebd47f88387a98d2f8196dfb8a08" => :mavericks
  end

  def install
    # autodie was not shipped with the system perl 5.8
    inreplace "make_version_h.pl", "use autodie;", "" if MacOS.version < :snow_leopard

    system "make", "HAVE_ICONV=1", "whois_LDADD+=-liconv", "whois"
    bin.install "whois"
    man1.install "whois.1"
  end

  def caveats; <<-EOS.undent
    Debian whois has been installed as `whois` and may shadow the
    system binary of the same name.
    EOS
  end

  test do
    system "#{bin}/whois", "brew.sh"
  end
end
