

<!-- PROJECT LOGO -->
<br />
<p align="center">

  <h3 align="center">OxeNetworking</h3>

  <p align="center">
    A networking layer abstraction from a Brazilian northeast child.
    <br />
  </p>
</p>

[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the project](#about-the-project)
  * [Features](#features)
* [Sample Projects](sample-projects)
* [Project Status](#project-status)
* [Installation](#installation)
  * [Swift Package Manager](#swift-package-manager)
  * [Cocoapods](#cocoapods)
* [Basic usage](#basic-usage)
* [Contributing](#contributing)
* [License](license)
  
<!-- ABOUT THE PROJECT -->
## About the project

Even though there are many great networking libraries across our community, you still have to develop your own networking layer around it, which might be great for customization in the long run but demands some good effort in the beginning. This project intends to assist you in both. It provides an out of the box networking layer that can still be well customized for your own needs, and since it was developed using [Moya](https://github.com/Moya/Moya), you may use it its features as well [Alamofire's](https://github.com/Alamofire/Alamofire).

<!-- Features -->
### Features

The features are the following:

* Moya and Alamofire features.
* Environment distinction.
* Interception and handling of requests and their results.
* Default implementations for response mapping.
* Filtering and mapping of errors.
* Common implementation for main protocol `Dispatcher`.
	* Using assisting protocols and defined as open, which allows you either to create your own implementations or inherit and override the existing one.
* Facilitated certificate pinning.
* Plenty of extensions.

## Sample projects

* [TheFeels](https://github.com/adrianodiasx93/TheFeels)
* [UDTM](https://github.com/adrianodiasx93/udtm)

## Project status

This project is actively under development and is being used as a framework in personal projects, as well in professional ones during our last job. Thus we consider it ready for production use.

## Installation

### Swift Package Manager

_Note: Instructions below are for using **SwiftPM** without the Xcode UI. It's the easiest to go to your Project Settings -> Swift Packages and add OxeNetworking from there._

To integrate using Apple's Swift package manager, without Xcode integration, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/adrianodiasx93/OxeNetworking.git", .upToNextMajor(from: "0.2.2"))
```

and then specify `"OxeNetworking"` as a dependency of the Target in which you wish to use OxeNetworking.
If you want to use RxSwift extensions, add `"RxOxeNetworking"` as your Target dependency respectively.
Here's an example `PackageDescription`:

```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/adrianodiasx93/OxeNetworking.git", .upToNextMajor(from: "0.2.2"))
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["RxOxeNetworking"])
    ]
)
```

### Cocoapods

For OxeNetworking, use the following entry in your Podfile:

```rb
pod 'OxeNetworking'

# or 

pod 'OxeNetworking/RxOxeNetworking'

# for using RxSwift extensions.

```

Then run `pod install`.

In any file you'd like to use OxeNetworking in, don't forget to
import the framework with `import OxeNetworking`.

## Basic usage

After [some setup](https://github.com/adrianodiasx93/TheFeels/blob/main/SETUP.md), using OxeNetworking is really simple. You can access an API like this:

```swift
dispatcher.call(endpoint: MyTarget.myCase) { result in
    switch result {
    case .success(let response):
    	// Moya.Response
    case .failure(let error):
    	// MoyaError
    }
}
```

OxeNetworking also allows you to map the response in different formats.

```swift
dispatcher.getResponse(from: TargetType) { Result<Response, Error> in } // Filtered error when failure // Filtered error when .failure
dispatcher.performRequest(from: TargetType) { (Result<Void, Error>) in }  // Ignoring response
dispatcher.getDecodable(Decodable.Protocol, from: TargetType) { (Result<Decodable, Error>) in } // Response mapped to Decodable
dispatcher.getJSON(from: TargetType) { (Result<Any, Error>) in } // Response mapped to dictionary
dispatcher.getSwiftyJSON(from: TargetType) { (Result<JSON, Error>) in } // Response mapped to SwityJSON.JSON
```

## Contributing

Hey! Do you like OxeNetworking? Awesome! We could actually really use your help!

Open source isn't just writing code. OxeNetworking could use your help with any of the
following:

- Finding (and reporting!) bugs.
- New feature suggestions.
- Answering questions on issues.
- Documentation improvements.
- Reviewing pull requests.
- Helping to manage issue priorities.
- Fixing bugs/new features.

If any of that sounds cool to you, send a pull request!

### Help us improve OxeNetworking documentation
Whether you’re a core member or a user trying it out for the first time, you can make a valuable contribution to OxeNetworking by improving the documentation. Help us by:

- sending us feedback about something you thought was confusing or simply missing
- suggesting better wording or ways of explaining certain topics
- sending us a pull request via GitHub

## License

Distributed under the MIT License. See [LICENSE](https://github.com/adrianodiasx93/OxeNetworking/blob/main/LICENSE) for more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=flat-square
[contributors-url]: https://github.com/adrianodiasx93/OxeNetworking/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=flat-square
[forks-url]: https://github.com/adrianodiasx93/OxeNetworking/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=flat-square
[stars-url]: https://github.com/adrianodiasx93/OxeNetworking/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=flat-square
[issues-url]: https://github.com/adrianodiasx93/OxeNetworking/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=flat-square
[license-url]: https://github.com/adrianodiasx93/OxeNetworking/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/adrianodsilva/
[product-screenshot]: images/screenshot.png
