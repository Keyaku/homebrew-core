# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Satyr < Formula
  desc "Tools to create anonymous, machine-friendly problem reports"
  homepage "https://github.com/abrt/satyr"
  url "https://github.com/abrt/satyr/archive/refs/tags/0.42.tar.gz"
  sha256 "b3a550736835caa9beb94c39b0e8c18341915ca6a2c04c9a96e2fde6a331ec7d"
  license "GPL-2.0-or-later"

  ### Dependencies
  # Build-only
  depends_on "automake" => [:build]
  depends_on "binutils" => [:build]
  depends_on "doxygen" => [:build]
  depends_on "elfutils" => [:build]
  depends_on "gcc" => [:build]
  depends_on "gdb" => [:build]
  depends_on "glib" => [:build]
  depends_on "gperf" => [:build]
  depends_on "json-c" => [:build]
  depends_on "libtool" => [:build]
  depends_on "make" => [:build]
  depends_on "python" => [:build]
  depends_on "rpm" => [:build]

  # General
  depends_on "pkgconfig"

  ### Build functions
  def std_configure_args(prefix: self.prefix, libdir: "lib")
    libdir = Pathname(libdir).expand_path(prefix)
    ["--disable-dependency-tracking", "--prefix=#{prefix}", "--libdir=#{libdir}"]
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "./autogen.sh"
    system "./configure", *std_configure_args
    system "make"
    system "make install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test satyr`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/satyr", "--help"
  end
end
