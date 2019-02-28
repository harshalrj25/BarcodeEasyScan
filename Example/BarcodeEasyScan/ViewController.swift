//
//  ViewController.swift
//  BarcodeEasyScan
//
//  Created by harshalrj25 on 02/28/2019.
//  Copyright (c) 2019 harshalrj25. All rights reserved.
//

import UIKit
import BarcodeEasyScan

class ViewController: UIViewController {
    @IBAction func buttonCLicked(){
        // Call this controller to open barcode screen
        let barcodeViewController =  BarcodeScannerViewController()
        barcodeViewController.delegate = self
        self.present(barcodeViewController, animated: true, completion: {
        })
    }
}

extension ViewController:ScanBarcodeDelegate
{
    func userDidScanWith(barcode: String) {
        // This method results the scanned barcode string
        let alert = UIAlertController(title: "THE BARCODE CONTAINS", message: "The scanned string is : \(barcode)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

