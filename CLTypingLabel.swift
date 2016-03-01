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

/**
Set text at runtime to trigger type animation;
 
Set charInterval property for interval time between each character, default is 0.1;
 
Call pauseTyping() to pause animation;
 
Call conitinueTyping() to continue paused animation;
 
*/

@IBDesignable public class CLTypingLabel: UILabel

{
    /**
     Set interval time between each characters
     */
    @IBInspectable public var charInterval: Double = 0.1
    
    /**
     Set text immediately trigger animation
     */
    override public var text: String! {
        
    get
    {
        return super.text
    }
    set
    {
        if charInterval < 0
        {
            charInterval = -charInterval
        }
        stopped = false
        stoppedSubstring = String()
        over = false
        let val = newValue ?? ""
        setTextWithTypingAnimation(val, charInterval, true)
        }
    }
    
    private var stopped: Bool = false
    
    private var stoppedSubstring: String = String()
    
    private var over: Bool = false
    
    /**
    Stop typing animation
    */
    
    public func pauseTyping()
    {
        stopped = true
    }
    
    /**
     Continue typing animation
    */
    
    public func continueTyping()
    {
        guard self.over == false else
        {
            return
        }
        guard self.stopped == true else
        {
            return
        }
        stopped = false
        setTextWithTypingAnimation(self.stoppedSubstring, charInterval, false)
    }
    
    private func setTextWithTypingAnimation(typedText: String, _ charInterval: NSTimeInterval, _ initial: Bool)
    {
        if initial == true
        {
        super.text = ""
        }
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0))
            {
            for (index,char) in typedText.characters.enumerate()
                {
                    guard self.stopped == false else
                    {
                        self.stoppedSubstring = typedText.substringFromIndex(typedText.startIndex.advancedBy(index))
                        return
                    }
                dispatch_async(dispatch_get_main_queue())
                    {
                    super.text = super.text! + String(char)
                    self.sizeToFit()
                    }
                NSThread.sleepForTimeInterval(charInterval)
            }
            self.over = true
            self.stopped = false
        }
    }
}
