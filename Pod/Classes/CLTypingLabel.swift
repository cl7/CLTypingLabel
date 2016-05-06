//
//  CLTypingLabel.swift
//  CLTypingLabel
//  The MIT License (MIT)
//  Copyright © 2016 Chenglin 2/21/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files
//  (the “Software”), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge,
//  publish, distribute, sublicense, and/or sell copies of the Software,
//  and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included
//  in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

/*
 Set text at runtime to trigger type animation;
 
 Set charInterval property for interval time between each character, default is 0.1;
 
 Call pauseTyping() to pause animation;
 
 Call conitinueTyping() to continue paused animation;
 */

enum CLTypingLabelKind {
    case Text
    case AttributedText
}

@IBDesignable public class CLTypingLabel: UILabel {
    /*
     Set interval time between each characters
     */
    @IBInspectable public var charInterval: Double = 0.1
    
    /*
     SizeToFit label after each character
     */
    @IBInspectable public var centerText: Bool = true
    
    private var currentTypingID: Int = 0
    private var kind: CLTypingLabelKind = .Text
    private var typingStopped: Bool = false
    private var typingOver: Bool = true
    private var stoppedSubstring: String = ""
    private var attributes: [String: AnyObject] = [:]
    
    override public var text: String! {
        get {
            return super.text
        }
        
        set {
            if charInterval < 0 {
                charInterval = -charInterval
            }
            
            currentTypingID += 1
            typingStopped = false
            typingOver = false
            stoppedSubstring = ""
            
            let val = newValue ?? ""
            setTextWithTypingAnimation(val, charInterval, true)
            
            kind = .Text
        }
    }
    
    override public var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        
        set {
            if charInterval < 0 {
                charInterval = -charInterval
            }
            
            currentTypingID += 1
            typingStopped = false
            typingOver = false
            stoppedSubstring = ""
            
            let val = newValue ?? NSAttributedString()
            attributes = newValue.attributesAtIndex(0, effectiveRange: nil)
            setAttributedTextWithTypingAnimation(val, charInterval, true, attributes)
            
            kind = .AttributedText
        }
    }
    
    // MARK: -
    // MARK: Stop Typing Animation
    
    public func pauseTyping() {
        typingStopped = true
    }
    
    // MARK: -
    // MARK: Continue Typing Animation
    
    public func continueTyping() {
        guard typingOver == false else {
            print("CLTypingLabel: Animation is already over")
            return
        }
        
        guard typingStopped == true else {
            print("CLTypingLabel: Animation is not stopped")
            return
        }
        
        typingStopped = false
        
        switch kind {
        case .Text:
            setTextWithTypingAnimation(stoppedSubstring, charInterval, false)
        case .AttributedText:
            let stoppedAttributedText = NSAttributedString(string: self.stoppedSubstring, attributes: attributes)
            setAttributedTextWithTypingAnimation(stoppedAttributedText, charInterval, false, attributes)
        }
    }
    
    // MARK: -
    // MARK: Set Text & Attributed Text
    
    private func setAttributedTextWithTypingAnimation(typedAttributedText: NSAttributedString, _ charInterval: NSTimeInterval, _ initial: Bool, _ attributes: Dictionary<String, AnyObject>) {
        if initial == true {
            super.attributedText = NSAttributedString()
        }
        
        let dispatchedTypingID = currentTypingID
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            for (index, char) in typedAttributedText.string.characters.enumerate() {
                guard self.currentTypingID == dispatchedTypingID else {
                    return
                }
                
                guard self.typingStopped == false else {
                    let position = typedAttributedText.string.startIndex.advancedBy(index)
                    self.stoppedSubstring = typedAttributedText.string.substringFromIndex(position)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    super.attributedText = NSAttributedString(string: super.attributedText!.string + String(char), attributes: attributes)
                    
                    if self.centerText == true {
                        self.sizeToFit()
                    }
                }
                
                NSThread.sleepForTimeInterval(charInterval)
            }
            
            self.typingOver = true
            self.typingStopped = false
        }
    }
    
    private func setTextWithTypingAnimation(typedText: String, _ charInterval: NSTimeInterval, _ initial: Bool) {
        if initial == true {
            super.text = ""
        }
        
        let dispatchedTypingID = currentTypingID
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            for (index, char) in typedText.characters.enumerate() {
                guard self.currentTypingID == dispatchedTypingID else {
                    return
                }
                
                guard self.typingStopped == false else {
                    let position = typedText.startIndex.advancedBy(index)
                    self.stoppedSubstring = typedText.substringFromIndex(position)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    super.text = super.text! + String(char)
                    
                    if self.centerText == true {
                        self.sizeToFit()
                    }
                }
                
                NSThread.sleepForTimeInterval(charInterval)
            }
            
            self.typingOver = true
            self.typingStopped = false
        }
    }
}