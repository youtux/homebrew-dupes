class Make < Formula
  desc "Utility for directing compilation"
  homepage "https://www.gnu.org/software/make/"
  url "http://ftpmirror.gnu.org/make/make-4.2.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/make/make-4.2.tar.bz2"
  sha256 "4e5ce3b62fe5d75ff8db92b7f6df91e476d10c3aceebf1639796dc5bfece655f"

  bottle do
    revision 2
    sha256 "10422e0041378647f8d81478377477dafb4b661be1ee0cc20e221bb0f1131ca6" => :el_capitan
    sha256 "c1daebeb0b4251e698089ed658d65db6bed2934c66c10be79e51a33cbb7851fa" => :yosemite
    sha256 "ae7f93ce2476617f1519cf9126e77e2c2ff075d6dc6fb0f42bbce0cc8363d0c8" => :mavericks
  end

  option "with-default-names", "Do not prepend 'g' to the binary"

  depends_on "guile" => :optional

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << "--with-guile" if build.with? "guile"
    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"Makefile").write <<-EOS.undent
      default:
      \t@echo Homebrew
    EOS

    cmd = build.with?("default-names") ? "make" : "gmake"

    assert_equal "Homebrew\n",
      shell_output("#{bin}/#{cmd}")
  end
end
