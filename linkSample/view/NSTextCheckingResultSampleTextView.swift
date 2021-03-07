//
//  NSTextCheckingResultSampleTextView.swift
//  NSTextCheckingResultSample
//
//  Created by 木村葵 on 2021/03/07.
//

import UIKit

class LinkSampleTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(delegate: UITextViewDelegate?) {
        self.bounces = false
        self.isEditable = false
        self.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.blue]
        self.delegate = delegate
        self.isUserInteractionEnabled = true
        self.isSelectable = true
        self.isScrollEnabled = false
    }
    
    func setText(text: String, urls: [String]) {
        self.text = text
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        let attributeString = NSMutableAttributedString(string:self.text,
                                                        attributes: attributes)
        urls.forEach { url in
            attributeString.addAttribute(.link,
                                          value: url,
                                          range: NSString(string: text).range(of: url))
        }
        self.attributedText = attributeString
    }
    
}
