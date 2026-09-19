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
      checksum: "9a84b7e5a4198b6cfd36844dc797d1f70e69e6208d324e34a0d4fe0aa878ed87"),
    .binaryTarget(
      name: "GoogleToolboxForMac",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/GoogleToolboxForMac.xcframework.zip",
      checksum: "4afb855eb88dc14c59211b4f84c706975ffd5b3f15c2c089f206401bd984f752"),
    .binaryTarget(
      name: "MLKitLanguageID",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitLanguageID.xcframework.zip",
      checksum: "69f6459180b02c961f78f945687ac99d9cdc0230fae7387b77b44906331be9a8"),
    .binaryTarget(
      name: "MLKitTranslate",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTranslate.xcframework.zip",
      checksum: "ae42c44a112bd0a189444d976623aeb6b1779e34a8fae8b9fb29a463b427ded8"),
    .binaryTarget(
      name: "MLKitSmartReply",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitSmartReply.xcframework.zip",
      checksum: "b34b23622b177233eb8e00b2cfb89dbd805760bc539b1594db467171ca8445e4"),
    .binaryTarget(
      name: "MLKitNaturalLanguage",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitNaturalLanguage.xcframework.zip",
      checksum: "f0b8d9f57f7b920e44299dbcdbfa7cbdaf0eca01cb69091c3e7aa21801c12c7b"),
    .binaryTarget(
      name: "SSZipArchive",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/SSZipArchive.xcframework.zip",
      checksum: "c491279abcb055c093c7537d6828a76ed934144f9a1884465e686dd114a5b226"),
    .binaryTarget(
      name: "MLImage",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLImage.xcframework.zip",
      checksum: "7b32404045b06c92ef2fa2e69689a74df909c65735168e4038e5568fdd0fa533"),
    .binaryTarget(
      name: "MLKitVision",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitVision.xcframework.zip",
      checksum: "c3dc0e7dd583b33484225701412fe04aa9ad743237bcbfd395de096654da160e"),
    .binaryTarget(
      name: "MLKitTextRecognition",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTextRecognition.xcframework.zip",
      checksum: "7e4e1bfac4bcac7a05f0682d8b454f73d14e496a867308e1bb25a6850e797114"),
    .binaryTarget(
      name: "MLKitTextRecognitionCommon",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTextRecognitionCommon.xcframework.zip",
      checksum: "043589fd1d6743b43673e6bbeda729b3fbdafba042b29fb9186b1f7ea7896c58"),
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
