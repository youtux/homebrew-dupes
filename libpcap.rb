class Libpcap < Formula
  desc "Portable library for network traffic capture"
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/libpcap-1.7.4.tar.gz"
  sha256 "7ad3112187e88328b85e46dce7a9b949632af18ee74d97ffc3f2b41fe7f448b0"
  head "git://bpf.tcpdump.org/libpcap"

  bottle do
    cellar :any
    sha256 "3126a1acd16a59a320d61d0fc050d05a9d0c39896ac63552be73af76cf0a1546" => :yosemite
    sha256 "c3fa203c6bcc117e55cf611b1ce228fad2d722d26ebff34428db0f293dc6e840" => :mavericks
    sha256 "8c2c6c198d3526df70df0be64fc9c58df44334fde1ac75dd081068027308b951" => :mountain_lion
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make", "install"
  end

  test do
    assert_match /lpcap/, shell_output("#{bin}/pcap-config --libs")
  end
end
