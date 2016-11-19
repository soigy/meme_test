//
//  ViewController.swift
//  meme_test
//
//  Created by takeru_miyahara on 2016/11/17.
//  Copyright © 2016年 takeru_miyahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MEMELibDelegate {
    
    let color:UIColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
    
    var blinkCount = 0
    var eyeMove = ""
    
    var timeLeft = 60
    var gemeTimer: Timer!

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
        setEyeMove(data: data)
    }
    
    func setBlinkCount() {
        blinkCount += 1
        textField.text = String(blinkCount)
        blinkCounterLabel.text = String(blinkCount)
    }
    
    func setEyeMove(data: MEMERealTimeData!) {
        if data.eyeMoveUp > 0 {
            eyeMoveText.text = "上: " + String(data.eyeMoveUp)
        }
        if data.eyeMoveDown > 0 {
            eyeMoveText.text = "下: " + String(data.eyeMoveDown)
        }
    }
    
    func countDown(tm: Timer) {
        timeLeft -= 1
        setTimeLabel()
        if timeLeft == 0 {
            gemeTimer.invalidate()
        }
    }
    
    func setTimeLabel() {
        timeLabel.text = String(timeLeft)
    }

    @IBAction func buttonTapHandler(_ sender: Any) {
        setTimeLabel()
        gemeTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.countDown),
            userInfo: nil,
            repeats: true
        )
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eyeMoveText: UITextField!
    @IBOutlet weak var blinkCounterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

