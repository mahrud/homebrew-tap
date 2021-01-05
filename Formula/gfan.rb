class Gfan < Formula
  desc "Grobner fans and tropical varieties"
  homepage "https://users-math.au.dk/~jensen/software/gfan/gfan.html"
  url "https://users-math.au.dk/~jensen/software/gfan/gfan0.6.2.tar.gz"
  sha256 "a674d5e5dc43634397de0d55dd5da3c32bd358d05f72b73a50e62c1a1686f10a"
  license "GPL-2.0-or-later"
  revision 2

  bottle do
    root_url "https://github.com/mahrud/homebrew-tap/releases/download/gfan-0.6.2_2"
    cellar :any
    sha256 "c5b2e0afafa57fe3bdbab68efa8de8cbb62cc3b6321c3a25d88f21165f42fcbe" => :catalina
    sha256 "e1042c120fe9535956872f4427dbb3d6deeba5d2c79079421f31b0bd03bd0cc2" => :x86_64_linux
  end

  depends_on "cddlib@0.94k"
  depends_on "factory@4.1.3"
  depends_on "gmp"

  patch do
    url "https://raw.githubusercontent.com/Macaulay2/M2/d51564127d757a3132684e9730f4085cb89297bb/M2/libraries/gfan/patch-0.6.2"
    sha256 "9ebbf25e6de16baec877050bef69c85504e7bfa81e79407c2ab00ea4433e838c"
  end

  def install
    system "make", "-j4", "cddnoprefix=yes",
           "GMP_LINKOPTIONS=-L#{Formula["gmp"].lib} -lgmp",
           "GMP_INCLUDEOPTIONS=-I#{Formula["gmp"].include}",
           "OPTFLAGS=-DGMPRATIONAL -I#{Formula["cddlib@0.94k"].include}/cddlib",
           "CLINKER=#{ENV.cc} -L#{Formula["cddlib@0.94k"].lib}",
           "CCLINKER=#{ENV.cxx} -L#{Formula["cddlib@0.94k"].lib}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/gfan", "_version"
  end
end
