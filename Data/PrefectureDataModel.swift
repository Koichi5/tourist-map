//
//  PrefectureDataModel.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/14.
//
//

import Foundation
import SwiftData


@Model public class PrefectureDataModel {
    var code: Int32? = 0
    var name: String?
    var capital: String?
    var population: Int32? = 0
    var area: Int32? = 0
    public init() {

    }
}
