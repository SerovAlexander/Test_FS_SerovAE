//
//  StringExtension.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat

        let date: Date? = dateFormatter.date(from: self)
        return date
    }
}
