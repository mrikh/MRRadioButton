# MRRadioButton

This is a simple `UIButton` subclass to be used to add a circular radio button. You can use it by subclass a `UIButton` from the storyboard or create the button programmatically. You can see the sample usage inside the Example Project.

## Installation
### Manual
You can download the project and drag and drop the `MRRadioButton.swift` file.

### Cocoapods
To install it via cocoapods, add the following to your podfile
`pod 'MRRadioButton'`

## Usage:
Please note that right now this is only for a circular radio button

### Programmatically instantiation:
`let button = MRRadioButton(frame: CGRect(x: 0.0, y: 0.0, width : 30.0, height : 30.0))`
### To use it via storyboard, subclass your `UIButton`.

### Updataing button status
Just call the following method whenever you want to update the button state

`button.updateSelection(select: true, animated: true)`

### Current Status:
You can fetch the current status of the button via the read-only property `currentlySelected`

### Customization:
`backgroundFillColor` - This will be the background color to fill the button with
`borderColor` - Border color of the `UIButton`
`borderWidth` - Border width of the `UIButton`



![alt tag](https://media.giphy.com/media/1msHh02cw6fiUPwOtb/giphy.gif)
