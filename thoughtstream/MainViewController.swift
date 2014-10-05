//
//  ViewController.swift
//  thoughtstream
//
//  Created by Jared Smith on 10/4/14.
//  Copyright (c) 2014 ThoughtStream. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextViewDelegate {

    var textView: UITextView!
    var textStorage: KeywordTextStorage!
//    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    
//    let hashTagKey = "HashTag"
//    let userNameKey = "UserName"
//    let normalKey = "NormalKey"
//    let wordType = "WordType"

    override func viewDidLoad() {
        super.viewDidLoad()
        createTextView()
    }

    @IBAction func buttonclick(sender: AnyObject) {
        textView.editable = !textView.editable
    }
    func createTextView() {
        // 1. Set dimensions for textview
        let newTextViewRect = view.bounds
        
        // 2. Create the layout manager
        textStorage = KeywordTextStorage()
        let layoutManager = NSLayoutManager()
        
        // 3. Create a text container
        let containerSize = CGSize(width: newTextViewRect.width, height: CGFloat.max)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        // 4. Create a UITextView
        textView = UITextView(frame: newTextViewRect, textContainer: container)
        textView.delegate = self
        view.addSubview(textView)
        
        // 5. Pass text view for cursor setting
        textStorage.textView = textView
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        println("got to the method")
        if (URL.scheme == "flights") {
            var userName = URL.host
            println("we got somewhere")
            return false
        }
        return true
    }

//    - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//    if ([[URL scheme] isEqualToString:@"username"]) {
//    NSString *username = [URL host];
//    // do something with this username
//    // ...
//    return NO;
//    }
//    return YES; // let the system open this URL
//    }
    

}



//    func attributedMessageFromMessage(message: String) -> NSAttributedString {
//        var messageWords = message.componentsSeparatedByString(" ")
//        var attributedMessage = NSMutableAttributedString(string: "")
//
//        for word in messageWords {
//            let firstChar = Array(word)[0]
//            var attributes: [NSObject:AnyObject]
//
//            if (firstChar == "@") {
//                attributes = [NSForegroundColorAttributeName: UIColor.redColor(), wordType: userNameKey, userNameKey: word.substringFromIndex(word.startIndex)]
//            } else if (firstChar == "#") {
//                attributes = [NSForegroundColorAttributeName: UIColor.purpleColor(), wordType: hashTagKey, hashTagKey: word.substringFromIndex(word.startIndex)]
//            } else {
//                attributes = [NSForegroundColorAttributeName: UIColor.blackColor(), wordType: normalKey]
//            }
//            var subString = NSAttributedString(string: NSString(string: word), attributes: attributes)
//            attributedMessage.appendAttributedString(subString)
//        }
//        return attributedMessage
//    }





//    @IBAction func messageTapped(recognizer:UITapGestureRecognizer) {
//        println("taps are happening")
//        var actionTextView: UITextView = recognizer.view as UITextView
//
//        let layoutManager: NSLayoutManager = actionTextView.layoutManager
//        let location: CGPoint = recognizer.locationInView(actionTextView)
//        location.x.distanceTo(textView.textContainerInset.left)
//        location.y.distanceTo(textView.textContainerInset.top)
////        location.x -= textView.textContainerInset.left
////        location.y -= textView.textContainerInset.top
//
//
//        var characterIndex: NSInteger = layoutManager.characterIndexForPoint(location, inTextContainer: actionTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//
//
//        if (characterIndex < textView.textStorage.length) {
//            var wordType : AnyObject? = actionTextView.attributedText.attribute("WordType", atIndex: characterIndex, effectiveRange: NSRangePointer())
//
//            if ((wordType?.isEqual("send")) != nil) {
//                println("GOTCHA")
////                var userName = actionTextView.attributedText.attribute("send", atIndex: characterIndex, effectiveRange: NSRangePointer)
////                self.openViewControllerForUserName(userName)
//
//            }
//        }
//    }


