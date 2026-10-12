cask "loaf" do
  version "1.0.2,15"
  sha256 "20973175f8276f3f57c2aa34acf67925e6bc739020bb5b02387831cbdd11823f"

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
