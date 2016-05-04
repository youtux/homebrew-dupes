class AppleGcc42 < Formula
  desc "GNU compiler collection"
  homepage "https://r.research.att.com/tools/"
  url "https://r.research.att.com/tools/gcc-42-5666.3-darwin11.pkg"
  mirror "https://web.archive.org/web/20130512150329/https://r.research.att.com/tools/gcc-42-5666.3-darwin11.pkg"
  version "4.2.1-5666.3"
  sha256 "2f3893b411f578bfa98a99646ecfea0ba14e1bff4e4f311d7e595936d0da065d"

  option "with-gfortran-symlink", "Provide gfortran symlinks"

  depends_on :macos => :lion

  def install
    system "/bin/pax", "--insecure", "-rz", "-f", "usr.pkg/Payload", "-s", ",./usr,#{prefix},"

    if build.with? "gfortran-symlink"
      bin.install_symlink "gfortran-4.2" => "gfortran"
      man1.install_symlink "gfortran-4.2.1" => "gfortran.1"
    end
  end

  def caveats
    <<-EOS.undent
      NOTE:
      This formula provides components that were removed from XCode in the 4.2
      release. There is no reason to install this formula if you are using a
      version of XCode prior to 4.2.

      This formula contains compilers built from Apple's GCC sources, build
      5666.3, available from:

        https://opensource.apple.com/tarballs/gcc

      All compilers have a `-4.2` suffix. A GFortran compiler is also included.
    EOS
  end
end
