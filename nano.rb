class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.6/nano-2.6.0.tar.gz"
  sha256 "d517a5fcaa9fa6ceda8a63e22be1d83dd7f4af13703c73b10a48e95a6e1178d3"

  bottle do
    sha256 "dd1f04766fed84d5bdefd2aa8806a9c1b487052def4cbbfe8243367dc49d1538" => :el_capitan
    sha256 "e42450e199a37640660c1ae0d0674d78146c9d29c356108d050712c09e6e3679" => :yosemite
    sha256 "7aed49ce01bab697738add47dfaedaa4d9e7bdf3f22097b2bdb9745977ed1c84" => :mavericks
  end

  head do
    url "http://git.savannah.gnu.org/r/nano.git"
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
                          "--enable-utf8"
    system "make", "install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
