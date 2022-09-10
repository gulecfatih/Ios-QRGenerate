//
//  ViewController.swift
//  ictpdks
//
//  Created by Macintosh on 20.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ImageQr: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main){notification in
//            ImageQr.isHidden=true
//        }
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        QrGenarator()
        CreateTimer()
    }
  
  
    
    func CreateTimer(){
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector (QrCode), userInfo: nil, repeats: true)
        timer.tolerance=100
    }
    @objc  func QrCode(){
        
        QrGenarator()
    }
    func QrGenarator(){
       
        let filter = CIFilter(name: "CIQRCodeGenerator")
        let text = stringTextChange()
        let data = text.data(using:.ascii,allowLossyConversion: false)
        filter?.setValue("H", forKey:"inputCorrectionLevel")
        filter?.setValue(data , forKey: "inputMessage")
        let ciImage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        let transformImage = ciImage?.transformed(by: transform)
        let image1 = UIImage(ciImage: transformImage!)
        
        ImageQr.image = image1
        ImageQr.setNeedsDisplay()
        
    }
    
    func stringTextChange()-> String{
        let Persid = 31
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let minutes = calendar.component(.minute, from: date)
        let hour = calendar.component(.hour,from: date)
        let second = calendar.component(.second,from: date)
        let Deger = "PID"+String(Persid)+"D"+String(day)+"MN"+String(month)+"Y"+String(year)+"H"+String(hour)+"M"+String(minutes)+"S"+String(second)+"-"
        return Deger
    }
    


    
    
}

