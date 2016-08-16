# JMDynamicDeviceName

[![CI Status](http://img.shields.io/travis/Jerome Morissard/JMDynamicDeviceName.svg?style=flat)](https://travis-ci.org/Jerome Morissard/JMDynamicDeviceName)
[![Version](https://img.shields.io/cocoapods/v/JMDynamicDeviceName.svg?style=flat)](http://cocoapods.org/pods/JMDynamicDeviceName)
[![License](https://img.shields.io/cocoapods/l/JMDynamicDeviceName.svg?style=flat)](http://cocoapods.org/pods/JMDynamicDeviceName)
[![Platform](https://img.shields.io/cocoapods/p/JMDynamicDeviceName.svg?style=flat)](http://cocoapods.org/pods/JMDynamicDeviceName)

## Purpose

Keeping iOS devices names up-to-date in your application without updating your pods :)

## Installation

add the following line to your Podfile:

```ruby
pod "JMDynamicDeviceName"
```

## Usage

```swift
//To keep up-to-date your iOS device names 
JMDeviceName.checkForUpdate()

//To get the exact device name 
JMDeviceName.deviceName()

//To get the device family name
JMDeviceName.deviceFamilyName()

//for exemple, iPad Air exists in 3 versions (iPad4,1 iPad4,2 iPad4,3)
JMDeviceName.deviceName() -> iPad4,1 or iPad4,2 or iPad4,3/
"iPad4,1" -> iPad Air (WiFi)
"iPad4,2" -> iPad Air (Cellular)
"iPad4,3" -> iPad Air (China)

//it's more interesting to log family name
"iPad4,1" -> iPad Air
"iPad4,2" -> iPad Air
"iPad4,3" -> iPad Air
```


## Author

Jerome Morissard, morissardj@gmail.com

## License

JMDynamicDeviceName is available under the MIT license. See the LICENSE file for more info.
