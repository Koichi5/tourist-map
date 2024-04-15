//
//  CityBasicInfoView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/30.
//

import SwiftUI

struct CityBasicInfoView: View {
    let prefecture: Prefecture?
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
                Text(prefecture?.capital ?? "")
            }
            HStack {
                HStack {
                    Image(systemName: "person.3")
                        .frame(width: 30, height: 30)
                        .padding()
                    Text("人口：")
                }
                Spacer()
                Text("\(prefecture?.population ?? 0)人")
            }
            HStack {
                HStack {
                    Image(systemName: "mountain.2")
                        .frame(width: 30, height: 30)
                        .padding()
                    Text("面積：")
                }
                Spacer()
                Text("\(prefecture?.area ?? 0) k㎡")
            }
            HStack {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 30, height: 30)
                        .padding()
                    Text("人口密度：")
                }
                Spacer()
                Text("\(prefecture?.population ?? 0 / (prefecture?.area ?? 0) ?? 0) 人 / k㎡")
            }
            Spacer()
        }
        .padding(30)
        .navigationTitle("基本情報")
    }
}
