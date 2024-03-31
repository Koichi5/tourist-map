//
//  DetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/28.
//

import SwiftUI

struct CityView: View {
    
    @State var cityName: String
    @State var showNightImage: Bool = false
    @State private var path: [CityInfo] = []
    
    @Environment(\.dismissWindow) private var dismissWindow
    
    var cityInfo: CityInfo? {
        cities.first { $0.name.lowercased() == cityName.lowercased() }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        if let cityInfo = cityInfo {
                            Text(cityInfo.name)
                                .font(.extraLargeTitle)
                                .bold()
                                .padding(.bottom, 150)
                        } else {
                            Text("都市の情報が見つかりません。")
                        }
                    }
                    .background {
                        if (showNightImage) {
                            cityInfo?.nightImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.width * 2/3)
                                .clipped()
                        } else {
                            cityInfo?.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.width * 2/3)
                                .clipped()                        }
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
                                    dismissWindow(id: ViewID.cityViewId)
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
                guard let cityInfo = cityInfo else {
                    fatalError("Failed to navigate to city detail view")
                }
                path.append(cityInfo)
            }
            .navigationDestination(for: CityInfo.self) { cityInfo in
                CityDetailView(cityInfo: cityInfo)
//                    .navigationTitle(cityInfo.name)
                    .navigationBarBackButtonHidden()
//                    .frame(width: 600, height: 400)
//                    .defaultSize(CGSize(width: 600, height: 400))
            }
        }
    }
}
