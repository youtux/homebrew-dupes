class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.5/nano-2.5.3.tar.gz"
  mirror "ftp://ftp.gnu.org/pub/gnu/nano/nano-2.5.3.tar.gz"
  sha256 "b2b060129b9feff2d4870d803a441178c96531de9aed144ec0b83bd63ccb12ee"

  bottle do
    cellar :any
    sha256 "771554b0b08b810b7a85ef189f669f22638918dedfbf7314c8367aa6a80febe9" => :el_capitan
    sha256 "218ca89170c79ed6b6201ba855d13422ccda56a141f3882c927f52c31a05423c" => :yosemite
    sha256 "7aead9e12c5c2c4c2dc254b584c414045886e6cd77fade57235080b0d39f661c" => :mavericks
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
