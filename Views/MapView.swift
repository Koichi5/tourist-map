//
//  MapView.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/26.
//

import SwiftUI
import SwiftData
import RealityKit

struct MapView: View {
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) internal var dismiss
    @Environment(\.openWindow) internal var openWindow
    @Environment(\.modelContext) private var context
    
    @Query private var cityInfoDataModelList: [CityInfoDataModel]
    @ObservedObject var viewModel = CityInfoDataViewModel()
    @State var searchText = ""
    @State private var isSearchFieldShown = false
    
    enum AttachmentIDs: Int {
        case editMenu = 100
    }
    var body: some View {
        ZStack(alignment: .topLeading) {
            RealityView { content, attachments in
                content.add(appState.root)
            }
        attachments: {
            Attachment(id: AttachmentIDs.editMenu) {
                Text("Edit Attachment")
            }
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    self.onPinTap(value: value)
                }
        )
            if(isSearchFieldShown) {
                TextField("都道府県名", text: $searchText)
                    .padding(.top, 50)
                    .padding(.leading, 50)
                    .onChange(of: searchText) {
                        appState.updateEntityVisibility(for: searchText)
                    }
            }
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            Button {
                isSearchFieldShown.toggle()
                appState.updateEntityVisibility(for: "")
            } label: {
                isSearchFieldShown ? HStack {
                    Image(systemName: "xmark")
                    Text("やめる")
                } :
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("検索")
                }
            }
        }
        .onAppear {
            if (cityInfoDataModelList.isEmpty) {
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "tokyo",
                        name: "Tokyo",
                        prefecture: Prefecture.tokyo
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.710004,
                            longitude: 139.795121,
                            name: "雷門",
                            placeId: "ChIJ0YwG28aOGGARvRKAXIBWqNk",
                            spotDescription: "東京の下町と言えば浅草。浅草寺の表参道である仲見世通りは、雷門から宝蔵門まで長さ約250mあると言われています。浅草にはそば・天ぷら・もんじゃ焼きにすき焼き…どぜう料理に洋食など、一日では食べきれないほどたくさんの老舗専門店が並んでいます。おみやげにも最適な、ビー玉、けん玉、おはじきなど伝統的なおもちゃや民芸品、風鈴や扇子など、雑貨巡りも楽しめます。現存する日本最古の遊園地「浅草花やしき」も人気です。古き良き江戸の賑わいを心ゆくまで堪能したいなら、まずは浅草に訪れて間違いはないでしょう。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 35.710015,
                            longitude: 139.810730,
                            name: "東京スカイツリー",
                            placeId: "ChIJ35ov0dCOGGARKvdDH7NPHX0",
                            spotDescription: "高さ634mを誇る自立式電波塔、「東京スカイツリー」。地上350mの天望デッキからは東京の景色が堪能できることはもちろん、富士山を見られることもあります。そのふもとには300以上の店舗が入る商業施設「東京ソラマチ」があり、国内外の観光客が多く訪れています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 35.715795,
                            longitude: 139.770150,
                            name: "上野動物園",
                            placeId: "ChIJf2129yiMGGAR9I6Yoe-1uHY",
                            spotDescription: "「上野動物園」は、1882年に開園した、日本で最も歴史の長い動物園です。日中国交回復を記念し、1972年に日本で初めて中国からジャイアントパンダを受け入れた動物園でもあり、現在もパンダは園の人気者です。2020年9月には、園内の東園にあるパンダ舎とは別に、西園でもパンダが見られる「パンダのもり」ができました。ほかの動物たちも、生息地を再現した環境で展示されており、水中を泳ぐホッキョクグマや冬眠中のクマも見られます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        )
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "osaka",
                        name: "Osaka",
                        prefecture: Prefecture.osaka
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.687234,
                            longitude: 135.525842,
                            name: "大阪城",
                            placeId: "ChIJ_TooXM3gAGARQR6hXH3QAQ8",
                            spotDescription: "天正 11 年 (1583 年) に豊臣秀吉が天下統一を目指して築城した大阪城は、大阪のシンボルともいえるランドマーク。広大な敷地には、大阪城天守閣をはじめ、金明水井戸屋形、金蔵、焔硝蔵、大手門など国の重要文化財に指定された歴史的な遺構が数多く残されています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 34.666129,
                            longitude: 135.432120,
                            name: "ユニバーサル・スタジオ・ジャパン",
                            placeId: "ChIJXeLVg9DgAGARqlIyMCX-BTY",
                            spotDescription: "ユニバーサル・スタジオ・ジャパンは、スティーヴン・スピルバーグがクリエイティブ総監督を務めたダイナミックな世界観が人気のテーマパーク。盛りだくさんのアトラクションやライド、ショーに、小さな子供から大人まで誰でも夢中になるはず。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 34.652490,
                            longitude: 135.506263,
                            name: "通天閣",
                            placeId: "ChIJ_0Lgd2DnAGARV0X03lbPy-U",
                            spotDescription: "浪速区の歓楽街「新世界」にそびえ立つ通天閣は、エネルギッシュな大阪の下町を象徴する存在です。高さ103メートルの通天閣にある展望台からは、大阪の街を一望することができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        )
                    ],
                    context: context
                )
            }
        }
    }
}

#Preview {
    MapView()
}
