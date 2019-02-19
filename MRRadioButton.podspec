Pod::Spec.new do |s|
s.name              = 'MRRadioButton'
s.version           = '0.0.1'
s.summary           = 'A customisable radio button for iOS'
s.homepage          = 'https://github.com/mrikh/MRRadioButton'
s.ios.deployment_target = '10.0'
s.platform = :ios, '10.0'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Mayank Rikh'
}
s.source            = {
:git => 'https://github.com/mrikh/MRRadioButton.git',
:tag => "#{s.version}" }
s.framework = "UIKit"
s.source_files      = 'Classes/*'
s.requires_arc      = true
end