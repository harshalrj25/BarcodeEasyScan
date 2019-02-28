//
//  BarcodeScannerViewController.swift
//  barcodeScanner
//  Created by Harshal Jadhav on 27/02/19.
//  Copyright © 2019 Harshal Jadhav. All rights reserved.
//
import UIKit
import AVFoundation

public protocol ScanBarcodeDelegate {
    func userDidScanWith(barcode: String)
}

public class BarcodeScannerViewController: UIViewController {
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    public var delegate: ScanBarcodeDelegate? = nil
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var qrCodeFrameView: UIView?
    private var scanlineRect = CGRect.zero
    private var scanlineStartY: CGFloat = 0
    private var scanlineStopY: CGFloat = 0
    private var topBottomMargin: CGFloat = 80
    private var scanLine: UIView = UIView()
    private lazy var topbar : UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var messageLabel : UILabel! = {
        let view = UILabel()
        view.text = "SCANNING.."
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var headerLabel : UILabel! = {
        let view = UILabel()
        view.text = "BARCODE SCAN"
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var cancelButton: UIButton! = {
        let view = UIButton()
        view.setTitle("Cancel", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(BarcodeScannerViewController.playButtonClicked), for: .touchUpInside)
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setConnstraintsForControls()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        // Get the back-facing camera for capturing videos
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            if captureSession.inputs.isEmpty {
                captureSession.addInput(input)
            }
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            if captureSession.outputs.isEmpty {
                captureSession.addOutput(captureMetadataOutput)
            }
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        // Start video capture.
        captureSession.startRunning()
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            self.view.addSubview(qrCodeFrameView)
            self.view.bringSubviewToFront(qrCodeFrameView)
            self.view.bringSubviewToFront(topbar)
            self.view.bringSubviewToFront(messageLabel)
            self.view.bringSubviewToFront(headerLabel)
            self.view.bringSubviewToFront(cancelButton)
        }
        self.drawLine()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.moveVertically()
    }
    
    private func setConnstraintsForControls() {
        self.view.addSubview(messageLabel)
        self.view.addSubview(topbar)
        self.view.addSubview(cancelButton)
        self.view.addSubview(headerLabel)
        
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:0).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:0).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        topbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:0).isActive = true
        topbar.topAnchor.constraint(equalTo: view.topAnchor, constant:0).isActive = true
        topbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true
        topbar.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        headerLabel.leadingAnchor.constraint(equalTo: topbar.leadingAnchor, constant:0).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: topbar.centerYAnchor, constant:0).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: topbar.trailingAnchor, constant:0).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerYAnchor.constraint(equalTo: topbar.centerYAnchor, constant:0).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:10).isActive = true
    }
    
    @objc private func playButtonClicked() {
        if #available(iOS 10.0, *) {
            self.dismiss(animated: true) {
            }
        } else {
            self.dismiss(animated: true) {
            }
        }
    }
    
    private func drawLine() {
        self.view.addSubview(scanLine)
        scanLine.backgroundColor = UIColor(red: 0.4, green: 0.8, blue: 0.4, alpha: 1.0) // green color
        scanlineRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 2)
        scanlineStartY = topBottomMargin
        scanlineStopY = self.view.frame.size.height - topBottomMargin
    }
    
    private func moveVertically() {
        scanLine.frame  = scanlineRect
        scanLine.center = CGPoint(x: scanLine.center.x, y: scanlineStartY)
        scanLine.isHidden = false
        weak var weakSelf = scanLine
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .beginFromCurrentState], animations: {() -> Void in
            weakSelf!.center = CGPoint(x: weakSelf!.center.x, y: self.scanlineStopY)
        }, completion: nil)
    }
    
    // MARK: - Helper methods
    private func launchApp(decodedURL: String) {
        if presentedViewController != nil {
            return
        }
        if self.delegate != nil {
            self.dismiss(animated: true, completion: {
                self.delegate?.userDidScanWith(barcode: decodedURL)
            })
        }
    }
}

extension BarcodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!)
                messageLabel.text = metadataObj.stringValue
            }
        }
    }
}

