//
//  TouristSpotDataViewModel.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/14.
//

import SwiftUI
import SwiftData

class TouristSpotDataViewModel: ObservableObject {
    @Environment(\.modelContext) private var context
    @Published var touristSpotDataModelList: [TouristSpotDataModel]
    
    init() {
        self.touristSpotDataModelList = []
    }
    
    func add(touristSpotDataModel: TouristSpotDataModel) {
        let data = TouristSpotDataModel(latitude: touristSpotDataModel.latitude ?? 0, longitude: touristSpotDataModel.longitude ?? 0, name: touristSpotDataModel.name ?? "", placeId: touristSpotDataModel.placeId ?? "", spotDescription: touristSpotDataModel.spotDescription ?? "", thumbnailImageUrl: touristSpotDataModel.thumbnailImageUrl ?? "")
        context.insert(data)
    }
    
    func delete(touristSpotDataModel: TouristSpotDataModel) {
        context.delete(touristSpotDataModel)
    }
}
