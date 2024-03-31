//
//  TouristSpotDetailView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/31.
//

import SwiftUI

struct TouristSpotDetailView: View {
    let touristSpot: TouristSpot
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Image(touristSpot.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width * 0.5)
                        .clipped()
                    Spacer()
                    Text(touristSpot.description)
                        .padding()
                        .font(.system(size: calculateFontSize(forWidth: geometry.size.width)))
                }
            }
        }
            .navigationTitle(touristSpot.name)
    }
    
    // ウィンドウの幅に基づいてフォントサイズを計算する関数
    func calculateFontSize(forWidth width: CGFloat) -> CGFloat {
        let baseWidth: CGFloat = 600
        let baseFontSize: CGFloat = 20
        let scaleFactor = width / baseWidth
        return baseFontSize * scaleFactor
    }
}
