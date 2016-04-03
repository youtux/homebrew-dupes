# "File" is a reserved class name
class FileFormula < Formula
  desc "Utility to determine file types"
  homepage "https://www.darwinsys.com/file/"
  url "ftp://ftp.astron.com/pub/file/file-5.25.tar.gz"
  mirror "https://fossies.org/linux/misc/file-5.25.tar.gz"
  sha256 "3735381563f69fb4239470b8c51b876a80425348b8285a7cded8b61d6b890eca"

  head "https://github.com/file/file.git"

  bottle do
    sha256 "0f21e51915b82633c897a5951583bddac4c81435163b772aba1bb67fb4855e32" => :el_capitan
    sha256 "4461d5b1d5bc8e81276a29ca2f78a28a15d872682e6f296a55688ce4e694c700" => :yosemite
    sha256 "6fa08b503be7d043ac8a17f6797500a286fe212c4ce95700fb9c07ebb87c163d" => :mavericks
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
