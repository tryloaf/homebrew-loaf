cask "loaf" do
  version "1.0.6,30"
  sha256 "1e94e590c6a9d6bf49bd4292903521b401e9a33a6004614e398452de383b866f"

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
