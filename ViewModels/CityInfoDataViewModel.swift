//
//  CityInfoDataViewModel.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/14.
//

import SwiftUI
import SwiftData

class CityInfoDataViewModel: ObservableObject {
    // MARK: Define ``@Query private var cityInfoDataModelList: [CityInfoDataModel]`` to fetch stored CityInfoDataModel list.
//    @Environment(\.modelContext) private var context
    @Published var cityInfoDataModelList: [CityInfoDataModel]
    
    init() {
        self.cityInfoDataModelList = []
    }
    
    func save(context:  ModelContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(
        cityInfoDataModel: CityInfoDataModel,
        touristSpots: [TouristSpotDataModel],
        context: ModelContext
    ) {
        let data = CityInfoDataModel(
            imageName: cityInfoDataModel.imageName ?? "",
            name: cityInfoDataModel.name ?? "",
            prefecture: cityInfoDataModel.prefecture ?? Prefecture.tokyo
        )
        data.touristSpots = touristSpots
        context.insert(data)
        save(context: context)
    }
    
    func delete(cityInfoDataModel: CityInfoDataModel, context: ModelContext) {
        context.delete(cityInfoDataModel)
        save(context: context)
    }
}
