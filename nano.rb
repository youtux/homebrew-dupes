class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.5/nano-2.5.1.tar.gz"
  sha256 "e06fca01bf183f4d531aa65a28dffc0e2d10185239909eb3de797023f3453bde"

  bottle do
    cellar :any
    sha256 "9e802c7b762a04264d74abe0806fec3cccc56058cd13c523e68a403ecaa939cf" => :el_capitan
    sha256 "a4603e9da97b416fe6bdbb56a18a547b42e0c372aa996b024da61aa7def41012" => :yosemite
    sha256 "b803822ca3dbb21cffd5003bc4e49258ca655ae6920c060ba2c047e591ce7b0d" => :mavericks
  end

  head do
    url "svn://svn.sv.gnu.org/nano/trunk/nano"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"

  def install
    # Otherwise SIGWINCH will not be defined
    ENV.append_to_cflags "-U_XOPEN_SOURCE" if MacOS.version < :leopard

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--disable-nls",
                          "--enable-utf8"
    system "make", "install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
