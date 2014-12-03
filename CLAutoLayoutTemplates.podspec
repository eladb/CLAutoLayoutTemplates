Pod::Spec.new do |s|
  s.name             = "CLAutoLayoutTemplates"
  s.version          = "0.1.0"
  s.summary          = "Apply constraints to a UIView from another UIView"
  s.description      = <<-DESC
                       CLAutoLayoutTemplates is `[UIView replaceConstraintsForItem:templateItem:]`. You should call this method
                       on the top-level view. It will then remove all the constraints that reference the first item and create
                       and add new constraints based on the template item.

                       I have been using this for animating bounds by creating a hidden `UIView` (e.g. `self.templateView`) with the auto-layout constraints I wanted and then calling `[self.view replaceConstraintsForItem:self.myView templateItem:self.templateView]` inside
                       an animation block.
                       DESC
  s.homepage         = "https://github.com/eladb/CLAutoLayoutTemplates"
  s.license          = 'MIT'
  s.author           = { "Elad Ben-Israel" => "elad.benisrael@gmail.com" }
  s.source           = { :git => "https://github.com/eladb/CLAutoLayoutTemplates.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/emeshbi'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'CLAutoLayoutTemplates/*'
  # s.frameworks = 'UIKit'
end
