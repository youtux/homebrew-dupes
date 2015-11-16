class Grep < Formula
  homepage "https://www.gnu.org/software/grep/"
  url "http://ftpmirror.gnu.org/grep/grep-2.22.tar.xz"
  mirror "https://ftp.gnu.org/gnu/grep/grep-2.22.tar.xz"
  sha256 "ca91d22f017bfcb503d4bc3b44295491c89a33a3df0c3d8b8614f2d3831836eb"

  depends_on "pkg-config" => :build
  depends_on "pcre"

  option "with-default-names", "Do not prepend 'g' to the binary"
  deprecated_option "default-names" => "with-default-names"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-nls
      --prefix=#{prefix}
      --infodir=#{info}
      --mandir=#{man}
      --with-packager=Homebrew
    ]

    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  def caveats
    if build.without? "default-names" then <<-EOS.undent
      The command has been installed with the prefix "g".
      If you do not want the prefix, install using the "with-default-names"
      option.
      EOS
    end
  end

  test do
    text_file = testpath/"file.txt"
    text_file.write "This line should be matched"
    cmd = build.with?("default-names") ? "grep" : "ggrep"
    grepped = shell_output("#{bin}/#{cmd} 'match' #{text_file}")
    assert_match /should be matched/, grepped
  end
end
