//
//  DetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/28.
//

import SwiftUI

struct DetailView: View {
    
    @State var cityName: String
    @State var showNightImage: Bool = false
    
    @Environment(\.dismissWindow) private var dismissWindow
    
    var cityInfo: CityInfo? {
        CitiesData.cities.first { $0.name.lowercased() == cityName.lowercased() }
    }
    
    var body: some View {
        ZStack {
            VStack {
                if let cityInfo = cityInfo {
                    Text(cityInfo.name)
                        .font(.extraLargeTitle)
                        .bold()
                        .padding(.bottom, 150)
    //                Text(cityInfo.description)
    //                    .padding()
                } else {
                    Text("都市の情報が見つかりません。")
                }
                
    //            Button("dismiss") {
    //                dismissWindow(id: ViewID.detailViewId)
    //            }
            }
            .background {
                if (showNightImage) {
                    cityInfo?.nightImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 600, height: 400)
                } else {
                    cityInfo?.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 600, height: 400)
                }
            }
            HStack {
                Spacer()
                VStack {
                    HStack {
                        Button {
                            showNightImage.toggle()
                        } label: {
                            Image(systemName: "moon")
                        }
                        .padding(.top)
                        Button {
                            dismissWindow(id: ViewID.detailViewId)
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
}
