# BOND101 iOS

SwiftUI implementation of the BOND101 couples-journaling app designs from Figma.

## Requirements

- Xcode 16+ (iOS 17 deployment target)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

## Getting started

```bash
cd iOS
xcodegen generate
open BOND101.xcodeproj
```

Then build and run the `BOND101` scheme on an iPhone simulator.

For AI features, copy `Info.plist.example` to `Info.plist` and set `AnthropicAPIKey`, or pass `ANTHROPIC_API_KEY` in the scheme's environment variables.

## Structure

- `Sources/App.swift` — app entry; shows the Welcome screen until "Start Bonding" is tapped, then the main shell. Supports a `BOND101_SCREEN` env var (`deck`, `community`, `connections`, `entry`, `blue`, `new`) to jump straight to a screen for testing.
- `Sources/MainShellView.swift` — custom bottom tab bar (Community / Deck / Account) per the design.
- `Sources/Theme.swift` — color palette and font helpers (Plus Jakarta Sans, Bodoni Moda) taken from the Figma file.
- `Sources/Screens/` — one file per Figma frame:
  | Screen | Figma frame |
  |---|---|
  | `WelcomeView` | iPhone 16 - 1 (59:46) |
  | `DeckView` | Deck View - BOND101 (57:398) |
  | `CommunityView` | Community - BOND101 (57:200) |
  | `ConnectionsView` | Connections - BOND101 (57:118) |
  | `EntryDetailView` | Entry Detail - BOND101 (57:344) |
  | `BlueEntryDetailView` | Entry Detail - Blue / Jealousy (57:494) |
  | `NewEntryView` | New Entry (57:296) |
- `Resources/Fonts/` — bundled Google Fonts (Plus Jakarta Sans, Bodoni Moda) registered via `UIAppFonts`, scaled with Dynamic Type through `relativeTo:`.
- `Resources/Assets.xcassets` — images exported from the Figma file plus the app icon and blush `AccentColor`.

The eighth Figma link (59:643) is the iOS status bar component only — iOS renders that automatically, so it has no corresponding view.
