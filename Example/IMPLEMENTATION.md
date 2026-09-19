# ML Kit Demo App Implementation

## Overview
A SwiftUI-based demonstration app showcasing the ML Kit **Language APIs** plus Latin
**Text Recognition**, built following AGENTS.md guidelines for modern iOS development.

## Architecture

### Tech Stack
- **iOS Version**: 26.0+ (package products support iOS 15+)
- **Swift Version**: 6.2+
- **UI Framework**: SwiftUI with modern patterns
- **Concurrency**: async/await throughout
- **Navigation**: NavigationStack (not deprecated NavigationView)

### Project Structure
```
Example/Example/
├── MLKitDemoApp.swift              # App entry point (@main)
├── Resources/
│   └── Bundles/                    # Runtime resource bundles (Translate, Xeno, PredictOnDevice)
├── Views/
│   ├── MainMenuView.swift          # Main navigation menu
│   ├── Base/
│   │   ├── BaseDetectionView.swift # Reusable image-detection template
│   │   └── CameraView.swift        # Camera capture wrapper
│   ├── Vision/                     # 1 vision feature view
│   │   └── TextRecognitionView.swift
│   └── Language/                   # 3 language feature views
│       ├── LanguageIDView.swift
│       ├── TranslationView.swift
│       └── SmartReplyView.swift
```

## Features Implemented (4/4)

### Vision Features (1)

1. **Text Recognition** - Recognizes Latin-script text in images (sample: image_has_text)

### Language Features (3)

2. **Language Identification**
   - Text input with sample texts in 7 languages
   - Shows detected language code and confidence

3. **Translation**
   - 6 languages: English, Japanese, Chinese, Korean, Spanish, French
   - Source/target language pickers
   - Automatic model download

4. **Smart Reply**
   - Conversation interface
   - Generates contextual reply suggestions
   - Add messages and select suggested replies

## AGENTS.md Compliance

✅ **2-space indentation** (not tabs)
✅ **NavigationStack** instead of deprecated NavigationView
✅ **foregroundStyle()** instead of foregroundColor()
✅ **clipShape(.rect(cornerRadius:))** instead of cornerRadius()
✅ **Modern number formatting**: `.percent`, `.number.precision()` instead of String(format:)
✅ **onChange(of:) 2-parameter version**: `onChange(of:) { old, new in }`
✅ **async/await** throughout, no GCD
✅ **#Preview** with NavigationStack

## Testing Checklist

### On Physical Device
Vision Features:
- [ ] Text Recognition with sample image and camera

Language Features:
- [ ] Language ID with various inputs
- [ ] Translation with model download
- [ ] Smart Reply conversation flow

## Known Considerations

1. **Translation**: First use requires model download (network recommended)
2. **Smart Reply**: Downloads its on-device model at runtime

## Development Notes

### App Entry Point
`MLKitDemoApp.swift` is the single source of truth with `@main` attribute.

### Code Style
All code follows Swift 6.2 conventions:
- Strict concurrency
- MainActor where needed
- No force unwraps
- Proper error handling
- Modern SwiftUI patterns
