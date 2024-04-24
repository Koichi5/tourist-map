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
    @State private var path: [CityInfoDataModel] = []
    @State private var cityInfoDataModel: CityInfoDataModel?
    @State private var showRippleEffect = false
    @State private var rippleSize: CGFloat = 0
    @State private var rippleOpacity: Double = 0
    @State private var rippleActive = false  // 追加: アニメーションがアクティブかどうかを管理

    @ObservedObject var viewModel = CityInfoDataViewModel()
    @Query private var cityInfoDataModelList: [CityInfoDataModel]
    
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(AppState.self) private var appState
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Text(cityInfoDataModel?.prefecture?.kanji ?? "都市の情報が見つかりません")
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
                    if showRippleEffect {
                        Circle()
                            .fill(Color.white.opacity(rippleOpacity))
                            .frame(width: rippleSize, height: rippleSize)
                            .scaleEffect(showRippleEffect ? 1 : 0)
                            .opacity(2 - Double(rippleSize / geometry.size.width))
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .animation(.easeOut(duration: 2), value: rippleSize)
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Button {
                                dismissWindow(id: ViewIDs.cityView)
                            } label: {
                                Image(systemName: "xmark")
                            }
                            .padding(.top)
                            .padding(.trailing)
                            Spacer()
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
                .onAppear {
                    cityInfoDataModel = cityInfoDataModelList.first(where: { cityInfoDataModel in
                        cityInfoDataModel.name?.lowercased() == cityName.lowercased()
                    }) ?? CityInfoDataModel(imageName: "", name: "", prefecture: Prefecture.tokyo)
                }
                .onReceive(timer) { _ in
                    if !rippleActive { // アクティブでない時のみ実行
                        startRippleEffect(geometry: geometry, rippleDuration: 5)
                    }
                }
            }
        }
    }
    
    private func startRippleEffect(geometry: GeometryProxy, rippleDuration: Double) {
        self.showRippleEffect = true
        self.rippleOpacity = 0.2
        self.rippleSize = 0
        self.rippleActive = true
        withAnimation(.easeOut(duration: rippleDuration)) {
            self.rippleSize = geometry.size.width * 2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + rippleDuration) {
            self.showRippleEffect = false
            self.rippleOpacity = 0
            self.rippleActive = false
        }
    }
}
