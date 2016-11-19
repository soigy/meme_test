//
//  ViewController.swift
//  meme_test
//
//  Created by takeru_miyahara on 2016/11/17.
//  Copyright © 2016年 takeru_miyahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MEMELibDelegate {
    
    var blinkCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        MEMELib.sharedInstance().delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func memeAppAuthorized(_ status: MEMEStatus) {
        print("before: startScanningPeripherals")
        MEMELib.sharedInstance().startScanningPeripherals()
    }
    
    func memePeripheralFound(_ peripheral: CBPeripheral!, withDeviceAddress address: String!) {
        print("memePeripheralFound")
        MEMELib.sharedInstance().connect(peripheral)
    }
    
    func memePeripheralConnected(_ peripheral: CBPeripheral!) {
        print("aaaaaa")
        let status = MEMELib.sharedInstance().startDataReport()
        
        print(status)
    }
    
    func memeRealTimeModeDataReceived(_ data: MEMERealTimeData!) {
        print(data.description)
        if data.blinkSpeed != 0 {
            setBlinkCount()
        }
    }
    
    func setBlinkCount() {
        blinkCount += 1
        textField.text = String(blinkCount)
    }

    @IBAction func buttonTapHandler(_ sender: Any) {
        print(MEMELib.sharedInstance().startScanningPeripherals())
        textField.text = "tapped!";
    }
    @IBOutlet weak var textField: UITextField!
}

