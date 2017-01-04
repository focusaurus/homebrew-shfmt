class Shfmt < Formula
  desc "Autoformat shell script source code"
  homepage "https://github.com/mvdan/sh"
  url "https://github.com/mvdan/sh/archive/v#0.1.0.tar.gz"
  sha256 "357fa088dee9eaeceb2044df2456ab80cac33aca657fa920d052b04336d40150"
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
