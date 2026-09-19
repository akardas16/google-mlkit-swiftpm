PROJECT_ROOT=$(cd $(dirname $0); cd ..; pwd)
PODS_ROOT="./Pods"
PODS_PROJECT="$(PODS_ROOT)/Pods.xcodeproj"
SYMROOT="$(PODS_ROOT)/Build"
IPHONEOS_DEPLOYMENT_TARGET = 12.0

bootstrap-cocoapods:
	@bundle install
	@bundle exec pod repo update
	@bundle exec pod install

bootstrap-builder:
	@git submodule update --init --recursive xcframework-maker
	@cd xcframework-maker && swift build -c release

build-cocoapods: bootstrap-cocoapods
	@xcodebuild -project "$(PODS_PROJECT)" \
	-sdk iphoneos \
	-configuration Release -alltargets \
  ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$(SYMROOT)" \
  CLANG_ENABLE_MODULE_DEBUGGING=NO \
	IPHONEOS_DEPLOYMENT_TARGET="$(IPHONEOS_DEPLOYMENT_TARGET)"
	@xcodebuild -project "$(PODS_PROJECT)" \
	-sdk iphonesimulator \
	-configuration Release -alltargets \
  ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$(SYMROOT)" \
  CLANG_ENABLE_MODULE_DEBUGGING=NO \
	IPHONEOS_DEPLOYMENT_TARGET="$(IPHONEOS_DEPLOYMENT_TARGET)"

prepare-info-plist:
	@cp -rf "./Resources/MLKitCommon-Info.plist" "./Pods/MLKitCommon/Frameworks/MLKitCommon.framework/Info.plist"
	@cp -rf "./Resources/MLImage-Info.plist" "./Pods/MLImage/Frameworks/MLImage.framework/Info.plist"
	@cp -rf "./Resources/MLKitVision-Info.plist" "./Pods/MLKitVision/Frameworks/MLKitVision.framework/Info.plist"
	@cp -rf "./Resources/MLKitTextRecognition-Info.plist" "./Pods/MLKitTextRecognition/Frameworks/MLKitTextRecognition.framework/Info.plist"
	@cp -rf "./Resources/MLKitTextRecognitionCommon-Info.plist" "./Pods/MLKitTextRecognitionCommon/Frameworks/MLKitTextRecognitionCommon.framework/Info.plist"
	@cp -rf "./Resources/MLKitLanguageID-Info.plist" "./Pods/MLKitLanguageID/Frameworks/MLKitLanguageID.framework/Info.plist"
	@cp -rf "./Resources/MLKitTranslate-Info.plist" "./Pods/MLKitTranslate/Frameworks/MLKitTranslate.framework/Info.plist"
	@cp -rf "./Resources/MLKitSmartReply-Info.plist" "./Pods/MLKitSmartReply/Frameworks/MLKitSmartReply.framework/Info.plist"
	@cp -rf "./Resources/MLKitNaturalLanguage-Info.plist" "./Pods/MLKitNaturalLanguage/Frameworks/MLKitNaturalLanguage.framework/Info.plist"
create-xcframework: bootstrap-builder build-cocoapods prepare-info-plist
	@rm -rf GoogleMLKit
	@xcodebuild -create-xcframework \
		-framework Pods/Pods/Build/Release-iphonesimulator/GoogleToolboxForMac/GoogleToolboxForMac.framework \
		-framework Pods/Pods/Build/Release-iphoneos/GoogleToolboxForMac/GoogleToolboxForMac.framework \
		-output GoogleMLKit/GoogleToolboxForMac.xcframework
	@xcodebuild -create-xcframework \
		-framework Pods/Pods/Build/Release-iphonesimulator/SSZipArchive/SSZipArchive.framework \
		-framework Pods/Pods/Build/Release-iphoneos/SSZipArchive/SSZipArchive.framework \
		-output GoogleMLKit/SSZipArchive.xcframework
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitNaturalLanguage/Frameworks/MLKitNaturalLanguage.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitCommon/Frameworks/MLKitCommon.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLImage/Frameworks/MLImage.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitVision/Frameworks/MLKitVision.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitTextRecognitionCommon/Frameworks/MLKitTextRecognitionCommon.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitTextRecognition/Frameworks/MLKitTextRecognition.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitLanguageID/Frameworks/MLKitLanguageID.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitTranslate/Frameworks/MLKitTranslate.framework \
	-output GoogleMLKit
	@xcframework-maker/.build/release/make-xcframework \
	-ios ./Pods/MLKitSmartReply/Frameworks/MLKitSmartReply.framework \
	-output GoogleMLKit

