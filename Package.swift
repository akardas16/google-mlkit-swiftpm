// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "GoogleMLKitSwiftPM",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "MLKitLanguageID",
      targets: ["MLKitLanguageID", "MLKitNaturalLanguage", "MLKitCommon", "GoogleToolboxForMac", "Common"]),
    .library(
      name: "MLKitTranslate",
      targets: ["MLKitTranslate", "SSZipArchive", "MLKitNaturalLanguage", "MLKitCommon", "GoogleToolboxForMac", "Common"]),
    .library(
      name: "MLKitSmartReply",
      targets: ["MLKitSmartReply", "MLKitLanguageID", "MLKitNaturalLanguage", "MLKitCommon", "GoogleToolboxForMac", "Common"]),
    .library(
      name: "MLKitTextRecognition",
      targets: ["MLKitTextRecognition", "MLKitTextRecognitionCommon", "MLImage", "MLKitVision", "Common"]),
  ],
  dependencies: [
    .package(url: "https://github.com/google/promises.git", exact: "2.4.1"),
    .package(url: "https://github.com/google/GoogleDataTransport.git", exact: "10.1.1"),
    .package(url: "https://github.com/google/GoogleUtilities.git", exact: "8.1.3"),
    .package(url: "https://github.com/google/gtm-session-fetcher.git", exact: "3.5.0"),
    .package(url: "https://github.com/firebase/nanopb.git", exact: "2.30910.0"),
  ],
  targets: [
    // For debugging
    // .binaryTarget(
    //   name: "MLKitCommon",
    //   path: "GoogleMLKit/MLKitCommon.xcframework"),
    // .binaryTarget(
    //   name: "GoogleToolboxForMac",
    //   path: "GoogleMLKit/GoogleToolboxForMac.xcframework"),
    // .binaryTarget(
    //   name: "MLKitLanguageID",
    //   path: "GoogleMLKit/MLKitLanguageID.xcframework"),
    // .binaryTarget(
    //   name: "MLKitTranslate",
    //   path: "GoogleMLKit/MLKitTranslate.xcframework"),
    // .binaryTarget(
    //   name: "MLKitSmartReply",
    //   path: "GoogleMLKit/MLKitSmartReply.xcframework"),
    // .binaryTarget(
    //   name: "MLImage",
    //   path: "GoogleMLKit/MLImage.xcframework"),
    // .binaryTarget(
    //   name: "MLKitVision",
    //   path: "GoogleMLKit/MLKitVision.xcframework"),
    // .binaryTarget(
    //   name: "MLKitTextRecognition",
    //   path: "GoogleMLKit/MLKitTextRecognition.xcframework"),
    // .binaryTarget(
    //   name: "MLKitTextRecognitionCommon",
    //   path: "GoogleMLKit/MLKitTextRecognitionCommon.xcframework"),

    .binaryTarget(
      name: "MLKitCommon",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitCommon.xcframework.zip",
      checksum: "0bdd21ce442688a1e115a985ee94b10f3c4b95d92469ae30bd629dcbd160fc30"),
    .binaryTarget(
      name: "GoogleToolboxForMac",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/GoogleToolboxForMac.xcframework.zip",
      checksum: "a3e849c61951130ba3bbb4131a424d45c2c17cd91a97bf99a1c71463c7f38ed4"),
    .binaryTarget(
      name: "MLKitLanguageID",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitLanguageID.xcframework.zip",
      checksum: "7353b120a98b3c20cac6fc0394737bfb66efa506f73282bad0f3c7274ec7ee2e"),
    .binaryTarget(
      name: "MLKitTranslate",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTranslate.xcframework.zip",
      checksum: "31590e1e87ee203ee932ef8bfdff768217e784fa36d613e99e0f70a6048134e7"),
    .binaryTarget(
      name: "MLKitSmartReply",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitSmartReply.xcframework.zip",
      checksum: "5b72a6c9ef44a02eca4de7c7bfbd89a87fca629be33638ebabf5d1108050ebe8"),
    .binaryTarget(
      name: "MLKitNaturalLanguage",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitNaturalLanguage.xcframework.zip",
      checksum: "a1963bb9616a518f7ca82917e6e816cfb10a9176921b90ce76821bf1c929ee9d"),
    .binaryTarget(
      name: "SSZipArchive",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/SSZipArchive.xcframework.zip",
      checksum: "3fa398dd062fa089fbf01ea0cd900d929e93d93d86ac1da349a274f647b7b6fe"),
    .binaryTarget(
      name: "MLImage",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLImage.xcframework.zip",
      checksum: "26c786e1d6876b9ada3bf451e2aeb4823ba74dd9b10b274a8a04b9d595b47269"),
    .binaryTarget(
      name: "MLKitVision",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitVision.xcframework.zip",
      checksum: "b03b9b162850d15615a3f8cf8eedab823a3bc977c381351b2c921f5446b9425e"),
    .binaryTarget(
      name: "MLKitTextRecognition",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTextRecognition.xcframework.zip",
      checksum: "5ae74653a21807763432de21ad5319dcf0b7b888eb127e3c919758fbc664b6ad"),
    .binaryTarget(
      name: "MLKitTextRecognitionCommon",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTextRecognitionCommon.xcframework.zip",
      checksum: "fe19552334aabafc915980876e69ccedb62464ef48ac4e1d07f0a9bc424405f0"),
    .target(
      name: "Common",
      dependencies: [
        "MLKitCommon",
        "GoogleToolboxForMac",
        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
        .product(name: "GULEnvironment", package: "GoogleUtilities"),
        .product(name: "GULLogger", package: "GoogleUtilities"),
        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
        .product(name: "GULNSData", package: "GoogleUtilities"),
        .product(name: "GULNetwork", package: "GoogleUtilities"),
        .product(name: "GULReachability", package: "GoogleUtilities"),
        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
        .product(name: "GTMSessionFetcher", package: "gtm-session-fetcher"),
        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
        .product(name: "nanopb", package: "nanopb"),
        .product(name: "FBLPromises", package: "promises"),
      ]),
  ]
)
