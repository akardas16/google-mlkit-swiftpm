# Google MLKit SwiftPM Wrapper

This is experimental project for building MLKit in Swift Package Manager.

## Requirements

- iOS 15 and later
- Xcode 15 and later

## Installation

### Use Swift Package Manager to install

Add the package dependency to your `Package.swift`, pinning the published release with `exact:`:

```swift
dependencies: [
    .package(url: "https://github.com/akardas16/google-mlkit-swiftpm", exact: "9.0.0-1")
]
```

> **Always pin `exact: "9.0.0-1"`.** `9.0.0-1` is the published release of this package (Google ML Kit `9.0.0` — Language APIs + Latin Text Recognition), with its XCFramework zips hosted on this repo's [Releases](https://github.com/akardas16/google-mlkit-swiftpm/releases). It is tagged as a SemVer *pre-release*, so a range rule such as `from: "9.0.0"` would **skip** it — use `exact:`. The build normalizes each framework's `CFBundleShortVersionString` to a numeric value, so the archives pass App Store Connect validation.

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

### Text Recognition resource bundle (required for `MLKitTextRecognition`)

The Latin Text Recognition OCR model ships as a resource bundle that **cannot** be embedded in a SwiftPM binary target. Without it, `TextRecognizer` crashes at runtime with:

```
MLKTextRecognizerInternalErrorCreationFailure ... reason: 'Invalid model path.'
```

To fix it, add the bundle to your app:

1. Download `LatinOCRResources.bundle.zip` from the [release](https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/LatinOCRResources.bundle.zip) and unzip it.
2. Drag `LatinOCRResources.bundle` into your Xcode project, check **Copy items if needed**, and make sure it's a member of your app target (it must land in *Copy Bundle Resources*).

That's the same manual-bundle step ML Kit requires for any of its model-backed features distributed outside CocoaPods.

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
