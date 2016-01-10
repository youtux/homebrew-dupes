class Ed < Formula
  desc "Classic UNIX line editor"
  homepage "https://www.gnu.org/software/ed/ed.html"
  url "http://ftpmirror.gnu.org/ed/ed-1.11.tar.lz"
  mirror "https://ftp.gnu.org/gnu/ed/ed-1.11.tar.lz"
  sha256 "bd146ede5f225e20946ad94ef6bdf07939313bcc41dde5d2beedcea1a147a134"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "0483e2e285cb3ef963b89e08975c52bbbe82ef34c201ecc6317b1cd317de2a1d" => :el_capitan
    sha256 "eb947b54aff24f71ffdc1ab97befb21e386940fc2c42b56d7abf85112e70ced6" => :yosemite
    sha256 "57c2cca9fa0ee55465d40efa2ab45250e1161412c62217fd2369ad3594794654" => :mavericks
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
