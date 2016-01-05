class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "http://www.openldap.org/software/"
  url "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.43.tgz"
  mirror "http://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.43.tgz"
  sha256 "34d78e5598a2b0360d26a9050fcdbbe198c65493b013bb607839d5598b6978c8"

  bottle do
    cellar :any
    revision 2
    sha256 "81f9dccc22a34b5130b7caaae0dd1c0b70c3dcd4c5ca112ab49b6607c43ede55" => :el_capitan
    sha256 "8d29c235baa09f281889ce61fab4eb75d6d7cf0a1abdaf3d9b892b494059abf7" => :yosemite
    sha256 "ad8c3fa83b3e86eb71460a9d747802e0940e9f7e2ab32795cef92c73eddd5763" => :mavericks
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
