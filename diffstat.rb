class Diffstat < Formula
  desc "Produce graph of changes introduced by a diff file"
  homepage "http://invisible-island.net/diffstat/"
  url "https://mirrors.kernel.org/debian/pool/main/d/diffstat/diffstat_1.61.orig.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/d/diffstat/diffstat_1.61.orig.tar.gz"
  sha256 "25359e0c27183f997b36c9202583b5dc2df390c20e22a92606af4bf7856a55ee"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "a668a1005bd2637d1e8d53981e7ab245d436f5edf12aaf3d50b9586dc2c34d60" => :el_capitan
    sha256 "e0c5096b5a5a8a9fba502479897950c3d040aeb6026c7907a8a49320b0d15012" => :yosemite
    sha256 "d70bbd3435223cafaaf268ed55ef4152a56ff03daee138775561a6d96ef51e1c" => :mavericks
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"diff.diff").write <<-EOS.undent
      diff --git a/diffstat.rb b/diffstat.rb
      index 596be42..5ff14c7 100644
      --- a/diffstat.rb
      +++ b/diffstat.rb
      @@ -2,9 +2,8 @@
      -  url 'http://invisible-island.net/datafiles/release/diffstat.tar.gz'
      -  version '1.58'
      -  sha1 '7a67ecb996ea65480bd0b9db33d8ed458e5f2a24'
      +  url 'ftp://invisible-island.net/diffstat/diffstat-1.58.tgz'
      +  sha256 'fad5135199c3b9aea132c5d45874248f4ce0ff35f61abb8d03c3b90258713793'
    EOS
    output = `#{bin}/diffstat diff.diff`
    diff = <<-EOS
 diffstat.rb |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
    EOS
    assert_equal diff, output
  end
end
