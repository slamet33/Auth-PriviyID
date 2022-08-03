//
//  String+Extenstion.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import Foundation

extension String {
    func isValidNumber() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[0-9]*$", options: [])
        let range = regex?.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range?.length == self.count
    }
}
