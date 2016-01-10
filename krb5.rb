class Krb5 < Formula
  desc "Network authentication protocol"
  homepage "http://web.mit.edu/kerberos/"
  url "http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.tar.gz"
  sha256 "cedb07fad8331e3ff2983d26e977a2ddba622f379c2b19bfea85bd695930f9e9"

  bottle do
    sha256 "6d0e91f4f9f4ad6c7807f8164c81f379cf89a1003fc1ac6c1c50b20924cd5e54" => :yosemite
    sha256 "ceb7523bd7d3934ccb6413a65797ee02c6b84a9528dfa9fe0eddfe60febc13b7" => :mavericks
    sha256 "707a3162f197c2343645b85699567815d6957385af258344c235e8c5d0a31f4e" => :mountain_lion
  end

  keg_only :provided_by_osx

  depends_on "openssl"

  def install
    cd "src" do
      system "./configure",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/krb5-config", "--version"
    assert_match include.to_s,
      shell_output("#{bin}/krb5-config --cflags")
  end
end
