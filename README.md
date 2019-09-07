# BarcodeEasyScan  :loudspeaker:

[![CI Status](https://img.shields.io/travis/harshalrj25/BarcodeEasyScan.svg?style=flat)](https://travis-ci.org/harshalrj25/BarcodeEasyScan)
[![Version](https://img.shields.io/cocoapods/v/BarcodeEasyScan.svg?style=flat)](https://cocoapods.org/pods/BarcodeEasyScan)
[![License](https://img.shields.io/cocoapods/l/BarcodeEasyScan.svg?style=flat)](https://cocoapods.org/pods/BarcodeEasyScan)
[![Platform](https://img.shields.io/cocoapods/p/BarcodeEasyScan.svg?style=flat)](https://cocoapods.org/pods/BarcodeEasyScan)

Easily implement barcode scan with few lines. No boilerplate code, no xib, no storboards.

## Example :books:

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation :hourglass_flowing_sand:

BarcodeEasyScan is available through [CocoaPods](https://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage):

To Install for `CocoaPods` 

```ruby
pod 'BarcodeEasyScan'
```
Or Install for `Carthage` 

```ruby
github "devuzan/BarcodeEasyScan" "master"
```
![alt text](https://github.com/harshalrj25/MasterAssetsRepo/blob/master/barcode.gif "Barcode")

## Usage :bulb:

Import the pod inside your viewcontroller class.
```
import BarcodeEasyScan
```
You need to add the  ``` "Privacy - Camera usage description" ``` key to your app’s Info.plist

Present 'BarcodeScannerViewController' and assign its delegate to self.
```
// Call this controller to open barcode screen
let barcodeViewController =  BarcodeScannerViewController()
barcodeViewController.delegate = self
self.present(barcodeViewController, animated: true, completion: {
})
```
Use the 'ScanBarcodeDelegate' to implement userDidScanWith(barcode: String) method.
```
func userDidScanWith(barcode: String) {
// This method results the scanned barcode string
}
```

## Author :innocent:

My email id, harshalrj25@gmail.com

<table style="background-color:#F5F5DC">
<tr>
<td>
<img src="https://github.com/harshalrj25/MasterAssetsRepo/blob/master/myAvatar.jpg" width="180"/>

Harshal Jadhav

<p align="center">
<a href = "https://github.com/harshalrj25"><img src = "https://github.com/harshalrj25/MasterAssetsRepo/blob/master/gitHubLogo.png" width="32" height = "33"/></a>
<a href = "https://stackoverflow.com/users/7882093/harshal-jadhav?tab=profile"><img src = "https://github.com/harshalrj25/MasterAssetsRepo/blob/master/stackoverflow svg icon.svg" width="36" height="36"/></a>
<a href = "https://www.linkedin.com/in/harshal-jadhav-298ba416a/"><img src = "https://github.com/harshalrj25/MasterAssetsRepo/blob/master/linkedInLogo.svg" width="36" height="36"/></a>
</p>
</td>
</tr> 
</table>

## License


It's all your's :gift: 
