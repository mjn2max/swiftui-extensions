# SwiftUI-Extensions

[![Swift](https://img.shields.io/badge/Swift-5.x_6.x-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.7_5.8_5.9-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_macOS_watchOS_tvOS_visionOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_macOS_watchOS_tvOS_visionOS-Green?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

A collection of useful extensions, utilities, and custom modifiers for SwiftUI to streamline and enhance your iOS, macOS, watchOS, and tvOS development.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Requirements](#requirements)
- [Usage](#usage)
- [Component Libraries](#component-libraries)
- [Migration Guides](#migration-guides)
- [Communication](#communication)
- [Contributing](#contributing)
- [Open Radars](#open-radars)
- [FAQs](#faqs)
- [Credits](#credits)
- [Donations](#donations)
- [License](#license)

## Features

- **Custom Modifiers:** Simplify complex UI elements with reusable custom modifiers.
- **View Extensions:** Add common functionality to SwiftUI views like rounded borders, shadows, and more.
- **Utility Methods:** Helper functions to make SwiftUI coding more efficient.
- **Cross-Platform:** Works across all platforms supported by SwiftUI.
- **Thorough Documented:** Clear and concise code comments to explain functionality.

## Installation

### Swift Package Manager

To install using Swift Package Manager, add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/mjn2max/swiftui-extensions.git", from: "1.0.0")
]
```

Then import in your source files:

```swift
import SwiftUI-Extensions
```

### Manually

- Download or clone the repository.
- Copy the Sources/SwiftExtensions folder into your Xcode project.
- Use the extensions as you would any other Swift code.

## Requirements

| Platform    | Minimum Swift Version | Installation                                                         | Status           |
| ----------- | --------------------- | -------------------------------------------------------------------- | ---------------- |
| iOS 13.0+   | 5.0 / Xcode 15.x      | [Swift Package Manager](#swift-package-manager), [Manual](#manually) | Not Fully Tested |
| macOS 13.0+ | Latest Only           | [Swift Package Manager](#swift-package-manager)                      | Not Fully Tested |
| watchOS     | Latest Only           | [Swift Package Manager](#swift-package-manager)                      | Not Fully Tested |
| tvOS        | Latest Only           | [Swift Package Manager](#swift-package-manager)                      | Not Fully Tested |
| visionOS    | Latest Only           | [Swift Package Manager](#swift-package-manager)                      | Not Fully Tested |

## Usage

SwiftUI‑Extensions offers seamless "drop‑in"”" convenience — import and start using powerful view modifiers and utilities immediately:

**Example 1: Rounded Border & Shadow**

```swift
Text("Hello, SwiftUI Extensions!")
    .roundedBorder(cornerRadius: 8, color: .blue, lineWidth: 2)
    .shadowStyle()
```

**Example 2: Adaptive Padding**

```swift
VStack {
    Text("Padded Content")
}
.adaptivePadding()
```

**Example 3: Custom Color Opacity Utility**

```swift
let baseColor = Color.red
let faded = baseColor.withOpacity(0.5) // Utility extension for opacity adjustments
```

More examples can be found in the [Component Libraries](#component-libraries).

## Component Libraries

Here are some of the core components that will be included in this package:

`CardView.swift`

- _CardView:_ A reusable card container with rounded corners, shadows, and tap animation support—perfect for profile cards, list items, and dashboard tiles.
- _SlideOverCard (via DeckKit-inspired style):_ SwiftUI card sheet style for onboarding flows and quick popups.

`SheetView.swift`

- _BottomSheet:_ A versatile bottom sheet component that slides up from the bottom, configurable across 3 states (collapsed, partial, expanded) with drag-to-dismiss behavior.

`ListCard.swift`

- _ListCardContainer:_ Combines CardView styling with a header, thumbnail, and subtitle—ideal for list/grid UIs and feeds.

`AnimatedTabBar.swift`

- _AnimatedTabBar:_ Custom tab bar with animated icon transitions and theming options—boosts engagement in multi-section apps.

`OneTimeOnboarding.swift`

- _OnboardingCarousel:_ A guided onboarding component that supports swipeable multi-page flows with PageView transitions.

`LoadingSkeleton.swift`

- _SkeletonPlaceholder:_ A skeleton-loading view built with shimmering gradients, ready to mask content during loading states.

For a full, up-to-date list of components and previews, browse the [Sources directory](/Sources/).

The repository’s source folder structure is organized by category, aligned with the structure used in [Apple’s SwiftUI documentation](https://developer.apple.com/documentation/swiftui/).

## Migration Guides

Coming soon...

## Communication

- **Bugs & Feature Requests:** Please [open an issue](https://github.com/mjn2max/swiftui-extensions/issues) on GitHub.
- **Questions & Support:** Use the issue tracker for all questions, suggestions, and support requests.
- **Contact:** For all communication, please use the GitHub issue tracker to ensure transparency and faster responses.

## Contributing

Contributions are welcome! Please:

1. [Open an issue](https://github.com/mjn2max/swiftui-extensions/issues) or discussion to propose changes or extensions.
2. Fork the [repo](https://github.com/mjn2max/swiftui-extensions) and create your feature branch.
3. Add tests for new functionality.
4. Submit a pull request with a clear description.

All contributions must follow the [Code of Conduct](https://www.swift.org/code-of-conduct/).

## Open Radars

If you discover any Swift or Apple bugs that impact this project, please share the radar number and a brief description in this section to help other contributors stay informed.

## FAQs

**Q: Can I use only a subset of the extensions?**  
A: Yes! Just include the specific files you need.

**Q: Is this production ready?**  
A: Core extensions are stable, but some platforms are not fully tested. Use at your discretion and report any issues.

## Credits

Created and maintained by [mjn2max](https://github.com/mjn2max) and contributors. See the [Contributors](https://github.com/mjn2max/swiftui-extensions/graphs/contributors) page for a full list.

## Donations

If you find this useful, you can sponsor this project via [GitHub Sponsors](https://github.com/sponsors/mjn2max) or [Buy Me a Coffee](https://buymeacoffee.com/mjn2max). Your support helps maintain and improve SwiftUI-Extensions!

## License

This project is licensed under the MIT License. See [LICENSE](/LICENSE) for details.
