class Ed < Formula
  desc "Classic UNIX line editor"
  homepage "https://www.gnu.org/software/ed/ed.html"
  url "http://ftpmirror.gnu.org/ed/ed-1.11.tar.lz"
  mirror "https://ftp.gnu.org/gnu/ed/ed-1.11.tar.lz"
  sha256 "bd146ede5f225e20946ad94ef6bdf07939313bcc41dde5d2beedcea1a147a134"

  bottle do
    cellar :any
    sha256 "920dbc17341d294763705acfb77279d81c36d6264417356b0a3ead9c0b230254" => :yosemite
    sha256 "65abafbca71eea0d0ca13e39deb2f9ee81b8330efe28c7184a833efc0838da07" => :mavericks
    sha256 "3794a3703823cbd4c8ccd68a3c7c3e1462748ffdc82b01dfe03823948541d3f3" => :mountain_lion
  end

  deprecated_option "default-names" => "with-default-names"
  option "with-default-names", "Don't prepend 'g' to the binaries"

  def install
    ENV.j1

    args = ["--prefix=#{prefix}"]
    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  def caveats
    if build.without? "default-names" then <<-EOS.undent
      The command has been installed with the prefix "g".
      If you do not want the prefix, reinstall using the "with-default-names" option.
      EOS
    end
  end

  test do
    testfile = (testpath/"test")
    testfile.write "Hello world"
    pipe_output("#{bin}/ged -s #{testfile}", ",s/o//\nw\n")
    assert_equal "Hell world", testfile.read.chomp
  end
end
