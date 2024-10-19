class Jsdoc3 < Formula
  desc "API documentation generator for JavaScript"
  homepage "https://jsdoc.app/"
  url "https://registry.npmjs.org/jsdoc/-/jsdoc-4.0.4.tgz"
  sha256 "900416d5ed87a94ea35b886d9e2b0265c541082d904c0b1bf38cbdcbe58f7933"
  license "Apache-2.0"
  head "https://github.com/jsdoc3/jsdoc.git", branch: "main"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, all: "c2c7d9acd73491e16332fe27a05c15006ec39e8f8f53408f155fc72d56b2103f"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.js").write <<~EOS
      /**
       * Represents a formula.
       * @constructor
       * @param {string} name - the name of the formula.
       * @param {string} version - the version of the formula.
       **/
      function Formula(name, version) {}
    EOS

    system bin/"jsdoc", "--verbose", "test.js"
  end
end
