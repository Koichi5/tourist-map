//
//  SwiftDataSampleView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/04/14.
//

import SwiftUI
import SwiftData

struct SwiftDataSampleView: View {
    @ObservedObject var viewModel = CityInfoDataViewModel()
    @Environment(\.modelContext) private var context
    @Query private var cityInfoDataModelList: [CityInfoDataModel]
//    osaka only filter
//    @Query(filter: #Predicate<CityInfoDataModel> { $0.name == "osaka" }) private var cityInfoDataModelList: [CityInfoDataModel]
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "sample-image",
                        name: "tokyo",
                        prefecture: Prefecture.tokyo
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 10,
                            longitude: 20,
                            name: "first tokyo spot name",
                            placeId: "place id for tokyo",
                            spotDescription: "spot description",
                            thumbnailImageUrl: "path"
                        ),
                        TouristSpotDataModel(
                            latitude: 10,
                            longitude: 20,
                            name: "second tokyo spot name",
                            placeId: "place id for tokyo",
                            spotDescription: "spot description",
                            thumbnailImageUrl: "path"
                        ),
                        TouristSpotDataModel(
                            latitude: 10,
                            longitude: 20,
                            name: "third tokyo spot name",
                            placeId: "place id for tokyo",
                            spotDescription: "spot description",
                            thumbnailImageUrl: "path"
                        )
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "sample-image2",
                        name: "osaka",
                        prefecture: Prefecture.osaka
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 20,
                            longitude: 30,
                            name: "osaka spot name",
                            placeId: "place id for osaka",
                            spotDescription: "osaka spot description",
                            thumbnailImageUrl: "osaka path"
                        )],
                    context: context
                )
            }) {
                Text("add city info")
            }
            List {
                ForEach(cityInfoDataModelList) { cityInfoDataModel in
                    VStack {
                        Text(cityInfoDataModel.name ?? "")
                            .padding()
                        Text("都道府県名: \(cityInfoDataModel.prefecture?.rawValue ?? "")")
                        Text("tourist first spot name: \(cityInfoDataModel.touristSpots.first?.name ?? "")")
                        Text("tourist last spot name: \(cityInfoDataModel.touristSpots.last?.name ?? "")")
                        Text("tourist spot count: \(cityInfoDataModel.touristSpots.count)")
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        viewModel.delete(cityInfoDataModel: cityInfoDataModelList[index], context: context)
                    }
                })
            }
        }
    }
}

#Preview {
    SwiftDataSampleView()
}
