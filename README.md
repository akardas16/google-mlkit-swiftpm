# Google MLKit SwiftPM Wrapper

This is experimental project for building MLKit in Swift Package Manager.

## Requirements

- iOS 15 and later
- Xcode 15 and later

## Installation

### Use Swift Package Manager to install

Add the package dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/akardas16/google-mlkit-swiftpm", from: "9.0.0")
]
```

> **Submitting to App Store?** The `9.0.0` zips embed Info.plist values like `1.0.0-beta16` for a few internal frameworks, which App Store Connect rejects. Pin the wrapper-only repackage instead:
>
> ```swift
> .package(url: "https://github.com/akardas16/google-mlkit-swiftpm", exact: "9.0.0-1")
> ```
>
> `9.0.0-1` is a SemVer pre-release of the same upstream MLKit `9.0.0` build with the Info.plist regression fixed. SwiftPM's `from: "9.0.0"` excludes pre-release tags, so existing consumers stay on `9.0.0`; AppStore-blocked consumers opt in via `exact:`.

Then add the specific ML Kit modules you need to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "MLKitTextRecognition", package: "google-mlkit-swiftpm"),
        .product(name: "MLKitLanguageID", package: "google-mlkit-swiftpm"),
        .product(name: "MLKitTranslate", package: "google-mlkit-swiftpm"),
        .product(name: "MLKitSmartReply", package: "google-mlkit-swiftpm"),
    ]
)
```

### Add Linker flags

Add these flags to `Other Linker Flags` in Build Settings of your Xcode projects.

- `-ObjC`
- `-all_load`

### Downloaded models at runtime

**Note**: The Translation and Smart Reply modules download their models at runtime on first use. Check the official [ML Kit documentation](https://developers.google.com/ml-kit) for specific requirements.

## Supported Features

This package supports the following Google ML Kit features:

### Vision APIs
- **Text Recognition** - Recognize Latin-script text in images (v2)

### Language APIs
- **Language Identification** - Identify the language of text
- **Translation** - Translate text between languages
- **Smart Reply** - Generate contextual reply suggestions

## Limitation

- Since pre-built MLKit binary missing `arm64` for iphonesimulator, this project enables to build in `arm64` for iphoneos and `x86_64` for iphonesimulator only.

## Example

Open `Example/Example.xcworkspace` and fixing code signing to yours.

## Automation

This repository includes automation tools for updating to new MLKit versions:

- **Automated Version Checking**: Daily checks for new MLKit releases via GitHub Actions
- **Build Automation**: Scripts to build and package new versions
- **GitHub Actions**: Workflows for automated builds and releases

For detailed information, see [AUTOMATION.md](AUTOMATION.md).

### Quick Start for Maintainers

To update to a new MLKit version:

```bash
# Check for updates
ruby scripts/check_mlkit_version.rb

# Build new version (replace with actual version)
./scripts/build_all.sh <version>
```

Or trigger the **Build MLKit XCFrameworks** workflow from the GitHub Actions tab.
