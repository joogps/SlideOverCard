<h1> SlideOverCard
  <img align="right" alt="Project logo" src="../assets/icon-small.png" width=128px>
</h1>

<p>
    <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
    <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
    <a href="https://twitter.com/joogps">
        <img src="https://img.shields.io/badge/Contact-@joogps-lightgrey.svg?style=social&logo=twitter" alt="Twitter: @joogps" />
    </a>
</p>

A SwiftUI card design, similar to the one used by Apple in HomeKit, AirPods, Apple Card and AirTag setup, NFC scanning, Wi-Fi password sharing and more. It is specially great for setup interactions.

<p>
    <img alt="Clear Spaces demo" src="../assets/demo-clear-spaces.gif" margin-right=20px>
    <img alt="QR code scanner demo" src="../assets/demo-qr-code.gif">
    <img alt="Example preview demo" src="../assets/demo-example.gif">
</p>

_From left to right: SlideOverCard being used in [Clear Spaces](https://apps.apple.com/us/app/clear-spaces/id1532666619), a QR code scanner prompt (made with [CodeScanner](https://github.com/twostraws/CodeScanner)) and a sample demo app_

## Installation
This repository is a Swift package, so just include it in your Xcode project and target under **File > Add package dependencies**. Then, `import SlideOverCard` to the Swift files where you'll be using it.

> [!NOTE]  
> If your app runs on iOS 13, you might find a problem with keyboard responsiveness in your layout. That's caused by a SwiftUI limitation, unfortunately, since the [`ignoresSafeArea`](https://developer.apple.com/documentation/swiftui/text/ignoressafearea(_:edges:)) modifier was only introduced for the SwiftUI framework in the iOS 14 update.
> 

## Usage
Adding a card to your app is insanely easy. Just add a `.slideOverCard()` modifier anywhere in your view hierarchy, similarly to a `.sheet()`:
```swift
.slideOverCard(isPresented: $isPresented) {
  // Here goes your awesome content
}
```

In this case, `$isPresented` is a boolean binding. This way you can dismiss the view anytime by setting it to `false`.

## Customization

This view will have a transition, drag controls and a dismiss button set by default. You can override this by setting the `dragEnabled`,  `dragToDismiss` and `displayExitButton` boolean parameters:
```swift

// This creates a card that can be dragged, but not dismissed by dragging
.slideOverCard(isPresented: $isPresented, options: [.disableDragToDismiss]) {
}

// This creates a card that can't be dragged or dismissed by dragging
.slideOverCard(isPresented: $isPresented, options: [.disableDrag, .disableDragToDismiss]) {
}

// This creates a card with no dismiss button
.slideOverCard(isPresented: $isPresented, options: [.hideDismissButton]) {
}
```

If you want to change styling attributes of the card, such as the **corner size**, the **corner style**, the **inner and outer paddings**, the  **dimming opacity** and the **shape fill style**, such as a gradient, just specify a custom `SOCStyle` struct.

```swift
.slideOverCard(isPresented: $isPresented, style: SOCStyle(corners: 24.0,
                                                          continuous: false,
                                                          innerPadding: 16.0,
                                                          outerPadding: 4.0,
                                                          dimmingOpacity: 0.1,
                                                          style: .black)) {
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

---

Alternatively, you can add the card using a binding to an optional identifiable object. That will automatically animate the card between screen changes.
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

## Accessory views
This package also includes a few accessory views to enhance your card layout. The first one is the `SOCActionButton()` button style, which can be applied to any button to give it a default "primary action" look, based on the app's accent color. The `SOCAlternativeButton()` style will reproduce the same design, but with gray. And `SOCEmptyButton()`  will create an all-text "last option" kind of button. You can use them like this:
```swift
Button("Do something", action: {
  ...
}).buttonStyle(SOCActionButton())
```

There's also the `SOCDismissButton()` view. This view will create the default dismiss button icon used for the card (based on https://github.com/joogps/ExitButton).
