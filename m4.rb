class M4 < Formula
  desc "Macro processing language"
  homepage "https://www.gnu.org/software/m4"
  url "http://ftpmirror.gnu.org/m4/m4-1.4.17.tar.xz"
  mirror "https://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz"
  sha256 "f0543c3beb51fa6b3337d8025331591e0e18d8ec2886ed391f1aade43477d508"

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Homebrew",
      pipe_output("#{bin}/m4", "define(TEST, Homebrew)\nTEST\n")
  end
end
