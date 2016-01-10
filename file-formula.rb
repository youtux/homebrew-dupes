# "File" is a reserved class name
class FileFormula < Formula
  desc "Utility to determine file types"
  homepage "http://www.darwinsys.com/file/"
  url "ftp://ftp.astron.com/pub/file/file-5.24.tar.gz"
  mirror "https://fossies.org/linux/misc/file-5.24.tar.gz"
  sha256 "802cb3de2e49e88ef97cdcb52cd507a0f25458112752e398445cea102bc750ce"

  head "https://github.com/file/file.git"

  bottle do
    sha256 "702c10419f6c4c577571e12e367e07c4bb66da0418c58567ca62b2c21b02661b" => :yosemite
    sha256 "cba58564ef13d691cd4d9eb2e294fa0338b67ffe9d03c2d8a48f1d1d46397796" => :mavericks
    sha256 "73a039c88c260f85af6922875dac83e203b416fdd79d14f35c1012757ccb2757" => :mountain_lion
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
