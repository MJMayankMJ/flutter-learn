# meals

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Animations:
2 types of animation :
1. Explicit animations in Flutter are animations that developers control explicitly by specifying the animation behavior and properties.
2. Implicit animations : Here flutter controols the animation. Less control, less complexity -- uses pre built widgets as often as possible.
Note : the animation controller doesnt call the build method multiple times but instead it is like a timer which u listen to update manually the part of the UI. It will not call build method 60 frames per second it will just manaully update some part of the UI

U can listen and update part of the UI with the help of widget called AnimatedBuilder