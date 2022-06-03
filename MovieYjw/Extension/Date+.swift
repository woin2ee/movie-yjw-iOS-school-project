//
//  Date+.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/03.
//

import Foundation

extension Date {
    func toStringPrevDay(by format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: self) else {
            return nil
        }
        
        return formatter.string(from: yesterday)
    }
}
