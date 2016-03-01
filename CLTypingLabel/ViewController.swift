//
//  ViewController.swift
//  CLTypingLabel
//
//  Created by Lin on 2/21/16.
//  Copyright © 2016 Chenglin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoLabel.charInterval = 0.1
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        demoLabel.text = "This is a demo of a typing label animation..."
    }

    @IBAction func stopTapped(sender: AnyObject) {
        demoLabel.stopTyping()
    }
    @IBAction func continueTapped(sender: AnyObject) {
        demoLabel.continueTyping()  
    }
    
    @IBAction func restartTapped(sender: AnyObject) {
        demoLabel.text = "This is a demo of a typing label animation..."
    }
}

