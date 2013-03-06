# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'giasu_ios'
  app.identifier = 'com.giasudientu.ios'
  app.frameworks += %w{ AdSupport Accounts Social }
  app.weak_frameworks += %w{ AdSupport Accounts Social }

  app.pods do
    pod 'Facebook-iOS-SDK', '~> 3.2.0'
    pod 'AFNetworking'
  end

  app.device_family = :iphone

  #Required for Facebook SDK
  app.info_plist['FacebookAppID'] = '563805473646205'
  app.info_plist['URL types'] = { 'URL Schemes' => 'fb563805473646205' }
  app.info_plist['CFBundleURLTypes'] = [
    {
      'CFBundleURLName' => 'com.giasudientu.ios',
      'CFBundleURLSchemes' => ['fb563805473646205']
    }
]
end
