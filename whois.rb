class Whois < Formula
  desc "Lookup tool for domain names and other internet resources"
  homepage "https://packages.debian.org/sid/whois"
  url "https://mirrors.kernel.org/debian/pool/main/w/whois/whois_5.2.11.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/whois/whois_5.2.11.tar.xz"
  sha256 "32f7d6be853aa6a6a8ac6dd672bd60ae4f10bc0bedcaa944363ffbef6e57cef7"
  head "https://github.com/rfc1036/whois.git"

  bottle do
    cellar :any
    sha256 "dfc6cf475084c4be2bf97f5580f7042a42a3ab2a6ed40fcf696e6aa0b7f099a7" => :yosemite
    sha256 "73ab04806e94eadb9406c1f90108d03ba298669bc5e82abdbb2f9300ac8da911" => :mavericks
    sha256 "2f276552ccb9ed7091913dae5d0548a06a9a0332e8d18b91a22033fee46f4c39" => :mountain_lion
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
