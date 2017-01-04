class Shfmt < Formula
  desc "Autoformat shell script source code"
  homepage "https://github.com/mvdan/sh"
  url "https://github.com/mvdan/sh/archive/v#1.0.0.tar.gz"
  sha256 "e28bf7d9fcc22cdfde0c7c8f31e3648a4847e7bda9cb69f309f24257eee3dd41"
  head "https://github.com/mvdan/sh.git"
  depends_on "go" => :build

  def install
    # We have to setup a really deep directory structure
    # so go build will find all the code properly
    version = "0.1.0"
    ENV["GOPATH"] = buildpath/".."
    mkdir_p buildpath/"../src/github.com/mvdan"
    mv buildpath/"../sh-#{version}", buildpath/"../src/github.com/mvdan/sh"
    mkdir buildpath/"sh-#{version}" # so cleanup doesn't fail
    cd buildpath/".." do
      system "go", "build", "-a", "-tags", "production brew", "github.com/mvdan/sh/cmd/shfmt"
      bin.install "shfmt"
    end
  end

  test do
    touch "shfmt-test-empty"
    system "#{bin}/shfmt", "shfmt-test-empty"
  end
end
