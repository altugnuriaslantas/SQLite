#
# `pod lib lint SQLite.swift.podspec' fails - see
#    https://github.com/CocoaPods/CocoaPods/issues/4607
#

Pod::Spec.new do |s|
  s.name             = "SQLite.swift"
  s.version          = "0.10.1"
  s.summary          = "A type-safe, Swift-language layer over SQLite3 for iOS and OS X."

  s.description      = <<-DESC
    SQLite.swift provides compile-time confidence in SQL statement syntax and
    intent.
                       DESC

  s.homepage         = "https://github.com/stephencelis/SQLite.swift"
  s.license          = 'MIT'
  s.author           = { "Stephen Celis" => "stephen@stephencelis.com" }
  s.source           = { :git => "https://github.com/stephencelis/SQLite.swift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stephencelis'

  s.module_name      = 'SQLite'
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"

  s.default_subspec = 'standard'  

  # use the built-in library version of sqlite3
  s.subspec 'standard' do |ss|
    ss.library = 'sqlite3'
    ss.source_files = 'SQLite/**/*.{c,h,m,swift}'
    ss.exclude_files = 'SQLite/Extensions/Cipher.swift'

    ss.private_header_files = 'SQLite/Core/fts3_tokenizer.h'
    ss.preserve_paths = 'CocoaPods/**/*'
    ss.pod_target_xcconfig = {
      'SWIFT_INCLUDE_PATHS[sdk=macosx*]'           => '$(SRCROOT)/SQLite.swift/CocoaPods/macosx',
      'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(SRCROOT)/SQLite.swift/CocoaPods/iphoneos',
      'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]'  => '$(SRCROOT)/SQLite.swift/CocoaPods/iphonesimulator',
      'SWIFT_INCLUDE_PATHS[sdk=appletvos*]'        => '$(SRCROOT)/SQLite.swift/CocoaPods/appletvos',
      'SWIFT_INCLUDE_PATHS[sdk=appletvsimulator*]' => '$(SRCROOT)/SQLite.swift/CocoaPods/appletvsimulator',
      'SWIFT_INCLUDE_PATHS[sdk=watchos*]'          => '$(SRCROOT)/SQLite.swift/CocoaPods/watchos',
      'SWIFT_INCLUDE_PATHS[sdk=watchsimulator*]'   => '$(SRCROOT)/SQLite.swift/CocoaPods/watchsimulator'
    }
  end

  # use SQLCipher and enable -DSQLITE_HAS_CODEC flag
  s.subspec 'SQLiteCipher' do |ss|
    ss.dependency 'SQLCipher'
    ss.source_files = 'SQLite/**/*.{c,h,m,swift}'

    ss.private_header_files = 'SQLite/Core/fts3_tokenizer.h'

    ss.preserve_paths = 'CocoaPods/**/*'
    ss.pod_target_xcconfig = {
      'SWIFT_INCLUDE_PATHS[sdk=macosx*]'           => '$(SRCROOT)/SQLite.swift/CocoaPods/macosx',
      'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(SRCROOT)/SQLite.swift/CocoaPods/iphoneos',
      'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]'  => '$(SRCROOT)/SQLite.swift/CocoaPods/iphonesimulator',
      'SWIFT_INCLUDE_PATHS[sdk=appletvos*]'        => '$(SRCROOT)/SQLite.swift/CocoaPods/appletvos',
      'SWIFT_INCLUDE_PATHS[sdk=appletvsimulator*]' => '$(SRCROOT)/SQLite.swift/CocoaPods/appletvsimulator',
      'SWIFT_INCLUDE_PATHS[sdk=watchos*]'          => '$(SRCROOT)/SQLite.swift/CocoaPods/watchos',
      'SWIFT_INCLUDE_PATHS[sdk=watchsimulator*]'   => '$(SRCROOT)/SQLite.swift/CocoaPods/watchsimulator'
    }
    ss.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SQLITE_HAS_CODEC=1' }

  end

end