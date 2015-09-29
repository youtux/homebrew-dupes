class Awk < Formula
  desc "Brian Kernighan's pattern scanning and processing language"
  homepage "http://www.cs.princeton.edu/~bwk/btl.mirror/"
  url "http://www.cs.princeton.edu/~bwk/btl.mirror/awk.tar.gz"
  version "20121220"
  sha256 "8dc092165c5a4e1449f964286483d06d0dbfba4b0bd003cb5dab30de8f6d9b83"
  head "https://github.com/junghans/nawk.git", :branch => "gentoo"

  def install
    # have to run bison first or parallel build fails
    system "make", "YACC=bison -d -y", "ytab.o"
    system "make"
    bin.install "a.out" => "nawk"

    (libexec/"xpg4bin").install_symlink bin/"nawk" => "awk"

    cp "awk.1", "awk.1.bak"

    # install original manpage to xpg4man before rewriting to "nawk"
    (libexec/"xpg4man"/"man1").install "awk.1"

    mv "awk.1.bak", "awk.1"

    # refer to 'nawk' instead of 'awk' in man page, and add a couple of
    # SEE ALSO items
    [
      ["awk", "nawk"], ["AWK", "NAWK"], ["Awk", "Nawk"],
      [/^.IR sed \(1\)$/, ".IR sed (1),\n.IR gsed (1),\n.IR awk (1),\n.IR gawk (1)"],
    ].each do |s|
      inreplace "awk.1", *s
    end

    man1.install "awk.1" => "nawk.1"
  end

  def caveats; <<-EOS.undent
    This is Brian Kernighan's "new awk" or "BWK awk". It has been
    installed as "nawk", and you can access the man page as "man nawk".

    If you want to use it as "awk" add the "xpg4bin" directory to your
    PATH from your bashrc like:

        PATH="#{opt_libexec}/xpg4bin:$PATH"

    And you can access the man page by adding the "xpg4man" directory to
    your MANPATH from your bashrc as follows:

        MANPATH="#{opt_libexec}/xpg4man:$MANPATH"

    EOS
  end

  test do
    assert_match(/^Working!$/,
      shell_output("#{bin}/nawk 'BEGIN { print \"Working!\"; exit(0); }'"),
                )
  end
end
