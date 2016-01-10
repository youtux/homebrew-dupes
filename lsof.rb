class Lsof < Formula
  desc "Utility to list open files"
  homepage "http://people.freebsd.org/~abe/"
  url "ftp://sunsite.ualberta.ca/pub/Mirror/lsof/lsof_4.88.tar.bz2"
  mirror "http://mirror.jaredwhiting.net/distfiles/lsof_4.88.tar.bz2"
  sha256 "fe6f9b0e26b779ccd0ea5a0b6327c2b5c38d207a6db16f61ac01bd6c44e5c99b"

  def install
    ENV["LSOF_INCLUDE"] = "#{MacOS.sdk_path}/usr/include"

    system "tar", "xf", "lsof_#{version}_src.tar"

    cd "lsof_#{version}_src" do
      # Source hardcodes full header paths at /usr/include
      inreplace %w[dialects/darwin/kmem/dlsof.h dialects/darwin/kmem/machine.h
                   dialects/darwin/libproc/machine.h],
                "/usr/include", MacOS.sdk_path.to_s + "/usr/include"

      mv "00README", "../README"
      system "./Configure", "-n", "darwin"
      system "make"
      bin.install "lsof"
    end
  end

  test do
    (testpath/"test").open("w") do
      system "#{bin}/lsof", testpath/"test"
    end
  end
end
