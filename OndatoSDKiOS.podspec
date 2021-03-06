Pod::Spec.new do |spec|
  spec.name         = 'OndatoSDKiOS'
  spec.version      = '1.6.4'
  spec.platform     = :ios
  spec.summary      = 'Ondato iOS SDK'
  spec.ios.deployment_target = '13.0'
  spec.homepage     = 'https://github.com/ondato/ondato-sdk-ios'
  spec.authors      = { 'Ondato' => 'info@ondato.com' }
  spec.source       = { :git => 'git@github.com:ondato/ondato-sdk-ios.git', :tag => spec.version }
  spec.ios.vendored_frameworks  = 'OndatoSDK.framework', 'FaceTecSDK.framework'
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
