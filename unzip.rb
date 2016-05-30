class Unzip < Formula
  desc "Extraction utility for .zip compressed archives"
  homepage "http://www.info-zip.org/pub/infozip/UnZip.html"
  url "https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz"
  version "6.0"
  sha256 "036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "4ca114663551b5a11c372a9135d29e742bf8175de13b7b92fc0c7754237247d1" => :el_capitan
    sha256 "2804c9bfc8c61959fe98e5b17c381ce8dfc7edfc650e46cb1af2dce824469ad2" => :yosemite
    sha256 "fcd4872c9137a27d2d1c7029ee8f6679fd5f204dfb2452c3a9ff38f320311d51" => :mavericks
  end

  keg_only :provided_by_osx

  # Upstream is unmaintained so we use the Ubuntu unzip-6.0-20ubuntu1 patchset:
  # http://changelogs.ubuntu.com/changelogs/pool/main/u/unzip/unzip_6.0-20ubuntu1/changelog
  patch do
    url "https://launchpad.net/ubuntu/+archive/primary/+files/unzip_6.0-20ubuntu1.debian.tar.xz"
    mirror "http://archive.ubuntu.com/ubuntu/pool/main/u/unzip/unzip_6.0-20ubuntu1.debian.tar.xz"
    sha256 "0ddf122ef15b739e3ea06db4b9e80f40759dce23a2c886678881453a43bd0842"
    apply %w[
      patches/01-manpages-in-section-1-not-in-section-1l
      patches/02-branding-patch-this-is-debian-unzip
      patches/03-include-unistd-for-kfreebsd
      patches/04-handle-pkware-verification-bit
      patches/05-fix-uid-gid-handling
      patches/06-initialize-the-symlink-flag
      patches/07-increase-size-of-cfactorstr
      patches/08-allow-greater-hostver-values
      patches/09-cve-2014-8139-crc-overflow
      patches/10-cve-2014-8140-test-compr-eb
      patches/11-cve-2014-8141-getzip64data
      patches/12-cve-2014-9636-test-compr-eb
      patches/13-remove-build-date
      patches/14-cve-2015-7696
      patches/15-cve-2015-7697
      patches/16-fix-integer-underflow-csiz-decrypted
      patches/20-unzip60-alt-iconv-utf8
    ]
  end

  def install
    system "make", "-f", "unix/Makefile",
      "CC=#{ENV.cc}",
      "LOC=-DLARGE_FILE_SUPPORT",
      "D_USE_BZ2=-DUSE_BZIP2",
      "L_BZ2=-lbz2",
      "LFLAGS1=-liconv",
      "macosx"
    system "make", "prefix=#{prefix}", "MANDIR=#{man}", "install"
  end

  test do
    system "#{bin}/unzip", "--help"
  end
end
