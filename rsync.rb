class Rsync < Formula
  desc "Utility that provides fast incremental file transfer"
  homepage "https://rsync.samba.org/"
  url "https://rsync.samba.org/ftp/rsync/rsync-3.1.2.tar.gz"
  mirror "https://mirrors.kernel.org/gentoo/distfiles/rsync-3.1.2.tar.gz"
  mirror "https://www.mirrorservice.org/sites/rsync.samba.org/rsync-3.1.2.tar.gz"
  sha256 "ecfa62a7fa3c4c18b9eccd8c16eaddee4bd308a76ea50b5c02a5840f09c0a1c2"

  bottle do
    cellar :any
    revision 1
    sha256 "164e7c934b2de1b49b1885e96903386ea808cb552a3c9dd9e585f7b98ae865cd" => :yosemite
    sha256 "96ee2027bfe92f0b5d3f5812eb8b23a46141134ad8308acda9856a591a9ca807" => :mavericks
    sha256 "3d8b560ebbb6474976804f229ac4861a18aca29ce8541bcb65807096127a3e5f" => :mountain_lion
  end

  depends_on "autoconf" => :build

  if OS.mac?
      patch do
        url "https://download.samba.org/pub/rsync/src/rsync-patches-3.1.2.tar.gz"
        mirror "https://www.mirrorservice.org/sites/rsync.samba.org/rsync-patches-3.1.2.tar.gz"
        mirror "https://launchpad.net/rsync/main/3.1.2/+download/rsync-patches-3.1.2.tar.gz"
        sha256 "edeebe9f2532ae291ce43fb86c9d7aaf80ba4edfdad25dce6d42dc33286b2326"
        apply "patches/fileflags.diff",
              "patches/crtimes.diff",
              "patches/hfs-compression.diff"
      end
  end

  def install
    system "./prepare-source"
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-rsyncd-conf=#{etc}/rsyncd.conf",
                          "--enable-ipv6"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"rsync", "--version"
  end
end
