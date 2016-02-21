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

@IBDesignable public class CLTypingLabel: UILabel

{

    @IBInspectable public var charInterval: Double = 0.1
    
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
        setTextWithTypeAnimation(newValue, characterInterval: Double(charInterval))
        }
    }
    
    private func setTextWithTypeAnimation(typedText: String, characterInterval: NSTimeInterval) {
        super.text = ""
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0))
            {
            for character in typedText.characters
                {
                dispatch_async(dispatch_get_main_queue())
                    {
                    super.text = super.text! + String(character)
                    self.sizeToFit()
                    }
                NSThread.sleepForTimeInterval(characterInterval)
            }
        }
    }
}
