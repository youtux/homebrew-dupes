class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "http://www.openldap.org/software/"
  url "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.41.tgz"
  mirror "http://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.41.tgz"
  sha256 "27856bb4a8b44feca2b326c309000e16a9dadd52362c8ab6eec6c67a43737f6e"
  revision 1

  bottle do
    cellar :any
    revision 1
    sha256 "a846e09d41a4aa3da514cd5dc7421e774d869ce37747ce566d3c38ddd74cadf0" => :yosemite
    sha256 "0730ad5cd115a9505e59349be335b649321c27d70872b15c498618c39bdff2ec" => :mavericks
    sha256 "111e3e1adba970b8d9d82b6c8de7741790008813c50a226dfb02f8a3ce030b53" => :mountain_lion
  end

  option "with-memberof", "Include memberof overlay"
  option "with-unique", "Include unique overlay"
  option "with-sssvlv", "Enable server side sorting and virtual list view"

  depends_on "berkeley-db4" => :optional
  depends_on "openssl"

  keg_only :provided_by_osx

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    args << "--enable-bdb=no" << "--enable-hdb=no" if build.without? "berkeley-db4"
    args << "--enable-memberof" if build.with? "memberof"
    args << "--enable-unique" if build.with? "unique"
    args << "--enable-sssvlv=yes" if build.with? "sssvlv"

    system "./configure", *args
    system "make", "install"
    (var+"run").mkpath

    # https://github.com/Homebrew/homebrew-dupes/pull/452
    chmod 0755, Dir[etc/"openldap/*"]
    chmod 0755, Dir[etc/"openldap/schema/*"]
  end
end
