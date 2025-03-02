# frozen_string_literal: true

# mkbrr is a tool for creating, modifying and inspecting torrent files
class Mkbrr < Formula
    desc "Command-line tool for creating, modifying and inspecting torrent files"
    homepage "https://github.com/autobrr/mkbrr"
    url "https://github.com/autobrr/mkbrr/archive/refs/tags/v1.2.0.tar.gz"
    sha256 "72d74a75335d1715e4c38e3272f3d5dbd42f86de6f9b2ebde94dbf19ed61b19e"
    license "GPL-2.0-or-later"
  
    depends_on "go" => :build
  
    def install
      ENV["CGO_ENABLED"] = "0"
      build_time = Time.at(Time.now.to_i).utc.strftime("%Y-%m-%dT%H:%M:%SZ")
      
      ldflags = %W[
        -s -w
        -X main.version=v#{version}
        -X main.buildTime=#{build_time}
      ].join(" ")
  
      system "go", "build", "-o", bin/"mkbrr", "-ldflags=#{ldflags}", "."
    end
  
    test do
      assert_match version.to_s, shell_output("#{bin}/mkbrr version")
    end
  end 