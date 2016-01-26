# "File" is a reserved class name
class FileFormula < Formula
  desc "Utility to determine file types"
  homepage "http://www.darwinsys.com/file/"
  url "ftp://ftp.astron.com/pub/file/file-5.25.tar.gz"
  mirror "https://fossies.org/linux/misc/file-5.25.tar.gz"
  sha256 "3735381563f69fb4239470b8c51b876a80425348b8285a7cded8b61d6b890eca"

  head "https://github.com/file/file.git"

  bottle do
    revision 1
    sha256 "81b8fe1d837353a824b35456df78f1e0e0c46d5ac1ba179b8cf26df5d3085594" => :el_capitan
    sha256 "1f200ceda946f1a3c0b1a7a4a5c2b0b56dbf8c9bae1699350dfb6fe52130decc" => :yosemite
    sha256 "128a381965ee0b833b2d62f7ffbc6bdb8c28bb08e8ade4ae54b42a73f47f9a98" => :mavericks
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-fsect-man5"
    system "make", "install"
  end

  test do
    system "#{bin}/file", test_fixtures("test.mp3")
  end
end
