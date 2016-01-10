class Gperf < Formula
  desc "Perfect hash function generator"
  homepage "https://www.gnu.org/software/gperf"
  url "http://ftpmirror.gnu.org/gperf/gperf-3.0.4.tar.gz"
  mirror "https://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz"
  sha256 "767112a204407e62dbc3106647cf839ed544f3cf5d0f0523aaa2508623aad63e"

  keg_only :provided_until_xcode43

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "TOTAL_KEYWORDS 3",
      pipe_output("#{bin}/gperf", "homebrew\nfoobar\ntest\n")
  end
end
