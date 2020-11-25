// ----------------------------------------------------------------------------
//
//  StringExtension.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// Add method to convert date from JSON
extension String {
  func toStringDate() -> String? {
    let dateFormatterInput = DateFormatter()
    let dateFormatterOutput = DateFormatter()
    dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatterOutput.dateFormat = "dd-MM-yyyy"
    dateFormatterOutput.locale = Locale(identifier: "ru_RU")
    dateFormatterOutput.dateStyle = .medium
    guard let date = dateFormatterInput.date(from: self) else { return "" }
    let stringDate = dateFormatterOutput.string(from: date)

    return stringDate
  }
}
