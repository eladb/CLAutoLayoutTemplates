# CLAutoLayoutTemplates

Create UIView constraints based on a template.

The concept behind this library is to allow creating "templates" of Auto Layout constraints and applying them
to views when needed (with or without animation). This is a nice way to keep all Auto Layout definitions in your storyboard or nib file.

__DISCLAIMER__: This library references by name a private class named `NSContentSizeLayoutConstraint` (which we filter out when we copy the constraints from the template). I am in the process of submitting an app to the App Store with this library. Once I have evidence if this will cause a reject, I will update.

## Usage (by example)

A common example would be to use CLAutoLayoutTemplates to animate a frame changes for a view. 

For example, say you have a button `myButton` with an initial position declared using Auto Layout and you want the button to move to a different position, which you would also want to declare using Auto Layout.

With CLAutoLayoutTemplates, you can create a second hidden `UIView` and define the approperiate constraints for it in Interface Builder. This hidden view will be `templateView`.

Then, when you want to move the button:

```swift
func moveButton() {
  UIView.animateWithDuration(0.25) {
    self.view.replaceConstraintsForItem(self.myButton, usingTemplate:self.templateView)
    self.view.layoutIfNeeded()
  }
}
```

CLAutoLayoutTemplates will replace `myButton`'s constraints with new constraints based on all the constraints defined for `templateView`. As you see, we placed this within an animation block, but that's optional of course.

How awesome is that?

## Installation

CLAutoLayoutTemplates is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "CLAutoLayoutTemplates"

## Author

Elad Ben-Israel, elad.benisrael@gmail.com

## License

CLAutoLayoutTemplates is available under the MIT license. See the LICENSE file for more info.