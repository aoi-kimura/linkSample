//
//  String+URLs.swift
//  NSTextCheckingResultSample
//
//  Created by 木村葵 on 2021/03/07.
//

import Foundation

extension String {
    
    /**
     NSTextCheckingResultを使用したURL抽出
     */
    var urlsFromMatchs: [String] {
        let check = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let match = check.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return match.compactMap { (self as NSString).substring(with: $0.range) }
    }
    
    /**
     正規表現を使用したURL抽出
     */
    var urlsFromRegexs: [String] {
        let pattern = "(http://|https://){1}[0-9a-zA-Z\\.\\-/:!#$%&@=?_]+"
        let regex = try! NSRegularExpression(pattern:pattern, options:[])
        guard let range = self.range(of:self) else { return [] }
        return regex.matches(in:self, range:NSRange(range, in: self)).map { String(self[Range($0.range, in:self)!]) }
    }
}
