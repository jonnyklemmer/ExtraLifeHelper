# ExtraLifeHelper

[![Platform support](https://img.shields.io/badge/platform-osx-lightgrey.svg?style=flat-square)](https://github.com/jonnyklemmer/ExtraLifeHelper/blob/main/README)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/jonnyklemmer/ExtraLifeHelper/blob/main/LICENSE)

ExtraLifeHelper is a utility app built 

## Features
Planned:
- Parsing of DonorDrive CSV to track fulfillment notes from incentives
- Ability to add incentives to a randomized wheel


## Built with
Leverages [SwiftBundler](https://github.com/stackotter/swift-bundler) to generate a (eventually) cross-platform Swift app built with SPM.

### Setup
- Checkout project
- To leverage Xcode IDE `swift bundler generate-xcode-support`
- Open  `Package.swift` file
- Run via xcode or `swift bundler run`

## Dependencies
TBD - but probably:
- https://github.com/swiftcsv/SwiftCSV (or custom)
- https://github.com/DonorDrive/PublicAPI
