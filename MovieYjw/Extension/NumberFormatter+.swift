//
//  NumberFormatter+.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/03.
//

import Foundation

extension NumberFormatter {
    func addComma(to num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: num)) ?? String(num)
    }
    
    func addComma(to num: String) -> String {
        let formatter = NumberFormatter()
        guard let nsNum = formatter.number(from: num) else { return num }
        formatter.numberStyle = .decimal
        return formatter.string(from: nsNum) ?? num
    }
}
