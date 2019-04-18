#
# Be sure to run `pod lib lint MXBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
s.name             = 'MXBase'
s.version          = '2.8.0'
s.summary          = '基础组件库'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = <<-DESC
这是一个基础组件库
DESC
s.homepage         = 'http://120.55.102.11:8192/iOSCoder/MXBase'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Feyewon' => '1497332442@qq.com' }
s.source           = { :git => 'git@120.55.102.11:iOSCoder/MXBase.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
s.ios.deployment_target = '8.0'

s.subspec 'Helpers' do |h|
    h.source_files = 'MXBase/Classes/Helpers/**/*'
end

s.subspec 'KvoController' do |k|
    k.source_files = 'MXBase/Classes/KvoController/**/*'
end

s.subspec 'AttributeStringTool' do |a|
    a.source_files = 'MXBase/Classes/AttributeStringTool/**/*'
end

s.subspec 'Category' do |c|
    c.source_files = 'MXBase/Classes/Category/**/*'
end

s.subspec 'Alert' do |alert|
    alert.source_files = 'MXBase/Classes/Alert/**/*'
    alert.dependency 'MXBase/Base'
    alert.dependency 'Masonry'
    alert.dependency 'MXBase/Category'
    alert.dependency 'MXBase/AttributeStringTool'
    alert.dependency 'SDCAlertView' , '~> 2.5.4'
end

s.subspec 'System' do |sy|
    sy.source_files = 'MXBase/Classes/System/**/*'
    sy.frameworks = 'UIKit'
    sy.dependency 'MXBase/Base'
    sy.dependency 'AFNetworking/Reachability'
end

s.subspec 'BlockTool' do |b|
    b.source_files = 'MXBase/Classes/BlockTool/**/*'
end

s.subspec 'Base' do |ba|
    ba.source_files = 'MXBase/Classes/Base/**/*'
    ba.dependency 'UICKeyChainStore'
end

s.subspec 'ErrorLoadingView' do |errorLoadView|
    errorLoadView.source_files = 'MXBase/Classes/ErrorLoadingView/**/*'
    errorLoadView.resource_bundles = {
        'ErrorLoadingView' => ['MXBase/Assets/ErrorLoadingView/*.png']
    }
    errorLoadView.dependency 'Masonry'
    errorLoadView.dependency 'MBProgressHUD'
    errorLoadView.dependency 'MXBase/Category'
end

s.subspec 'EmptyView' do |emptyView|
    emptyView.source_files = 'MXBase/Classes/EmptyView/**/*'
end

s.subspec 'Toast' do |toast|
    toast.source_files = 'MXBase/Classes/Toast/**/*'
end

s.subspec 'Refresh' do |refresh|
    refresh.source_files = 'MXBase/Classes/Refresh/**/*'
    refresh.dependency 'MJRefresh'
end

s.subspec 'BeeHive' do |bh|
    bh.dependency 'BeeHive'
end

s.subspec 'CustomView' do |csv|
    csv.source_files = 'MXBase/Classes/CustomView/**/*'
end

s.subspec 'MenuPage' do |pvc|
    pvc.source_files = 'MXBase/Classes/MenuPage/**/*'
    pvc.dependency 'WMPageController'
end

s.subspec 'Parser' do |ps|
    ps.dependency 'MJExtension'
end

s.subspec 'NavigationVC' do |nvc|
    nvc.source_files = 'MXBase/Classes/NavigationVC/**/*'
    nvc.resource_bundles = {
        'NavigationVC' => ['MXBase/Assets/NavigationVC/*.png']
    }
    nvc.dependency 'MXBase/Category'
end

s.subspec 'PhotoLibrary' do |pl|
    pl.source_files = 'MXBase/Classes/PhotoLibrary/**/*'
    pl.dependency 'MXBase/Category'
    pl.dependency 'MXBase/Base'
end

s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

# s.resource_bundles = {
#   'MXBase' => ['MXBase/Assets/*.png']
# }
# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
