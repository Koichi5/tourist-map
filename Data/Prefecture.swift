////
////  Prefecture.swift
////  TouristMap
////
////  Created by Koichi Kishimoto on 2024/04/10.
////
//
import Foundation

enum Prefecture: String, CaseIterable, Codable {
    case hokkaido = "北海道"
    case aomori = "青森県"
    case iwate = "岩手県"
    case miyagi = "宮城県"
    case akita = "秋田県"
    case yamagata = "山形県"
    case fukushima = "福島県"
    case ibaraki = "茨城県"
    case tochigi = "栃木県"
    case gunma = "群馬県"
    case saitama = "埼玉県"
    case chiba = "千葉県"
    case tokyo = "東京都"
    case kanagawa = "神奈川県"
    case niigata = "新潟県"
    case toyama = "富山県"
    case ishikawa = "石川県"
    case fukui = "福井県"
    case yamanashi = "山梨県"
    case nagano = "長野県"
    case gifu = "岐阜県"
    case shizuoka = "静岡県"
    case aichi = "愛知県"
    case mie = "三重県"
    case shiga = "滋賀県"
    case kyoto = "京都府"
    case osaka = "大阪府"
    case hyogo = "兵庫県"
    case nara = "奈良県"
    case wakayama = "和歌山県"
    case tottori = "鳥取県"
    case shimane = "島根県"
    case okayama = "岡山県"
    case hiroshima = "広島県"
    case yamaguchi = "山口県"
    case tokushima = "徳島県"
    case kagawa = "香川県"
    case ehime = "愛媛県"
    case kochi = "高知県"
    case fukuoka = "福岡県"
    case saga = "佐賀県"
    case nagasaki = "長崎県"
    case kumamoto = "熊本県"
    case oita = "大分県"
    case miyazaki = "宮崎県"
    case kagoshima = "鹿児島県"
    case okinawa = "沖縄県"
    
    var code: Int {
        switch self {
        case .hokkaido: return 1
        case .aomori: return 2
        case .iwate: return 3
        case .miyagi: return 4
        case .akita: return 5
        case .yamagata: return 6
        case .fukushima: return 7
        case .ibaraki: return 8
        case .tochigi: return 9
        case .gunma: return 10
        case .saitama: return 11
        case .chiba: return 12
        case .tokyo: return 13
        case .kanagawa: return 14
        case .niigata: return 15
        case .toyama: return 16
        case .ishikawa: return 17
        case .fukui: return 18
        case .yamanashi: return 19
        case .nagano: return 20
        case .gifu: return 21
        case .shizuoka: return 22
        case .aichi: return 23
        case .mie: return 24
        case .shiga: return 25
        case .kyoto: return 26
        case .osaka: return 27
        case .hyogo: return 28
        case .nara: return 29
        case .wakayama: return 30
        case .tottori: return 31
        case .shimane: return 32
        case .okayama: return 33
        case .hiroshima: return 34
        case .yamaguchi: return 35
        case .tokushima: return 36
        case .kagawa: return 37
        case .ehime: return 38
        case .kochi: return 39
        case .fukuoka: return 40
        case .saga: return 41
        case .nagasaki: return 42
        case .kumamoto: return 43
        case .oita: return 44
        case .miyazaki: return 45
        case .kagoshima: return 46
        case .okinawa: return 47
        }
    }
    
    var capital: String {
        switch self {
        case .hokkaido:
            "札幌市"
        case .aomori:
            "青森市"
        case .iwate:
            "盛岡市"
        case .miyagi:
            "仙台市"
        case .akita:
            "秋田市"
        case .yamagata:
            "山形市"
        case .fukushima:
            "福島市"
        case .ibaraki:
            "水戸市"
        case .tochigi:
            "宇都宮市"
        case .gunma:
            "前橋市"
        case .saitama:
            "さいたま市"
        case .chiba:
            "千葉市"
        case .tokyo:
            "東京"
        case .kanagawa:
            "横浜市"
        case .niigata:
            "新潟市"
        case .toyama:
            "富山市"
        case .ishikawa:
            "金沢市"
        case .fukui:
            "福井市"
        case .yamanashi:
            "甲府市"
        case .nagano:
            "長野市"
        case .gifu:
            "岐阜市"
        case .shizuoka:
            "静岡市"
        case .aichi:
            "名古屋市"
        case .mie:
            "津市"
        case .shiga:
            "大津市"
        case .kyoto:
            "京都市"
        case .osaka:
            "大阪市"
        case .hyogo:
            "神戸市"
        case .nara:
            "奈良市"
        case .wakayama:
            "和歌山市"
        case .tottori:
            "鳥取市"
        case .shimane:
            "松江市"
        case .okayama:
            "岡山市"
        case .hiroshima:
            "広島市"
        case .yamaguchi:
            "山口市"
        case .tokushima:
            "徳島市"
        case .kagawa:
            "高松市"
        case .ehime:
            "松山市"
        case .kochi:
            "高知市"
        case .fukuoka:
            "福岡市"
        case .saga:
            "佐賀市"
        case .nagasaki:
            "長崎市"
        case .kumamoto:
            "熊本市"
        case .oita:
            "大分市"
        case .miyazaki:
            "宮崎市"
        case .kagoshima:
            "鹿児島市"
        case .okinawa:
            "那覇市"
        }
    }
    
