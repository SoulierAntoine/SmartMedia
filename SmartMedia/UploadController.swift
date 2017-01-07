//
//  UploadController.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 27/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation
import UIKit

extension UploadController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Set the color of the text in the picker view
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: files[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    // Set the number of column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Set the number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return files.count
    }
    
    // Data returned for the row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return files[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.choosenFile = files[row]
    }
}

class UploadController : UIViewController {
    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var chooseSoundLabel: UILabel!
    @IBOutlet weak var filePicker: UIPickerView!
    @IBOutlet weak var noSound: UILabel!
    
    fileprivate var files:[String] = [String]()
    fileprivate var choosenFile:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad();
        noSound.isHidden = true
        noSound.text = "You don't have any sound yet !"

        // close.width = 40
        // close.height = 40
        
        chooseSoundLabel.text = NSLocalizedString("CHOOSE_SOUND", comment: "")
        send.setTitle(NSLocalizedString("SEND", comment: ""), for: .normal)
        
        self.filePicker.delegate = self
        self.filePicker.dataSource = self
        
        self.filePicker.tintColor = UIColor.white
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let appFolder = documentsDirectory.appendingPathComponent(Constants.APP_NAME);
        do {
            self.files = try FileManager.default.contentsOfDirectory(atPath: appFolder.path)
        } catch let error as NSError {
            print(error.description)
        }
        
        
        if (self.files.count > 0) {
            self.choosenFile = files[0]
        } else {
            filePicker.isHidden = true
            send.isHidden = true
            chooseSoundLabel.isHidden = true
            noSound.isHidden = false
        }
    }
    

    
    @IBAction func clickOnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clickOnSend(_ sender: Any) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let appFolder = documentsDirectory.appendingPathComponent(Constants.APP_NAME);
        
        let filePath = appFolder.appendingPathComponent(choosenFile)
        let boundary = generateBoundaryString()

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/audio/upload")!)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=smartMediaFile; filename=\(choosenFile))\r\n".data(using: .utf8)!)
        body.append("Content-Transfer-Encoding: 8bit\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(FileManager.default.contents(atPath: filePath.path)!)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if (error == nil) {
                    if (data == nil) {
                        print("error: no data was sent back from the server")
                    } else {
                        let responseString = String(data: data!, encoding: .utf8)
                        print("response: \(responseString)")
                    }
                } else {
                    print("error=\(error)")
                }
            })
        }.resume()
        
        dismiss(animated: true, completion: nil)
    }

    func generateBoundaryString() -> String {
        let UUID = UIDevice.current.identifierForVendor!.uuidString;
        
        return UUID;
    }
}
