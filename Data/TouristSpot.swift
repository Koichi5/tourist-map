////
////  TouristSpot.swift
////  TouristMap
////
////  Created by Koichi Kishimoto on 2024/03/31.
////
//
import Foundation

let tokyoTouristSpots = [
    TouristSpot(name: "雷門", description: "東京の下町と言えば浅草。浅草寺の表参道である仲見世通りは、雷門から宝蔵門まで長さ約250mあると言われています。浅草にはそば・天ぷら・もんじゃ焼きにすき焼き…どぜう料理に洋食など、一日では食べきれないほどたくさんの老舗専門店が並んでいます。おみやげにも最適な、ビー玉、けん玉、おはじきなど伝統的なおもちゃや民芸品、風鈴や扇子など、雑貨巡りも楽しめます。現存する日本最古の遊園地「浅草花やしき」も人気です。古き良き江戸の賑わいを心ゆくまで堪能したいなら、まずは浅草に訪れて間違いはないでしょう。", latitude: 35.710004, longitude: 139.795121, thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg", placeId: ""),
    TouristSpot(name: "東京スカイツリー", description: "高さ634mを誇る自立式電波塔、「東京スカイツリー」。地上350mの天望デッキからは東京の景色が堪能できることはもちろん、富士山を見られることもあります。そのふもとには300以上の店舗が入る商業施設「東京ソラマチ」があり、国内外の観光客が多く訪れています。", latitude: 35.710015, longitude: 139.810730, thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg", placeId: ""),
    TouristSpot(name: "上野動物園", description: "「上野動物園」は、1882年に開園した、日本で最も歴史の長い動物園です。日中国交回復を記念し、1972年に日本で初めて中国からジャイアントパンダを受け入れた動物園でもあり、現在もパンダは園の人気者です。2020年9月には、園内の東園にあるパンダ舎とは別に、西園でもパンダが見られる「パンダのもり」ができました。ほかの動物たちも、生息地を再現した環境で展示されており、水中を泳ぐホッキョクグマや冬眠中のクマも見られます。", latitude: 35.715795, longitude: 139.770150, thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg", placeId: ""),
]

let osakaTouristSpots = [
    TouristSpot(name: "大阪城", description: "天正 11 年 (1583 年) に豊臣秀吉が天下統一を目指して築城した大阪城は、大阪のシンボルともいえるランドマーク。広大な敷地には、大阪城天守閣をはじめ、金明水井戸屋形、金蔵、焔硝蔵、大手門など国の重要文化財に指定された歴史的な遺構が数多く残されています。", latitude: 34.687234, longitude: 135.525842, thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg", placeId: "ChIJ_TooXM3gAGARQR6hXH3QAQ8"),
    TouristSpot(name: "ユニバーサル・スタジオ・ジャパン", description: "ユニバーサル・スタジオ・ジャパンは、スティーヴン・スピルバーグがクリエイティブ総監督を務めたダイナミックな世界観が人気のテーマパーク。盛りだくさんのアトラクションやライド、ショーに、小さな子供から大人まで誰でも夢中になるはず。", latitude: 34.666129, longitude: 135.432120, thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg", placeId: ""),
    TouristSpot(name: "通天閣", description: "浪速区の歓楽街「新世界」にそびえ立つ通天閣は、エネルギッシュな大阪の下町を象徴する存在です。高さ103メートルの通天閣にある展望台からは、大阪の街を一望することができます。", latitude: 34.652490, longitude: 135.506263, thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg", placeId: ""),
]

struct TouristSpot: Hashable, Codable {
    let name: String
    let description: String
    let latitude: Float
    let longitude: Float
    let thumbnailImageUrl: String
    let placeId: String
}