    // https://www.e-stat.go.jp/dbview?sid=0003411884
    var population: Int {
        switch self {
        case .hokkaido:
            5098000
        case .aomori:
            1198000
        case .iwate:
            1173000
        case .miyagi:
            2256000
        case .akita:
            926000
        case .yamagata:
            1033000
        case .fukushima:
            1776000
        case .ibaraki:
            2767000
        case .tochigi:
            1865000
        case .gunma:
            1850000
        case .saitama:
            7136000
        case .chiba:
            6100000
        case .tokyo:
            13443000
        case .kanagawa:
            8991000
        case .niigata:
            2136000
        case .toyama:
            998000
        case .ishikawa:
            1102000
        case .fukui:
            738000
        case .yamanashi:
            784000
        case .nagano:
            1984000
        case .gifu:
            1888000
        case .shizuoka:
            3484000
        case .aichi:
            7228000
        case .mie:
            1689000
        case .shiga:
            1373000
        case .kyoto:
            2485000
        case .osaka:
            8524000
        case .hyogo:
            5287000
        case .nara:
            1291000
        case .wakayama:
            896000
        case .tottori:
            539000
        case .shimane:
            648000
        case .okayama:
            1832000
        case .hiroshima:
            2708000
        case .yamaguchi:
            1297000
        case .tokushima:
            698000
        case .kagawa:
            920000
        case .ehime:
            1294000
        case .kochi:
            671000
        case .fukuoka:
            5030000
        case .saga:
            793000
        case .nagasaki:
            1272000
        case .kumamoto:
            1699000
        case .oita:
            1092000
        case .miyazaki:
            1044000
        case .kagoshima:
            1550000
        case .okinawa:
            1446000
        }
    }
    
    var area: Int {
        switch self {
        case .hokkaido:
            7842075
        case .aomori:
            964595
        case .iwate:
            1527501
        case .miyagi:
            728229
        case .akita:
            1163752
        case .yamagata:
            932315
        case .fukushima:
            1378414
        case .ibaraki:
            609754
        case .tochigi:
            640809
        case .gunma:
            636228
        case .saitama:
            379775
        case .chiba:
            515674
        case .tokyo:
            219405
        case .kanagawa:
            241632
        case .niigata:
            1258396
        case .toyama:
            424754
        case .ishikawa:
            418623
        case .fukui:
            419058
        case .yamanashi:
            446527
        case .nagano:
            1356156
        case .gifu:
            1062129
        case .shizuoka:
            777702
        case .aichi:
            517324
        case .mie:
            577448
        case .shiga:
            401738
        case .kyoto:
            461220
        case .osaka:
            190534
        case .hyogo:
            840094
        case .nara:
            369094
        case .wakayama:
            472469
        case .tottori:
            350713
        case .shimane:
            670766
        case .okayama:
            711477
        case .hiroshima:
            847900
        case .yamaguchi:
            611250
        case .tokushima:
            414699
        case .kagawa:
            187691
        case .ehime:
            567598
        case .kochi:
            710291
        case .fukuoka:
            498764
        case .saga:
            244067
        case .nagasaki:
            413099
        case .kumamoto:
            740918
        case .oita:
            634070
        case .miyazaki:
            773424
        case .kagoshima:
            918633
        case .okinawa:
            228215
        }
    }


    func nameInKanji() -> String {
        return self.rawValue
    }
}

extension Prefecture {
    static func from(string: String) -> Prefecture? {
        return Prefecture.allCases.first { $0.rawValue == string }
    }
}
