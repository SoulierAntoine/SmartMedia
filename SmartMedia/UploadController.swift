//
//  UploadController.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 27/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation
import UIKit

class UploadController : UIViewController {
    @IBOutlet weak var chooseImage: UIButton!
    @IBOutlet weak var send: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        chooseImage.setTitle(NSLocalizedString("CHOOSE_IMAGE", comment: ""), for: .normal)
        send.setTitle(NSLocalizedString("SEND", comment: ""), for: .normal)
    }
    
    @IBAction func clickOnChoose(_ sender: Any) {
    }
    
    @IBAction func clickOnSend(_ sender: Any) {
    }
    
    
}
