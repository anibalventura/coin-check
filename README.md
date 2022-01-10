# Coin Check

[![iOS](https://img.shields.io/static/v1?label=iOS&message=15.0&color=000000)](https://www.apple.com/ios/ios-15/)
[![Swift](https://img.shields.io/static/v1?label=Swift&message=5.5&color=F05138)](https://developer.apple.com/swift/)
[![Xcode](https://img.shields.io/static/v1?label=Xcode&message=13.2&color=147EFB)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/static/v1?label=License&message=MIT&color=blue)](LICENCE)

<p> <img src="repository_banner.png" align="center"/> </p>

Cryptocurrency price checker. The app fetch from [CoinAPI.io](https://www.coinapi.io/) the latest coin prices, build with UIKit and MVC + Delegate pattern.

## Features

- Select coin and currency from list.
- Last time price was updated.
- Splash screen.
- Light/Dark mode.
- Localization (English/Spanish).

## Development

- [UIKit](https://developer.apple.com/documentation/uikit)
- MVC + Delegate
- [CocoaPods](https://cocoapods.org)
- Development Target **15.0**
- Swift **5.5**
- Xcode **13.2**

### Dependencies

- [SwiftLint](https://cocoapods.org/pods/SwiftLint)

### Build

1. Go to [CoinAPI.io](https://www.coinapi.io/) an get a free API key.

2. In `.../CoinCheck/Network/CoinAPI.swift` change the following line with your key.
```swift
struct CoinAPI {
    static let key: String = "YOUR_API_KEY_HERE"
    static let baseURL: String = "https://rest.coinapi.io/v1/exchangerate"
}
```

3. Run the project!

# License

```xml
MIT License

Copyright (c) 2022 Anibal Ventura
```
