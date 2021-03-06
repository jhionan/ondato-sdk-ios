# Ondato iOS SDK

## Table of contents

* [Overview](#overview)
* [Getting started](#getting-started)
* [Handling callbacks](#handling-callbacks)
* [Customising SDK](#customising-sdk)


## Overview

This SDK provides a drop-in set of screens and tools for iOS applications to allow capturing of identity documents and face photos/live videos for the purpose of identity verification. The SDK offers a number of benefits to help you create the best onboarding/identity verification experience for your customers:

- Carefully designed UI to guide your customers through the entire photo/video-capturing process
- Modular design to help you seamlessly integrate the photo/video-capturing process into your application flow
- Advanced image quality detection technology to ensure the quality of the captured images meets the requirement of the Ondato identity verification process, guaranteeing the best success rate
- Direct image upload to the Ondato service, to simplify integration\*

\* Note: the SDK is only responsible for capturing and uploading photos/videos. You still need to access the [Ondato API](https://documenter.getpostman.com/view/6997242/S1TZwaZe?version=latest) to create and manage checks.

## Important note

We recommend you to lock your app to a portrait orientation.

## Getting started

- SDK supports iOS 11.0
- SDK supports Swift 5
- SDK Xcode Version 12.1

### 1. App permissions

The Ondato SDK makes use of the device Camera. You will be required to have the `NSCameraUsageDescription` key in your application's `Info.plist` file:
```
<key>NSCameraUsageDescription</key>
<string>Required for document and facial capture</string>
```
### 2. Installation 

### CocoaPods

```
pod 'OndatoSDKiOS', :git => "git@github.com:ondato/ondato-sdk-ios.git", tag: '1.6.4'
```

### 3. Initializing and configuring the SDK 

#### Swift

```swift
// Use one of the provided initializers
OndatoService.shared.initialize(username: "username", password: "password")
OndatoService.shared.initialize(accessToken: "accessToken")
```

You can change the configuration by modifying the configuration property
```swift
var configuration: OndatoServiceConfiguration = OndatoService.shared.configuration
```

The configuration option has 3 properties
```swift
class OndatoServiceConfiguration {
	var appearance: OndatoAppearance
    var flowConfiguration: OndatoFlowConfiguration()
    var mode: OndatoEnvironment
}
```

`mode`  can be set to either test or live
```swift
enum OndatoEnvironment {
	case test
	case live
}
```

`flowConfiguration` holds several flow configuration options
```swift
class OndatoFlowConfiguration {
    var showSplashScreen: Bool // Should the splash screen be shown
    var showStartScreen: Bool // Should the start screen be shown
    var showConsentScreen: Bool // Should the consent screen be shown
    var showSelfieAndDocumentScreen // Should a selfie with document be requested when taking document pictures
    var showSuccessWindow: Bool // Should the success window be shown
    var ignoreLivenessErrors: Bool // Allows user to skip liveness check in case of failure
    var ignoreVerificationErrors: Bool // Allows user to skip document verification error result checks
    var recordProcess: Bool // Should the verification process be recorded
}
```

`appearance` holds the appearance configuration options
```swift
class OndatoAppearance {
    
    var logoImage: UIImage // Logo image that can be shown in the splash screen
    var progressColor: UIColor // background color of the `ProgressBarView` which guides the user through the flow
    var buttonColor: UIColor // background color of the primary action buttons
    var buttonTextColor: UIColor // background color of the primary action buttons text
    var errorColor: UIColor // background color of the error message background
    var errorTextColor: UIColor // background color of the error message text color
    var regularFontName: String // regular text font 
    var mediumFontName: String // medium text font
    var consentWindow: OndatoConsentAppearance() // appearance of header, body, acceptButton, declineButton in consent screen
```

### 4. Starting the flow

#### Swift


```swift
let sdk = OndatoService.shared.instantiateOndatoViewController()
sdk.modalPresentationStyle = .fullScreen
present(sdk, animated: true, completion: nil) 
```

## OndatoFlowDelegate

To handle result your view controller should implement `OndatoFlowDelegate` methods `onSuccess` and `onFailure` which contains `OndatoError` {`CANCELED`, `BAD_SERVER_RESPONSE`}:

```swift
OndatoService.shared.flowDelegate = T: OndatoFlowDelegate

func onSuccess(identificationId: String?) { // provided identificationId
    
}
func onFailure(identificationId: String?, error: OndatoError) { // provided identificationId
    
}
```

The delegate also has optional methods to replace Ondato windows/views with custom ones:

```swift
optional func viewControllerForStart(startPressed: @escaping () -> Void) -> UIViewController
optional func viewForSuccess(continue: @escaping () -> Void) -> UIView
optional func viewForLoading(progress: Float) -> UIView
```

### 4. Localization

Ondato iOS SDK already comes with out-of-the-box translations for the following locales:
- English (en) :uk:
- Lithuanian (lt) :lt:
- German (de) :de:

```swift
OndatoLocalizeHelper.language = OndatoLanguage.EN // OndatoLanguage.LT, OndatoLanguage.DE
```

To override liveness check strings, add a `.bundle` file which contains `Zoom.strings` table to your project and pass that bundle to the SDK
```swift
class OndatoService {
	var livenessLocalizationLT: Bundle?
	var livenessLocalizationEN: Bundle?
	var livenessLocalizationDE: Bundle?
}

if let bundleURL = Bundle.main.url(forResource: "LivenessLT", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
    OndatoService.shared.zoomLocalizationBundleLT = bundle
}
```

To override Ondato strings, add a `.strings` file to the project directory and pass the URL to that file to the SDK
```swift
class OndatoService {
	var ondatoLocalizationFileLT: URL?
	var ondatoLocalizationFileEN: URL?
	var ondatoLocalizationFileDE: URL?
}

if let fileURL = Bundle.main.url(forResource: "OndatoLT", withExtension: "strings") {
    OndatoService.shared.ondatoLocalizationFileLT = fileURL
}
```