# MLKitTextRecognition (Latin) ships its OCR model as a resource bundle that
# cannot ride inside a SwiftPM binary target. Package it separately so it can be
# published as a release asset and added to consumer apps manually.
copy-resource-bundle: create-xcframework
	@rm -rf ./GoogleMLKit/LatinOCRResources.bundle
	@cp -rf "./Pods/MLKitTextRecognition/Resources/LatinOCRResources" "./GoogleMLKit/LatinOCRResources.bundle"

archive: copy-resource-bundle
	@cd ./GoogleMLKit/MLKitLanguageID.xcframework/ios-arm64/MLKitLanguageID.framework \
	 && mv MLKitLanguageID MLKitLanguageID.o \
	 && ar r MLKitLanguageID MLKitLanguageID.o \
	 && ranlib MLKitLanguageID \
	 && rm MLKitLanguageID.o
	@cd ./GoogleMLKit/MLKitLanguageID.xcframework/ios-x86_64-simulator/MLKitLanguageID.framework \
	 && mv MLKitLanguageID MLKitLanguageID.o \
	 && ar r MLKitLanguageID MLKitLanguageID.o \
	 && ranlib MLKitLanguageID \
	 && rm MLKitLanguageID.o
	@cd ./GoogleMLKit/MLKitTranslate.xcframework/ios-arm64/MLKitTranslate.framework \
	 && mv MLKitTranslate MLKitTranslate.o \
	 && ar r MLKitTranslate MLKitTranslate.o \
	 && ranlib MLKitTranslate \
	 && rm MLKitTranslate.o
	@cd ./GoogleMLKit/MLKitTranslate.xcframework/ios-x86_64-simulator/MLKitTranslate.framework \
	 && mv MLKitTranslate MLKitTranslate.o \
	 && ar r MLKitTranslate MLKitTranslate.o \
	 && ranlib MLKitTranslate \
	 && rm MLKitTranslate.o
	@cd ./GoogleMLKit/MLKitSmartReply.xcframework/ios-arm64/MLKitSmartReply.framework \
	 && mv MLKitSmartReply MLKitSmartReply.o \
	 && ar r MLKitSmartReply MLKitSmartReply.o \
	 && ranlib MLKitSmartReply \
	 && rm MLKitSmartReply.o
	@cd ./GoogleMLKit/MLKitSmartReply.xcframework/ios-x86_64-simulator/MLKitSmartReply.framework \
	 && mv MLKitSmartReply MLKitSmartReply.o \
	 && ar r MLKitSmartReply MLKitSmartReply.o \
	 && ranlib MLKitSmartReply \
	 && rm MLKitSmartReply.o
	@cd ./GoogleMLKit \
	 && zip -r MLKitLanguageID.xcframework.zip MLKitLanguageID.xcframework \
	 && zip -r MLKitTranslate.xcframework.zip MLKitTranslate.xcframework \
	 && zip -r MLKitSmartReply.xcframework.zip MLKitSmartReply.xcframework \
	 && zip -r MLKitTextRecognition.xcframework.zip MLKitTextRecognition.xcframework \
	 && zip -r MLKitTextRecognitionCommon.xcframework.zip MLKitTextRecognitionCommon.xcframework \
	 && zip -r MLImage.xcframework.zip MLImage.xcframework \
	 && zip -r MLKitVision.xcframework.zip MLKitVision.xcframework \
	 && zip -r GoogleToolboxForMac.xcframework.zip GoogleToolboxForMac.xcframework \
	 && zip -r SSZipArchive.xcframework.zip SSZipArchive.xcframework \
	 && zip -r MLKitNaturalLanguage.xcframework.zip MLKitNaturalLanguage.xcframework \
	 && zip -r MLKitCommon.xcframework.zip MLKitCommon.xcframework \
	 && zip -r LatinOCRResources.bundle.zip LatinOCRResources.bundle
.PHONY:
run: archive
