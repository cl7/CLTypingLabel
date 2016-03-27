//
//  ViewController.swift
//  CLTypingLabel
//
//  Created by Lin on 2/21/16.
//  Copyright © 2016 Chenglin. All rights reserved.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoLabel.charInterval = 0.1
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        // Text
        // demoLabel.text = "This is a demo of a typing label animation..."
        
        // Attributed Text
        let attr = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSStrokeColorAttributeName: UIColor.redColor(),
            NSStrokeWidthAttributeName: -3,
        ]
        
        demoLabel.attributedText = NSAttributedString(string: "This is a demo of an attributed text typing label animation...", attributes: attr)
    }

    @IBAction func stopTapped(sender: AnyObject) {
        demoLabel.pauseTyping()
    }
    @IBAction func continueTapped(sender: AnyObject) {
        demoLabel.continueTyping()
    }
    
    @IBAction func restartTapped(sender: AnyObject) {
        demoLabel.text = "This is a demo of a typing label animation..."
    }
}

