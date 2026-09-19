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
    .package(url: "https://github.com/google/promises.git", exact: "2.4.0"),
    .package(url: "https://github.com/google/GoogleDataTransport.git", exact: "10.1.0"),
    .package(url: "https://github.com/google/GoogleUtilities.git", exact: "8.1.0"),
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
      checksum: "0c3523adc6248b5fd7e71c5af1c3e028a2ffcd20ca6add03283e20a09740f43f"),
    .binaryTarget(
      name: "GoogleToolboxForMac",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/GoogleToolboxForMac.xcframework.zip",
      checksum: "c095707fd64bad2f36cd9bcc86251de6aab7197d5b35112f3cdf40c6c94a6b4b"),
    .binaryTarget(
      name: "MLKitLanguageID",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitLanguageID.xcframework.zip",
      checksum: "565a73c87c965959fc34ae989b7f97acb8134ad9cc25acd4a179f45d71b08a95"),
    .binaryTarget(
      name: "MLKitTranslate",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTranslate.xcframework.zip",
      checksum: "b08ce5354133185c5fc4f0e64dfda1e437c23f815734b40c08832ea8db4bcf11"),
    .binaryTarget(
      name: "MLKitSmartReply",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitSmartReply.xcframework.zip",
      checksum: "a1fe1e9c2ad5bde38bace6d64367cbdbed3a48d373e9493c8a91b907b637fda4"),
    .binaryTarget(
      name: "MLKitNaturalLanguage",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitNaturalLanguage.xcframework.zip",
      checksum: "55da788e46e3e2aa3e409da5a50db01c292a67ca84199039f81a46e80397d026"),
    .binaryTarget(
      name: "SSZipArchive",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/SSZipArchive.xcframework.zip",
      checksum: "5b179e6e8df6ef5d5b530e7d35e5e57503388db336a8050eca8e517e308a78be"),
    .binaryTarget(
      name: "MLImage",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLImage.xcframework.zip",
      checksum: "ed3a23f4f5bf4c1f461337311a29dd12a3d01676dd49ea06b9b21cab223159f5"),
    .binaryTarget(
      name: "MLKitVision",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitVision.xcframework.zip",
      checksum: "b26f8c96d1e12515b990fca0b2237d60363d7bddc925d5ec61d7ee7d8b5e83c3"),
    .binaryTarget(
      name: "MLKitTextRecognition",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTextRecognition.xcframework.zip",
      checksum: "1f20493b54611a251cae278fd9f206c3009eee3de7091e5e4f1cb1a050526f72"),
    .binaryTarget(
      name: "MLKitTextRecognitionCommon",
      url: "https://github.com/akardas16/google-mlkit-swiftpm/releases/download/9.0.0-1/MLKitTextRecognitionCommon.xcframework.zip",
      checksum: "9b6cbfd695e5458e5ccab905d2c6a641cd29fe60a6ec4fd8acb62ef9b8ac91e7"),
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
