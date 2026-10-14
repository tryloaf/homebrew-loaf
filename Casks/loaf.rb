cask "loaf" do
  version "1.0.4,23"
  sha256 "eb0af700307b544d0d8c494ca73578012173f7086c60872d50d408e0c370ab76"

  url "https://downloads.tryloaf.app/loaf/loaf-#{version.csv.first}-#{version.csv.second}.dmg"
  name "loaf"
  desc "WebKit browser with profiles, split view, and Chrome extension support"
  homepage "https://tryloaf.app/"

  livecheck do
    url "https://tryloaf.app/appcast.xml"
    strategy :sparkle do |item|
      "#{item.short_version},#{item.version}"
    end
  end

  auto_updates true
  depends_on macos: :sequoia

  app "loaf.app"

  preflight_steps do
    run "/bin/sh", args: ["-c", %q(/usr/bin/sw_vers -productVersion | /usr/bin/awk -F. '$1 > 15 || ($1 == 15 && $2 >= 4) { ok = 1 } END { if (!ok) { print "loaf requires macOS 15.4 or later." > "/dev/stderr"; exit 1 } }')]
  end
end
