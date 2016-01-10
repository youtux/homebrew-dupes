class Diffstat < Formula
  desc "Produce graph of changes introduced by a diff file"
  homepage "http://invisible-island.net/diffstat/"
  url "https://mirrors.kernel.org/debian/pool/main/d/diffstat/diffstat_1.60.orig.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/d/diffstat/diffstat_1.60.orig.tar.gz"
  sha256 "2032e418b43bae70d548e32da901ebc4ac12972381de1314bebde0b126fb0123"

  bottle do
    cellar :any
    sha256 "84df5b412baa164e5c84944dcc2d99549123543994ede36464aa20a7d53316bc" => :yosemite
    sha256 "5562f4fa71c14c113123a68253661927afe7a166be031cf7637439b64b85843a" => :mavericks
    sha256 "182a35fea3273f03374018f28242ce048f8f55c6eff055dba117a1de256fe933" => :mountain_lion
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
