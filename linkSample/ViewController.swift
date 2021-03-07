//
//  ViewController.swift
//  linkSample
//
//  Created by 木村葵 on 2021/03/07.
//

import UIKit

enum TextStyle: Int {
    case space = 0
    case indention = 1
    case styleNone = 2
}

enum ExtractionStyle: Int {
    case textCheckingResult = 0
    case regex = 1
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textStyleControl: UISegmentedControl! {
        didSet {
            textStyleControl.addTarget(self, action: #selector(selectedTextStyle), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var extractionStyleControl: UISegmentedControl! {
        didSet {
            extractionStyleControl.addTarget(self, action: #selector(selectedExtractStyle), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var textView: LinkSampleTextView! {
        didSet {
            textView.initialize(delegate: self)
        }
    }
    
    private var textStyle: TextStyle = TextStyle.space {
        didSet {
            textView.setText(text: text, urls: urls)
        }
    }
    
    private var text: String {
        switch textStyle {
        case .space:
            return "https://www.amazon.co.jp/dp/B01NCX3W3O/ref=cm_sw_r_tw_dp_F1BW1TDRC8FN640QGAA0 です"
        case .indention:
            return "https://www.amazon.co.jp/dp/B01NCX3W3O/ref=cm_sw_r_tw_dp_F1BW1TDRC8FN640QGAA0\nです"
        case .styleNone:
            return "https://www.amazon.co.jp/dp/B01NCX3W3O/ref=cm_sw_r_tw_dp_F1BW1TDRC8FN640QGAA0です"
        }
    }
    
    private var extractionStyle: ExtractionStyle = ExtractionStyle.textCheckingResult {
        didSet {
            textView.setText(text: text, urls: urls)
        }
    }
    
    private var urls: [String] {
        switch extractionStyle {
        case .textCheckingResult:
            return text.urlsFromMatchs
        case .regex:
            return text.urlsFromRegexs
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textStyle = .space
        extractionStyle = .textCheckingResult
    }

}

/**
 segmentedControlイベント
 */
@objc extension ViewController {
    
    func selectedTextStyle(segcon: UISegmentedControl) {
        textStyle = TextStyle(rawValue: segcon.selectedSegmentIndex) ?? .space
    }
    
    func selectedExtractStyle(segcon: UISegmentedControl) {
        extractionStyle = ExtractionStyle(rawValue: segcon.selectedSegmentIndex) ?? .textCheckingResult
    }
}

extension ViewController: UITextViewDelegate {
    
    /**
     リンクを押した時の挙動
     */
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var frame = textView.frame
        frame.size.height = textView.contentSize.height
        textView.frame = frame
    }
}
