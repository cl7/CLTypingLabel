# CLTypingLabel ![Language](https://img.shields.io/badge/iOS-Swift5-orange.svg) <img src="https://travis-ci.org/travis-ci/travis-web.svg?branch=master">

<img src="https://raw.githubusercontent.com/l800891/CLTypingLabel/master/Assets/demogiff.gif" width=320>

A lightweight UILabel subclass with character by character typewriter like animation in Swift, super simple to use

iOS上自带逐字打印动画效果的UILabel

## Installation

### Manual

0. Copy and paste <a href="https://github.com/l800891/CLTypingLabel/blob/master/Pod/Classes/CLTypingLabel.swift">CLTypingLabel.swift</a> to your xcode project.

### [CocoaPods](https://cocoapods.org/pods/CLTypingLabel)

1. Install the latest release of CocoaPods: `gem install cocoapods`
2. Add this line to your Podfile: `pod 'CLTypingLabel'`
3. Install the pod: `pod install`


## Usage

1. Change the class of a label from UILabel to CLTypingLabel;

 <img src="https://raw.githubusercontent.com/l800891/CLTypingLabel/master/Assets/UILabelShot.png" width=200>
2. Programmatically set the .text property of your CLTypingLabel to a new String. The animation will be triggered automatically.


## Sample Code

```swift
@IBOutlet weak var myTypeWriterLabel: CLTypingLabel!
```
At runtime, set text of the label will trigger animation automatically:
```swift
myTypeWriterLabel.text = "This is a demo of typing label animation..."

```
You can also trigger what you need after animation is finished:
```swift
myTypeWriterLabel.onTypingAnimationFinished = {
	//code goes here
}
```
Or you can also trigger what you need after each letter is typed:
```swift
myTypeWriterLabel.onLetterTyped = {
	//code goes here
}
```
Also works on attributedText:
```swift
myTypeWriterLabel.attributedText = NSAttributedString(string: "This is an attributed text typing animation...", attributes: attr)

```
You can pause the typing animation at any time:
```swift
myTypeWriterLabel.pauseTyping() //this will pause the typing animation
myTypeWriterLabel.continueTyping() //this will continue paused typing animation
```
And customize time interval between each character:
```swift
myTypeWriterLabel.charInterval = 0.08 //optional, default is 0.1
```

## License

This code is distributed under the terms and conditions of the MIT license.
