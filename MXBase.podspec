#
# Be sure to run `pod lib lint MXBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
s.name             = 'MXBase'
s.version          = '0.0.1'
s.summary          = '基础组件库'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = <<-DESC
这是一个基础组件库
DESC
s.homepage         = 'https://github.com/Feyewon/MXBase'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Feyewon' => '1497332442@qq.com' }
s.source           = { :git => 'https://github.com/Feyewon/MXBase.git', :tag => s.version.to_s }
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
    c.resource_bundles = {
        'Category' => ['MXBase/Assets/Category.xcassets']
    }
end

s.subspec 'Alert' do |alert|
    alert.source_files = 'MXBase/Classes/Alert/**/*'
    alert.dependency 'MXBase/Base'
    alert.dependency 'Masonry'
    alert.dependency 'MXBase/Category'
    alert.dependency 'MXBase/AttributeStringTool'
    alert.dependency 'SDCAlertView' , '~> 2.5.4'
    alert.resource_bundles = {
        'Alert' => ['MXBase/Assets/Alert.xcassets']
    }
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
    errorLoadView.dependency 'Masonry'
    errorLoadView.dependency 'MBProgressHUD'
    errorLoadView.dependency 'MXBase/Category'
    errorLoadView.resource_bundles = {
        'ErrorLoadingView' => ['MXBase/Assets/ErrorLoadingView.xcassets']
    }
end

s.subspec 'EmptyView' do |emptyView|
    emptyView.source_files = 'MXBase/Classes/EmptyView/**/*'
    emptyView.dependency 'Masonry'
    emptyView.dependency 'MXBase/Category'
    emptyView.resource_bundles = {
        'EmptyView' => ['MXBase/Assets/EmptyView.xcassets']
    }
end

s.subspec 'Toast' do |toast|
    toast.source_files = 'MXBase/Classes/Toast/**/*'
end

s.subspec 'Refresh' do |refresh|
    refresh.source_files = 'MXBase/Classes/Refresh/**/*'
    refresh.dependency 'MJRefresh'
    refresh.dependency 'MXBase/Category'
    refresh.resource_bundles = {
      'Refresh' => ['MXBase/Assets/Refresh.xcassets']
    }
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

s.subspec 'SelectAddress' do |selectAddress|
    selectAddress.source_files = 'MXBase/Classes/SelectAddress/**/*'
end

s.subspec 'Pickers' do |pickers|
    pickers.source_files = 'MXBase/Classes/Pickers/**/*'
end

s.subspec 'TagView' do |tagView|
    tagView.source_files = 'MXBase/Classes/TagView/**/*'
end

s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

# s.resource_bundles = {
#   'MXBase' => ['MXBase/Assets/*.png']
# }
# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
