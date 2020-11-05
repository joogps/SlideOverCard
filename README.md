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

Here, `$isPresented` is a binding to a `@State` boolean. This way you can dismiss the view anytime by setting it to `false`. This view will have a transition and drag controls set by default. You can override this by setting the `dragEnabled` and `dragToDismiss` boolean parameters:
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

Alternatively, you can instantiate the card by your own with `SlideOverCardView`. Please note it won't be automatically positioned in the screen.
```swift
if isPresented {
  SlideOverCardView(isPresented: $isPresented) {
    // Here goes your super-duper cool content
  }
}
```
