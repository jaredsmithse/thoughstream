//
//  KeywordTextStorage.swift
//  thoughtstream
//
//  Created by Jared Smith on 10/4/14.
//  Copyright (c) 2014 ThoughtStream. All rights reserved.
//

import UIKit

class KeywordTextStorage: NSTextStorage {
    var backingStore = NSMutableAttributedString()
    var keyPatterns = ["(@print)"]
    var textView: UITextView!
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var string: String {
        return backingStore.string
    }
    
    override func attributesAtIndex(index: Int, effectiveRange range: NSRangePointer) -> [NSObject : AnyObject] {
        return backingStore.attributesAtIndex(index, effectiveRange: range)
    }
    
    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        beginEditing()
        backingStore.replaceCharactersInRange(range, withString:str)
        edited(.EditedCharacters | .EditedAttributes, range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    override func setAttributes(attrs: [NSObject : AnyObject]!, range: NSRange) {
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.EditedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    func findAndReplaceTags() {
        var error: NSError? = nil
        
        var stringCopy = self.backingStore.string
        let cleanRegex = NSRegularExpression(pattern: "(\\|send\\| @)", options: nil, error: &error)
        let cleanString = cleanRegex.stringByReplacingMatchesInString(stringCopy, options: nil, range: NSMakeRange(0, countElements(stringCopy)), withTemplate: "@")
        self.setAttributedString(NSMutableAttributedString(string: cleanString))
        
        stringCopy = self.backingStore.string
        let newRegex = NSRegularExpression(pattern: "@", options: nil, error: &error)
        let subbedString = newRegex.stringByReplacingMatchesInString(stringCopy, options: nil, range: NSMakeRange(0, countElements(stringCopy)), withTemplate: "|send| @")
        self.setAttributedString(NSMutableAttributedString(string: subbedString))
        
        
        
        let normalAttrs = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        
        let linkAttributes: [NSObject: AnyObject]! = [ NSForegroundColorAttributeName:UIColor.redColor(), NSUnderlineColorAttributeName:UIColor.redColor(), NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.toRaw() ]
        

        
        
        let regex = NSRegularExpression(pattern: "(\\|send\\|)", options: nil, error: nil)
        regex.enumerateMatchesInString(backingStore.string, options: nil, range: NSMakeRange(0, countElements(stringCopy))) {
            match, flags, stop in
            // apply the style
            let matchRange = match.rangeAtIndex(1)
            self.addAttribute(NSLinkAttributeName, value: "flights://amadeus", range: matchRange)
            self.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleDouble.toRaw(), range: matchRange)
        
        }

        

        
        

        
    }
    
    
    override func processEditing() {
        findAndReplaceTags()
        
        textView.selectedRange = NSMakeRange(backingStore.length, 0)
        super.processEditing()
    }
    
    
    func update() {
        // may not need this
        // change the 'global' font
        let bodyFont = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        addAttributes(bodyFont, range: NSMakeRange(0, length))
    
    }
    
    

    
}
