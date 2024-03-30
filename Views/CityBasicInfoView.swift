//
//  CityBasicInfoView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/30.
//

import SwiftUI

struct CityBasicInfoView: View {
    let basicInfo: BasicInfo
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "pin")
                        .frame(width: 30, height: 30)
                        .padding()
                    Text("県庁所在地：")
                }
                Spacer()
                Text(basicInfo.capitalLocation)
            }
            HStack {
                HStack {
                    Image(systemName: "person.3")
                        .frame(width: 30, height: 30)
                        .padding()
                    Text("人口：")
                }
                Spacer()
                Text("\(basicInfo.population)人")
            }
            HStack {
                HStack {
                    Image(systemName: "mountain.2")
                        .frame(width: 30, height: 30)
                        .padding()
                    Text("面積：")
                }
                Spacer()
                Text("\(basicInfo.area) k㎡")
            }
            Spacer()
        }
        .padding()
    }
}
