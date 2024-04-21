//
//  StringExtension.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/21.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
