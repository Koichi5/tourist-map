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
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "hokkaido",
                        name: "Hokkaido",
                        prefecture: Prefecture.hokkaido
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 43.061155,
                            longitude: 141.356424,
                            name: "札幌テレビ塔",
                            placeId: "ChIJjWSHX50pC18RMSAiw3gaBOI",
                            spotDescription: "さっぽろテレビ塔は北海道札幌市中央区大通西1丁目の大通公園内にある電波塔である。札幌市の中央にあり、総工費1億7000万円で1957年に完成し、同年8月24日に開業・電波の発射を開始した。高さ147.2メートル。設計者は内藤多仲。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "aomori",
                        name: "Aomori",
                        prefecture: Prefecture.aomori
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 40.607943,
                            longitude: 140.463660,
                            name: "弘前城",
                            placeId: "ChIJW01KG8QBm18R8M5txbKLSUk",
                            spotDescription: "弘前城は、青森県弘前市にある日本の城である。別名・鷹岡城、高岡城。江戸時代に建造された天守や櫓などが現存し国の重要文化財に指定されている。また城跡は国の史跡に指定されている。江戸時代には津軽氏が居城し弘前藩の藩庁が置かれた。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "akita",
                        name: "Akita",
                        prefecture: Prefecture.akita
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 39.727100,
                            longitude: 140.665281,
                            name: "田沢湖",
                            placeId: "ChIJjzSdMoKJj18RISzxuUubhMI",
                            spotDescription: "田沢湖は、秋田県仙北市にある淡水湖。一級河川雄物川水系に属する。日本で最も深い湖であり、日本で19番目に広い湖沼でもある。その全域が田沢湖抱返り県立自然公園に指定されており、日本百景にも選ばれている景勝地である。1956年から2005年まで存在した自治体である田沢湖町の名の由来であり、現在も旧田沢湖町の区域の地名冠称として使われている。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "iwate",
                        name: "Iwate",
                        prefecture: Prefecture.iwate
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 39.001337,
                            longitude: 141.099898,
                            name: "中尊寺金色堂",
                            placeId: "ChIJ5f8N8ubNiF8R0marjOV-5cQ",
                            spotDescription: "金色堂は中尊寺創建当初の姿を今に伝える建造物で1124年（天治元年）、奥州藤原氏初代清衡公によって上棟されました。数ある中尊寺の堂塔の中でもとりわけ意匠が凝らされ、極楽浄土の有様を具体的に表現しようとした清衡公の切実な願いによって、往時の工芸技術が集約された御堂です。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "yamagata",
                        name: "Yamagata",
                        prefecture: Prefecture.yamagata
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 38.569245,
                            longitude: 140.531035,
                            name: "銀山温泉",
                            placeId: "ChIJ7SNY19pdiV8RIRfQXnlYhtk",
                            spotDescription: "江戸時代の慶長年間に隆盛を極めた延沢銀山。その坑夫によって発見された温泉です。ここには大正時代の街並みが残っており、文化財級のノスタルジックな建物が軒を連ねる風景が見事",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
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
            }) {
                Text("add city info")
            }
            List {
                ForEach(cityInfoDataModelList) { cityInfoDataModel in
                    VStack {
                        Text(cityInfoDataModel.name ?? "")
                            .padding()
                        Text("都道府県名: \(cityInfoDataModel.prefecture?.rawValue ?? "")")
                        
                        Text("tourist first spot name: \(cityInfoDataModel.touristSpots[0].name ?? "")")
                        Text("tourist first spot description: \(cityInfoDataModel.touristSpots[0].spotDescription ?? "")")
                        
                        Text("tourist second spot name: \(cityInfoDataModel.touristSpots[1].name ?? "")")
                        Text("tourist second spot description: \(cityInfoDataModel.touristSpots[1].spotDescription ?? "")")
                        
                        Text("tourist third spot name: \(cityInfoDataModel.touristSpots[2].name ?? "")")
                        Text("tourist third spot description: \(cityInfoDataModel.touristSpots[2].spotDescription ?? "")")
                        
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
