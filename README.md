<h1> SlideOverCard
  <img align="right" alt="Project logo" src="../assets/icon-small.png" width=74px>
</h1>

<p>
    <img src="https://img.shields.io/badge/iOS-14.0+-blue.svg" />
    <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
    <a href="https://twitter.com/joogps">
        <img src="https://img.shields.io/badge/Contact-@joogps-lightgrey.svg?style=social&logo=twitter" alt="Twitter: @joogps" />
    </a>
</p>

A SwiftUI card design, similar to the one used by Apple in HomeKit, AirPods, Apple Card and AirTag setup, NFC scanning, Wi-Fi password sharing and more. It is specially great for setup interactions.

<p>
    <img alt="Clear Spaces demo" src="../assets/demo-clear-spaces.gif" height=400px>
    <img alt="QR code scanner demo" src="../assets/demo-qr-code.gif" height=400px>
    <img alt="Example preview demo" src="../assets/demo-example.gif" height=400px>
</p>

_From left to right: SlideOverCard being used in [Clear Spaces](https://apps.apple.com/us/app/clear-spaces/id1532666619), a QR code scanner prompt (made with https://github.com/twostraws/CodeScanner) and a demo of the project's Xcode preview_

## Installation
This repository is a Swift package, so all you gotta do is search and include it in your project under **File > Swift Package Manager**. Then, just add `import SlideOverCard` to the files where this package will be referenced and you're good to go!

## Usage
You can add a card to your app in two different ways. The first one is by adding a `.slideOverCard()` modifier, which works similarly to a `.sheet()`:
```swift
.slideOverCard(isPresented: $isPresented) {
  // Here goes your awesome content
}
```

Here, `$isPresented` is a boolean binding. This way you can dismiss the view anytime by setting it to `false`. This view will have a transition, drag controls and an exit button set by default. You can override this by setting the `dragEnabled`,  `dragToDismiss` and `displayExitButton` boolean parameters:
```swift

// This creates a card that can be dragged, but not dismissed by dragging
.slideOverCard(isPresented: $isPresented, options: [.disableDragToDismiss]) {
}

// This creates a card that can't be dragged or dismissed by dragging
.slideOverCard(isPresented: $isPresented, options: [.disableDrag, .disableDragToDismiss]) {
}

// This creates a card with no exit button
.slideOverCard(isPresented: $isPresented, options: [.hideExitButton]) {
}
```

In case you want to execute code when the view is dismissed (either by the exit button or drag controls), you can also set an optional `onDismiss` closure parameter:

```swift
// This card will print some text when dismissed
.slideOverCard(isPresented: $isPresented, onDismiss: {
    print("I was dismissed.")
}) {
    // Here goes your amazing layout
}
```

Alternatively, you can add the card using a binding to an optional enumeration. That will automatically animate the card between screen changes.
```swift
// This uses a binding to an optional object in a switch statement
.slideOverCard(item: $activeCard) { item in
    switch item {
        case .welcomeView:
            WelcomeView()
        case .loginView:
            LoginView()
        default:
            ..........
    }
}
```

You can even instantiate the card by your own by adding a `SlideOverCard` view to a ZStack.
```swift
// Using the standalone view
ZStack {
    // This is the background of everything
    
    SlideOverCard(isPresented: $isPresented) {
        // Here goes your super-duper cool screen
    }
}
```

## Accessory views
This package also includes a few accessory views to enhance your card layout. The first one is the `SOCActionButton()` button style, which can be applied to any button to give it a default "primary action" look, based on the app's accent color. The `SOCAlternativeButton()` style will reproduce the same design, but with gray. And `SOCEmptyButton()`  will create an all-text "last option" kind of button. You can use them like this:
```swift
Button("Do something", action: {
  ...
}).buttonStyle(SOCActionButton())
```

There's also the `SOCExitButton()` view. This view will create the default exit button icon used for the card (based on https://github.com/joogps/ExitButton).

## Manager
If you want to add a card as an overlay to all content in the screen, including the tab and navigation bars, you should use the `SOCManager`. The manager helps you display a card as a transparent view controller overlay, therefore going past everything SwiftUI and below. To present this overlay, use:
```swift
SOCManager.present(isPresented: $isPresented) {
    // Here goes that splendid card body
}
```

And to dismiss, just call:
```swift
SOCManager.dismiss(isPresented: $isPresented)
```

# Example

The SwiftUI code for a demo view (which can be seen on the top portion of this page) can be found [here](https://github.com/joogps/SlideOverCard/blob/50e39e3ed2e7614d56c82231be5b2f1fa44a3311/Sources/SlideOverCard/SlideOverCard.swift#L169). It's an Xcode preview, and you can experience it right within the package folder, under **Swift Package Dependencies**, in your project.
