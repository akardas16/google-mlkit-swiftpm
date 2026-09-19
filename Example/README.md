# ML Kit Demo App

A SwiftUI demonstration of the ML Kit **Language APIs** plus Latin **Text Recognition** for iOS.

## Setup Instructions

### 1. Add SwiftPM Dependencies in Xcode

Open the project:

```bash
cd Example
open Example.xcworkspace
```

In Xcode:

1. Select the project in the Project Navigator
2. Go to "Package Dependencies" tab
3. The local `Package` folder (Example/Package/) provides the `Camera` library, which is already linked to the "Example" target
4. Build the project (⌘B) to download all dependencies

### 2. Source Layout

**Main App:**

- `MLKitDemoApp.swift` — main entry point
- `Views/MainMenuView.swift`
- `Views/Base/BaseDetectionView.swift` — reusable image-detection template
- `Views/Base/CameraView.swift` — camera capture wrapper

**Vision Views (1):**

- `Views/Vision/TextRecognitionView.swift`

**Language Views (3):**

- `Views/Language/LanguageIDView.swift`
- `Views/Language/TranslationView.swift`
- `Views/Language/SmartReplyView.swift`

Files are added automatically via Xcode's file-system-synchronized groups, so new
Swift files under `Example/` are picked up without editing the project file.

### 3. (Optional) Download ML Kit Resource Bundles

The Translation and Smart Reply modules download their models at runtime. The
sample resource bundles under `Example/Example/Resources/Bundles/` are already
included. To refresh them from a release, run from the project root:

```bash
./scripts/download_bundles.sh
```

### 4. Build and Run

- Select a physical iOS device (iOS 15.5+) or the simulator (Intel Mac)
- Build and run (⌘R)
- Test the language features

## Features

### Vision (1 feature)

✅ Text Recognition (Latin)

### Language (3 features)

✅ Language Identification
✅ Translation
✅ Smart Reply

## Architecture

- **SwiftUI** with modern iOS patterns
- **NavigationStack** for navigation
- **async/await** for concurrency
- **AGENTS.md** compliant code style

## Troubleshooting

### Translation "Model download failed"

- First use requires network access for model download
- Check network connection
- Allow background downloads in app

## Documentation

See `IMPLEMENTATION.md` for detailed architecture and implementation notes.
