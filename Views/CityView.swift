//
//  DetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/28.
//

import SwiftUI
import SwiftData

struct CityView: View {
    
    let cityName: String
    @State var showNightImage: Bool = false
    @State private var path: [CityInfoDataModel] = []
    @State private var cityInfoDataModel: CityInfoDataModel?
    
    @ObservedObject var viewModel = CityInfoDataViewModel()
    @Query private var cityInfoDataModelList: [CityInfoDataModel]
    
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(AppState.self) private var appState
    
    var cityInfo: CityInfo? {
        cities.first { $0.name.lowercased() == cityName.lowercased() }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Text(cityInfoDataModel?.prefecture?.nameInKanji() ?? "都市の情報が見つかりません")
                            .font(.extraLargeTitle)
                            .bold()
                            .padding(.bottom, 150)
                    }
                    .background {
                            Image(cityInfoDataModel?.imageName ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.width * 2/3)
                                .clipped()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                Button {
                                    showNightImage.toggle()
                                } label: {
                                    Image(systemName: showNightImage ? "moon" : "sun.max")
                                }
                                .padding(.top)
                                Button {
                                    dismissWindow(id: ViewID.cityView)
                                } label: {
                                    Image(systemName: "xmark")
                                }
                                .padding(.top)
                                .padding(.trailing)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .onTapGesture {
                guard let cityInfoDataModel = cityInfoDataModel else {
                    fatalError("Failed to navigate to city detail view")
                }
                path.append(cityInfoDataModel)
                appState.cityBasicInfo()
            }
            .navigationDestination(for: CityInfoDataModel.self) { cityInfoDataModel in
                CityDetailView(cityInfoDataModel: cityInfoDataModel)
                    .navigationBarBackButtonHidden()
            }
        }
        .onAppear {
            cityInfoDataModel = cityInfoDataModelList.first(where: { cityInfoDataModel in
                cityInfoDataModel.name?.lowercased() == cityName.lowercased()
            }) ?? CityInfoDataModel(imageName: "", name: "", prefecture: Prefecture.tokyo)
        }
    }
}
