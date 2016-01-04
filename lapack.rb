class Lapack < Formula
  desc "Linear Algebra PACKage"
  homepage "http://www.netlib.org/lapack/"
  url "http://www.netlib.org/lapack/lapack-3.6.0.tgz"
  sha256 "a9a0082c918fe14e377bbd570057616768dca76cbdc713457d8199aaa233ffc3"

  bottle do
    cellar :any
    sha256 "b492305db3e74f7fde1d1798fbbb653c9caea0f7436e8bda5af2c19677909fc0" => :yosemite
    sha256 "c099b310cbe3217266a9316cff77471c1c72ad0203def9776c851609e38ea789" => :mavericks
    sha256 "cd6aea6fb9bc22942172bb532a0e6836320b28406341985a11fe9d1dd9ee62ff" => :mountain_lion
  end

  resource "manpages" do
    url "http://netlib.org/lapack/manpages.tgz"
    sha256 "055da7402ea807cc16f6c50b71ac63d290f83a5f2885aa9f679b7ad11dd8903d"
  end

  keg_only :provided_by_osx

  depends_on :fortran
  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS:BOOL=ON", "-DLAPACKE:BOOL=ON", *std_cmake_args
    system "make", "install"
    man.install resource("manpages")
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "lapacke.h"
      int main() {
        void *p = LAPACKE_malloc(sizeof(char)*100);
        if (p) {
          LAPACKE_free(p);
        }
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-I#{include}", "-llapacke", "-o", "test"
    system "./test"
  end
end
