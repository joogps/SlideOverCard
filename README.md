# SlideOverCard

<p>
    <img src="https://img.shields.io/badge/iOS-14.0+-blue.svg" />
    <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
    <a href="https://twitter.com/joogps">
        <img src="https://img.shields.io/badge/Contact-@joogps-lightgrey.svg?style=social&logo=twitter" alt="Twitter: @joogps" />
    </a>
</p>

A SwiftUI slide over card design, similar to the one used by apple in HomeKit and AirPods setup, NFC scanning and more. It is specially great for setup interactions.

## Installation
This repository is a Swift package, so all you gotta do is search and include it in your project under **File > Swift Package Manager**. Then, just add `import SlideOverCard` to the files where this package will be referenced and you're good to go!

## Usage

You can add a card to your app in two different ways. The first one is by adding a `.slideOverCard()` modifier, which works similarly to a `.sheet()`
```swift
.slideOverCard(isPresented: $isPresented) {
  // Here goes your awesome content
}
```

Here, `$isPresented` is a boolean binding. This way you can dismiss the view anytime by setting it to `false`. This view will have a transition, drag controls and an exit button set by default. You can override this by setting the `dragEnabled`,  `dragToDismiss` and `displayExitButton` boolean parameters:
```swift
// This creates a card that can be dragged, but can't be dismissed
.slideOverCard(isPresented: $isPresented, dragToDismiss: false) {
}
```

```swift
// This creates a card that can't be dragged
.slideOverCard(isPresented: $isPresented, dragEnabled: false) {
}
```

```swift
// This creates a card with no exit button
.slideOverCard(isPresented: $isPresented, displayExitButton: false) {
}
```

Alternatively, you can instantiate the card by your own with `SlideOverCardView`. Please note it won't be automatically positioned in the screen.
```swift
if isPresented {
  SlideOverCardView(isPresented: $isPresented) {
    // Here goes your super-duper cool content
  }
}
```

## Accessory views
 
There are a few accessory views to enhance your card layout. The first one is the `SOCActionButton()` button style, which can be applied to any button to give it a default "primary action" look, based on the app's accent color. The `SOCAlternateButton()` style will reproduce the same design, but with gray. And `SOCEmptyButton()`  will create a regular, all-text "last option" kind of button. You can use them like this:
```swift
Button("Do something", action: { }).buttonStyle(SOCActionButton())
```

There's also the `SOCExitButton()` view. This view will create the default exit button icon used for the card (based on github.com/joogps/ExitButton).

# Example

The SwiftUI code for a demo view can be found [here](https://github.com/joogps/SlideOverCard/blob/74fe5b8531bf0cae46d30d4a203c9282ce0676c6/Sources/SlideOverCard/SlideOverCard.swift#L85). It's an Xcode preview, and you can experience it right within the package folder, under **Swift Package Dependencies**, in your project.
