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
                            spotDescription: "さっぽろテレビ塔は北海道札幌市中央区大通西1丁目の大通公園内にある電波塔である。札幌市の中央にあり、総工費1億7000万円で1957年に完成し、同年8月24日に開業。高さ147.2メートル。設計者は内藤多仲。",
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
                        imageName: "miyagi",
                        name: "Miyagi",
                        prefecture: Prefecture.miyagi
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 38.368546,
                            longitude: 141.058354,
                            name: "松島",
                            placeId: "ChIJub4rDwqbiV8RaFDRfXMdg4c",
                            spotDescription: "平安時代より多くの歌に詠まれ、中世には霊場として栄えた松島。日本三景の一つに数えられる景勝地で、松尾芭蕉の「おくの細道」でも有名です。湾に浮かぶ約260の島々を一望できる4か所の展望名所「四大観」、岬の丘にある「双観山」、湾内すべてを正面から見渡せる「新富山」など、見事な眺望を楽しめるスポットが数多くあります。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "fukushima",
                        name: "Fukushima",
                        prefecture: Prefecture.fukushima
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 37.333983,
                            longitude: 139.860997,
                            name: "大内宿",
                            placeId: "ChIJsRZu4rH8H2ARMPL0O-FTKWI",
                            spotDescription: "大内宿は、江戸時代には会津西街道(別称下野街道)の「半農半宿」の宿場であった福島県南会津郡下郷町大字大内にある旧宿場。重要伝統的建造物群保存地区として選定されている",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "niigata",
                        name: "Niigata",
                        prefecture: Prefecture.niigata
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.973043,
                            longitude: 138.749916,
                            name: "日本三大峡谷 清津峡",
                            placeId: "ChIJwR40nhX_9V8RlXpywm88LnE",
                            spotDescription: "川を挟んで切り立つ巨大な岩壁がV字型の大峡谷をつくり、国の名勝天然記念物にも指定されている「清津峡」。黒部峡谷・大杉谷とともに日本三大峡谷の一つに数えられ、雄大な柱状節理の岩肌とエメラルドグリーンの清流は感動的な美しさです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "ibaraki",
                        name: "Ibaraki",
                        prefecture: Prefecture.ibaraki
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.403776,
                            longitude: 140.597607,
                            name: "国営ひたち海浜公園",
                            placeId: "ChIJQURehB2LIWAR4fDmA-odfnY",
                            spotDescription: "公園としてはもちろん、花の名所として県内外の人々に親しまれています。春はスイセンから始まり、カラフルなチューリップ、みはらしの丘をライトブルーに染め上げるネモフィラと続きます。夏にはラベンダー、ヒマワリなど。秋もバラやコスモス、紅葉する草コキアなど。一年を通してイベントも豊富です",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "tochigi",
                        name: "Tochigi",
                        prefecture: Prefecture.tochigi
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 37.063696,
                            longitude: 139.964190,
                            name: "那須ハイランドパーク",
                            placeId: "ChIJ32-TNGyJH2ARK-2UXfZV9V0",
                            spotDescription: "那須ハイランドパークは、栃木県那須町にある北関東最大級の遊園地。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "gunma",
                        name: "Gunma",
                        prefecture: Prefecture.gunma
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.622942,
                            longitude: 138.596730,
                            name: "草津温泉",
                            placeId: "ChIJ7brFG1XmHWARqx4K0Be5o9k",
                            spotDescription: "日本三名泉のひとつであり、自然湧出量は日本一の毎分3万2,300リットルを誇る草津温泉。「湯畑」はその温泉街の中心部にあり、毎分4,000リットルの温泉から白い湯煙をもうもうと上げて湧き出す様が圧巻。湯畑の周りには瓦を敷き詰めた遊歩道や石柵、白根山を象った白根山ベンチなどがあり、ライトアップされる夜の眺めも幻想的です。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "chiba",
                        name: "Chiba",
                        prefecture: Prefecture.chiba
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.632912,
                            longitude: 139.880383,
                            name: "東京ディズニーランド",
                            placeId: "ChIJszdHEQN9GGARy9MJ1TY22eQ",
                            spotDescription: "子供から大人まで楽しめるディズニーのテーマパーク。高さ約51メートルのシンデレラ城をシンボルに、7つのテーマランドで構成されています。多彩なアトラクションをはじめ、期間限定のスペシャルイベントやパレード、ステージショーなど充実のエンターテインメントも魅力です。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "saitama",
                        name: "Saitama",
                        prefecture: Prefecture.saitama
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.925404,
                            longitude: 138.930387,
                            name: "三峯神社",
                            placeId: "ChIJaWeNYVG_GGARdMc4WfTKSoA",
                            spotDescription: "約1900年前に日本武尊によって創建された秩父三社の一つ。全国的にも珍しい“三ツ鳥居”の両脇には狛犬ならぬオオカミ像が据えられ、犬神信仰の神社として知られます。神様の氣力を分けてもらえるパワースポットとしても有名で、境内のご神木が入った“氣守”はぜひ手に入れたいアイテムです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "saitama",
                        name: "Saitama",
                        prefecture: Prefecture.saitama
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.925404,
                            longitude: 138.930387,
                            name: "三峯神社",
                            placeId: "ChIJaWeNYVG_GGARdMc4WfTKSoA",
                            spotDescription: "約1900年前に日本武尊によって創建された秩父三社の一つ。全国的にも珍しい“三ツ鳥居”の両脇には狛犬ならぬオオカミ像が据えられ、犬神信仰の神社として知られます。神様の氣力を分けてもらえるパワースポットとしても有名で、境内のご神木が入った“氣守”はぜひ手に入れたいアイテムです。",
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
                        imageName: "kanagawa",
                        name: "Kanagawa",
                        prefecture: Prefecture.kanagawa
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.452229,
                            longitude: 139.643388,
                            name: "横浜赤レンガ倉庫",
                            placeId: "ChIJSXGAhfhcGGARcz3MKth9lJQ",
                            spotDescription: "実際に倉庫として使われていた建物をショッピングモールとして活用している「赤レンガ倉庫」。港町横浜ならではの景観が楽しめるスポットとして大人気。おしゃれなショップやレストランがたくさん集まっています。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "yamanashi",
                        name: "Yamanashi",
                        prefecture: Prefecture.yamanashi
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.517820,
                            longitude: 138.749211,
                            name: "河口湖",
                            placeId: "ChIJTz8EpbRfGWARR30zHkuyyyk",
                            spotDescription: "富士五湖のひとつに数えられる河口湖は、五湖の中で最も長い湖岸線を持ちます。河口湖大橋から眺める富士山は絶景として有名。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "nagano",
                        name: "Nagano",
                        prefecture: Prefecture.nagano
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.661620,
                            longitude: 138.187693,
                            name: "善光寺",
                            placeId: "ChIJV-14vZj5G2ARMjr0MUI-U6g",
                            spotDescription: "男女、宗派にこだわらず常にあらゆる信徒を受け入れ、庶民からの信仰を集めた寺。川中島の合戦では上杉謙信が本陣を構えたとされる場所でもあります。江戸時代には「一生に一度は善光寺参り」という言葉があるように、全国から多くの人が訪れました。「撞木造」という構造を持つ本堂は東日本最大規模の仏教建築で、国宝にも指定。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "shizuoka",
                        name: "Shizuoka",
                        prefecture: Prefecture.shizuoka
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.098045,
                            longitude: 139.076817,
                            name: "熱海サンビーチ",
                            placeId: "ChIJVd9Upy2_GWARfIDGzmBDBh4",
                            spotDescription: "男女、宗派にこだわらず常にあらゆる信徒を受け入れ、庶民からの信仰を集めた寺。川中島の合戦では上杉謙信が本陣を構えたとされる場所でもあります。江戸時代には「一生に一度は善光寺参り」という言葉があるように、全国から多くの人が訪れました。「撞木造」という構造を持つ本堂は東日本最大規模の仏教建築で、国宝にも指定。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "toyama",
                        name: "Toyama",
                        prefecture: Prefecture.toyama
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.566547,
                            longitude: 137.662157,
                            name: "黒部ダム",
                            placeId: "ChIJB7x2Jpru918RXnjJFJb9E94",
                            spotDescription: "昭和38年に完成した日本最大級のアーチ式ダム。世紀の大事業ともいわれるその建設は、石原裕次郎主演の映画「黒部の太陽」で描かれたことでも有名です。初夏から秋には観光放水も行われ、日本一を誇る高さから水煙を上げて水が流れ落ちる様は大迫力。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "gifu",
                        name: "Gifu",
                        prefecture: Prefecture.gifu
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.257838,
                            longitude: 136.906039,
                            name: "白川郷",
                            placeId: "ChIJ5yW_trBx-F8R-AVYnbtRxcw",
                            spotDescription: "大自然に囲まれた日本有数の豪雪地帯に、数百年の時を刻む合掌造りの建物が100棟余り現存。1995年に世界文化遺産にも登録された全国最大規模の合掌集落です。現在も実生活の場として住民が暮らすなか、国指定重要文化財の和田家など内部見学が可能な施設も多数点在。1月中旬～2月上旬の積雪シーズンには合掌集落の幻想的なライトアップも開催。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "ishikawa",
                        name: "Ishikawa",
                        prefecture: Prefecture.ishikawa
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.562085,
                            longitude: 136.662603,
                            name: "兼六園",
                            placeId: "ChIJBVmy-YMz-F8R5PID8D17Cpc",
                            spotDescription: "加賀歴代藩主により長い年月をかけて形作られた、江戸時代の代表的な回遊式庭園。国の特別名勝に指定される日本三名園のひとつでもあり、10万平方メートルを越える敷地には池や滝があり、曲水が造られ、四季折々の風情が楽しめます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "fukui",
                        name: "Fukui",
                        prefecture: Prefecture.fukui
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 36.056589,
                            longitude: 136.356873,
                            name: "永平寺",
                            placeId: "ChIJ7Zpo4vWW-F8R0ijWxR-jYNc",
                            spotDescription: "今から約760年前、寛元2年に道元禅師によって開創された出家参禅の道場。樹齢約700年の老杉に囲まれた約10万坪の広さを持つ境内には大小70棟余りの建物が並び、今も常に約150名の僧が日夜修行に励んでいます。2015年にはフランスの旅行ガイド本「ミシュラン・グリーンガイド・ジャポン」に2つ星で掲載されました。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "aichi",
                        name: "Aichi",
                        prefecture: Prefecture.aichi
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.185572,
                            longitude: 136.899090,
                            name: "名古屋城",
                            placeId: "ChIJse-wx8t2A2ARd6Z1knjp07k",
                            spotDescription: "1612（慶長17）年に築城された名古屋のシンボル。戦災で焼失しましたが、1959（昭和34）年には、金のシャチをいただく五層の大天守閣と小天守閣が再建。2018年6月には、格式高い書院造の「湯殿書院」や豪華絢爛な「上洛殿」が見ごたえたっぷりの本丸御殿が完全公開。現代の絵師によって復元された400年前の障壁画は、息を呑む美しさです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "shiga",
                        name: "Shiga",
                        prefecture: Prefecture.shiga
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.070434,
                            longitude: 135.841023,
                            name: "比叡山延暦寺",
                            placeId: "ChIJMyzNoxsKAWARlcl_aAD9XZA",
                            spotDescription: "伝教大師・最澄が開いた天台宗の総本山「比叡山延暦寺」。東塔（とうどう）、西塔（さいとう）、横川（よかわ）の三塔十六谷からなり、数百のお堂や伽藍が点在しています。眼下に琵琶湖を望み、西には古都京都を一望できる景勝地でもあり、1200年の歴史と伝統が高く評価され、ユネスコ世界文化遺産にも登録されています。比叡山の山中には、ケーブルカーやドライブウェイが整備されており、諸堂拝観はもとより、自然散策や史蹟探訪も気軽に楽しめます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "mie",
                        name: "Mie",
                        prefecture: Prefecture.mie
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.454990,
                            longitude: 136.725190,
                            name: "伊勢神宮",
                            placeId: "ChIJ8zef3-tQBGARpwz2UzdmCfA",
                            spotDescription: "「お伊勢さん」「大神宮さん」と親しまれる「伊勢神宮」は、伊勢市と周辺に鎮座する125社の総称です。その中心となるのが「内宮（皇大神宮）」と、「外宮（豊受大神宮）」。内宮は国民の総氏神である天照大御神（あまてらすおおみかみ）を祀り、約2000年もの歴史があります。唯一神明造の御正殿ほか格式ある別宮も多彩です。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "nara",
                        name: "Nara",
                        prefecture: Prefecture.nara
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.688919,
                            longitude: 135.839848,
                            name: "東大寺",
                            placeId: "ChIJ3XYIepA5AWARjzzVnT-skPg",
                            spotDescription: "仏教中心の国づくりを進めた聖武天皇の勅願により743年に建立された「東大寺」。各地に建立された国分寺の中心をなす総国分寺と位置付けられました。「奈良の大仏」として知られる盧舎那仏（るしゃなぶつ）を本尊とし、大仏殿は世界最大級の木造建築。大仏殿の内部には、大仏の鼻と同じ大きさの穴が空いた柱があり、くぐると無病息災のご利益があるといわれます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "wakayama",
                        name: "Wakayama",
                        prefecture: Prefecture.wakayama
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.227730,
                            longitude: 135.171486,
                            name: "和歌山城",
                            placeId: "ChIJxdJgocGyAGARk2yAa2IxAOE",
                            spotDescription: "築城の名人・藤堂高虎が作り上げ、江戸時代には紀州55万5千石の城となり、徳川御三家のひとつとして長い歴史を刻んできました。こんもりと緑茂る虎伏山（とらふすやま）に白亜の天守閣がそびえ、御三家の威容にふさわしい風格。石垣には紀州特産の青石が多く使われており、時代によって異なる石垣の積み方が見られます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "kyoto",
                        name: "Kyoto",
                        prefecture: Prefecture.kyoto
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.994793,
                            longitude: 135.785002,
                            name: "清水寺",
                            placeId: "ChIJB_vchdMIAWARujTEUIZlr2I",
                            spotDescription: "世界遺産に登録されている、京都を代表する観光名所「清水寺（きよみずでら）」。音羽山中腹の三重塔、清水の舞台で知られる本堂、奥の院などが、壮大な伽藍を形作っています。崖の上に造られた舞台を支える柱には、釘が1本も使われていないというから驚きです。その清水の舞台から望む京都市街の絶景は必見！ それだけでなく、春の桜、初夏の新緑、秋の紅葉と、1年を通して多くの観光客を魅了する美しい風景が広がります。",
                            thumbnailImageUrl: ""
                        ),
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
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "hyogo",
                        name: "Hyogo",
                        prefecture: Prefecture.hyogo
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.626807,
                            longitude: 134.812700,
                            name: "城崎温泉",
                            placeId: "ChIJvzzwnzvI_18R7pmJyu_Wa8U",
                            spotDescription: "開湯1300年、島崎藤村や志賀直哉など多くの文人墨客に愛された城崎温泉。小さな川沿いに、柳並木と木造の宿が軒を連ねる風情たっぷりな温泉街では、名物「外湯めぐり」が楽しめます。「一の湯」「地蔵湯」「御所の湯」など全部で7軒の外湯は、それぞれ入浴すればご利益があるとか。外湯巡りは「ゆめぱ」というバーコードが付いたパスを持ってまわります。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "tottori",
                        name: "Tottori",
                        prefecture: Prefecture.tottori
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.540398,
                            longitude: 134.228210,
                            name: "鳥取砂丘",
                            placeId: "ChIJbx8cHUSPVTURazEAdQKsetg",
                            spotDescription: "南北2.4キロメートル、東西16キロメートルに広がる日本最大級の砂丘。その中心部は海岸砂丘として国内で唯一天然記念物に指定されています。最大高低差約90メートルもの圧倒的な景観や、風と砂が織りなす風紋・砂柱などの造形美はもちろん、らくだ遊覧やサンドボードなど砂丘ならではのアクティビティも感動的な楽しさです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "shimane",
                        name: "Shimane",
                        prefecture: Prefecture.shimane
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 35.401999,
                            longitude: 132.685457,
                            name: "出雲大社",
                            placeId: "ChIJPRlWKpRcVzUR74S6_K5qanA",
                            spotDescription: "因幡の白兎や国譲り神話の主人公、大国主大神を祀る古社。縁結びの神、福の神としても親しまれ、全国から大勢の参拝者が訪れます。1744年に建てられた本殿は、日本で最も古い神社建築の大社造りで、2013年には60年ぶりの「平成の大遷宮」も行われました。毎年旧暦10月には八百万の神々が、ここ出雲に集まるといわれています。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "okayama",
                        name: "Okayama",
                        prefecture: Prefecture.okayama
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.667258,
                            longitude: 133.936139,
                            name: "岡山後楽園",
                            placeId: "ChIJT4gQ5SQGVDURFzjloTQOH5A",
                            spotDescription: "元禄13（1700）年に岡山藩主・池田綱政（つなまさ）が、やすらぎの場として造らせた庭園です。日本三名園の一つで、国の特別名勝に指定されています。梅雨の季節には菖蒲（しょうぶ）の花、夏には蓮の花が顔を覗かせるなど、四季折々の景観も見どころです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "hiroshima",
                        name: "Hiroshima",
                        prefecture: Prefecture.hiroshima
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.296036,
                            longitude: 132.319690,
                            name: "厳島神社",
                            placeId: "ChIJj23HfgTjGmARkNW10PcocjU",
                            spotDescription: "日本三景のひとつに数えられる「宮島」。島内の「嚴島（いつくしま）神社」や「弥山（みせん）原始林」などは、世界文化遺産に登録されています。自然あふれる宮島には野生動物も多く住み、ニホンジカやタヌキ、野鳥などが。また、グルメも宮島観光ではずせません。名物・もみじ饅頭はもちろん、宮島二大グルメの牡蠣とあなごは必食！",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "yamaguchi",
                        name: "Yamaguchi",
                        prefecture: Prefecture.yamaguchi
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.353074,
                            longitude: 130.886193,
                            name: "角島大橋",
                            placeId: "ChIJlyxJOY8TQzURdl2pDhhvhZQ",
                            spotDescription: "2000年11月3日に開通した角島観光のシンボル的存在。コバルトブルーの海や、途中に浮かぶ小さな鳩島、角島などの風光明媚な絶景は、映画やCMのロケ地としても有名です。また、通行料金無料の離島架橋としては日本屈指の長さ（全長1,780メートル）を誇ります。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "kagawa",
                        name: "Kagawa",
                        prefecture: Prefecture.kagawa
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.357610,
                            longitude: 134.105093,
                            name: "屋島",
                            placeId: "ChIJvVer7i-TUzURF7-W7OJ76O8",
                            spotDescription: "源平合戦の古戦場として知られる屋根型の溶岩台地。その山上には遊歩道が整備され、いくつもの展望台が点在。なかでも「談古嶺（だんこれい）」、「獅子の霊巌（ししのれいがん）」、「遊鶴亭（ゆうかくてい）」の3つは屋島三大展望台と呼ばれ、波穏やかな瀬戸の海や高松市街が見渡せる絶景スポットです。また、四国霊場第84番札所の「屋島寺」や「新屋島水族館」など魅力的な立ち寄り処も多数。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "tokushima",
                        name: "Tokushima",
                        prefecture: Prefecture.tokushima
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 34.238333,
                            longitude: 134.651389,
                            name: "鳴門の渦潮",
                            placeId: "ChIJtc_GvRhhUzURD5YWECaI2dw",
                            spotDescription: "鳴門市大毛島と淡路島の間にある鳴門海峡で、潮の干満によって発生する世界三大潮流のひとつ。春と秋の大潮時には、潮流時速約20km、最大直径約20mにも及ぶ渦潮も発生。渦の間近まで接近する観潮船「わんだーなると」や、水面下1mくらいの海中の渦の様子が見られる水中観潮船「アクアエディ」で観測するのがおすすめです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "ehime",
                        name: "Ehime",
                        prefecture: Prefecture.ehime
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 33.852063,
                            longitude: 132.786368,
                            name: "道後温泉",
                            placeId: "ChIJP6RikHjmTzURpo5vlFB773Y",
                            spotDescription: "開湯は縄文時代、聖徳太子も訪れ、日本最古とも言われる道後温泉。そのシンボルが、国の重要文化財に指定されながら、現役の公衆浴場として営業を続けている「道後温泉本館」。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "kochi",
                        name: "Kochi",
                        prefecture: Prefecture.kochi
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 33.497003,
                            longitude: 133.575028,
                            name: "桂浜",
                            placeId: "ChIJu-AvdBYaTjURfS0eE5t-FxQ",
                            spotDescription: "浦戸湾口、龍頭岬と龍王岬の間に弓状に広がる海岸で、高知県を代表する景勝地のひとつ。「月の名所は桂浜」とよさこい節でも唄われ、一帯は都市公園として整備されています。龍頭岬には幕末の志士・坂本龍馬の銅像が太平洋を見下ろし、その生涯を紹介する「坂本龍馬記念館」や、アシカのショーなどが楽しめる「桂浜水族館」もあります。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "fukuoka",
                        name: "Fukuoka",
                        prefecture: Prefecture.fukuoka
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 33.521476,
                            longitude: 130.534843,
                            name: "太宰府天満宮",
                            placeId: "ChIJzfvrKp-bQTURl65fp6vRJLg",
                            spotDescription: "観光の中心となる「太宰府天満宮」は、学問の神様として有名な菅原道真公が祀られており、境内には、軍師官兵衛が晩年を過ごした「如水社」や、幕末に商人から寄付された「麒麟像」など、歴史を感じられるスポットが多数あります。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "saga",
                        name: "Saga",
                        prefecture: Prefecture.saga
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 33.368130,
                            longitude: 130.203553,
                            name: "古湯温泉",
                            placeId: "ChIJOfLvVhXPQTUR-psyc1J-qK0",
                            spotDescription: "2200年前、不老長寿の薬を求めて秦の始皇帝に派遣された徐福が発見したとの伝説が残る、文字通りの古湯。泉温が38℃と低く、肌触りがぬるりとするため別名「ぬる湯」と呼ばれています。自然に囲まれた湯治街には、珍しい砂蒸し風呂や、全客室が離れの造りなど、趣向を凝らした宿が点在し、落ち着いた滞在が楽しめます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "nagasaki",
                        name: "Nagasaki",
                        prefecture: Prefecture.nagasaki
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 33.086607,
                            longitude: 129.787787,
                            name: "ハウステンボス",
                            placeId: "ChIJvc-zbma9ajUR93iHfUJ7Jm8",
                            spotDescription: "約152万平米の日本一広いテーマパーク。日本最多、九州最大級レベルの美しい花々が一年中咲き誇る敷地内には、大人も子どもも楽しめるアトラクションが揃います。VRやAR、プロジェクションマッピングなど最先端技術を駆使したアトラクションも。夜は世界最大のイルミネーション「光の王国」が必見です。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "oita",
                        name: "Oita",
                        prefecture: Prefecture.oita
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 33.282333,
                            longitude: 131.390370,
                            name: "由布岳",
                            placeId: "ChIJW2pWcsOuRjURh34nbTameiU",
                            spotDescription: "人気温泉地・由布院のシンボルでもある、標高1,583メートルの活火山。円錐形のその形から“豊後富士”として親しまれています。古くから信仰の山として『古事記』や『豊後国風土記』にもその名が記されました。由布院盆地では、各所から由布岳を望むことができ、別府湾からも鶴見岳の後方にその姿を望むことができます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "kumamoto",
                        name: "Kumamoto",
                        prefecture: Prefecture.kumamoto
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 32.806130,
                            longitude: 130.705848,
                            name: "熊本城",
                            placeId: "ChIJWco6Ag70QDURMOTNdshmi14",
                            spotDescription: "江戸時代の初め、加藤清正が当時の最先端の技術を投入して築いた城で、以来熊本のシンボル的存在。別名「銀杏城」と呼ばれ、特に優美な石垣が有名です。2016年の熊本地震による損壊の復旧は令和19年ごろまでかかるといわれていますが、二の丸広場や加藤神社から天守閣を見ることができ、現在も観光名所として国内外から多くの人が訪れます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "miyazaki",
                        name: "Miyazaki",
                        prefecture: Prefecture.miyazaki
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 32.702057,
                            longitude: 131.300885,
                            name: "熊本城",
                            placeId: "ChIJLwml_t0sRzURix_JnSldeVg",
                            spotDescription: "昔、阿蘇火山活動の火砕流が五ヶ瀬川に沿って流れ出し、 急激に冷却されてできた渓谷。高さ約50～100mの柱状節理がすばらしい景色を作り出しています。「真名井の滝」はこの渓谷のシンボルで、高さ約17ｍから水面に落ちる様は圧巻。遊歩道からは3つのアーチ橋や、高千穂伝説が残る「鬼八の力石」など見どころも盛りだくさんです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "kagoshima",
                        name: "Kagoshima",
                        prefecture: Prefecture.kagoshima
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 31.584824,
                            longitude: 130.660229,
                            name: "桜島",
                            placeId: "ChIJl-1qAHL1PjURlI5hzxStZZc",
                            spotDescription: "鹿児島のシンボルである「桜島」は、錦江湾にある陸続きの島。標高約1,117メートルの御岳（北岳）という活火山が、現在も活発に噴火を続けています。散策に適した溶岩遊歩道の途中には、絶景を望める展望所も複数完備。海沿いの露天風呂を楽しめる「古里温泉郷」や、錦江湾を見晴らせる日本最大級の足湯などもあり、観光スポットが盛りだくさんです。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
                viewModel.add(
                    cityInfoDataModel: CityInfoDataModel(
                        imageName: "okinawa",
                        name: "Okinawa",
                        prefecture: Prefecture.okinawa
                        
                    ),
                    touristSpots: [
                        TouristSpotDataModel(
                            latitude: 26.217038,
                            longitude: 127.719483,
                            name: "首里城",
                            placeId: "ChIJZ9v0bP5r5TQRi0-esrqficA",
                            spotDescription: "沖縄のシンボル的存在である首里城公園。世界遺産である首里城跡や数々の史跡が点在する、琉球王国時代の歴史を物語る文化財です。見学エリアは、正殿遺構を中心とした有料区域と、2,000円札に描かれたことで有名な守礼門などが見られる無料区域に分かれ、敷地内では例年11月の「首里城祭」をはじめとした琉球文化を体験できるイベントも多数。",
                            thumbnailImageUrl: ""
                        ),
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
