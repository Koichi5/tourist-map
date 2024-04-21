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
            HStack {
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
                Button {
                    openWindow(id: ViewID.settingsView)
                } label: {
                    HStack {
                        Image(systemName: "gearshape")
                        Text("設定")
                    }
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
                            spotDescription: "北海道札幌市中央区大通西1丁目に位置する大通公園内に建つさっぽろテレビ塔は、札幌市中心部に立地しています。この電波塔は1957年に総工費1億7000万円をかけて建設され、同年の8月24日に開業しました。塔の高さは147.2メートルで、設計は内藤多仲によるものです。",
                            thumbnailImageUrl: "https://photock.jp/photo/big_webp/photo0000-7045.webp"
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
                            spotDescription: "青森県弘前市に位置する弘前城は、日本の城郭の一つです。この城は鷹岡城や高岡城とも称されています。江戸時代に建設された天守閣や櫓（やぐら）は現在も残っており、国の重要文化財として登録されています。さらに、城跡自体も国の史跡に指定されています。江戸時代には津軽氏がこの城を本拠地とし、弘前藩の藩庁も置かれていました。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2019/10/31/07/56/landscape-4591248_1280.jpg"
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
                            spotDescription: "田沢湖は秋田県仙北市に位置する淡水湖で、一級河川である雄物川水系に属しています。この湖は日本で最も深く、面積においては日本で19番目に広い湖沼です。田沢湖全域が田沢湖抱返り県立自然公園に指定されており、日本百景の一つとされています。田沢湖町という1956年から2005年まで存在した自治体は、この湖が名前の由来で、現在でもその地域は旧田沢湖町の区域としての名を冠しています。",
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
                            spotDescription: "金色堂は、中尊寺が創建された当初からの姿を保持している重要な建造物です。この堂は1124年（天治元年）に奥州藤原氏の初代、清衡公によって建てられました。中尊寺内の多くの堂塔の中でも、特に精巧な意匠が施されており、清衡公が極楽浄土を具現化することを切望した結果、当時の高度な工芸技術が凝縮されています。",
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
                            spotDescription: "銀山温泉は、かつて江戸時代初期に繁栄を極めた「延沢銀山」にちなんで名付けられました。この温泉地では、大正末期から昭和初期にかけて建設された洋風木造多層建築の旅館が、銀山川の両岸に沿って立ち並びます。訪れる人々は、昔懐かしい独特の景観を楽しむことができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/02/09/45/japan-1366872_1280.jpg"
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
                            spotDescription: "松島は平安時代から多くの歌に詠まれ、中世には霊場として繁栄しました。この地は、松尾芭蕉の「おくの細道」で知られる日本三景の一つです。湾内に点在する約260の島々を一望できる四大観の展望地や、岬の丘に位置する双観山、湾全体を前面に望むことができる新富山など、数多くの素晴らしいスポットがあります。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/12/10/04/52/tohoku-1896660_1280.jpg"
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
                            spotDescription: "大内宿は福島県南会津郡下郷町大字大内に位置し、江戸時代には会津西街道（別称下野街道）沿いの「半農半宿」宿場として栄えました。この旧宿場町は、その歴史的建造物が保存されていることから、重要伝統的建造物群保存地区に指定されています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2018/05/07/05/13/ouchi-juku-3380117_1280.jpg"
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
                            spotDescription: "「清津峡」は、川に挟まれた巨大な岩壁がV字型の大峡谷を形成しており、日本三大峡谷の一つに数えられています。この峡谷は国の名勝天然記念物に指定されています。黒部峡谷、大杉谷と並び、その雄大な柱状節理の岩肌とエメラルドグリーンの清流が、訪れる人々に深い感動を与える美しさを持っています。",
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
                            spotDescription: "公園は花の名所としても知られ、地元の人々や観光客に親しまれています。春にはスイセンが開花し始め、次にカラフルなチューリップ、そしてライトブルーのネモフィラがみはらしの丘を染め上げます。夏にはラベンダーやヒマワリが彩りを加え、秋にはバラ、コスモス、草コキアの紅葉が見られます。年間を通じて多彩なイベントが開催され、訪れる人々に四季折々の美しさを提供しています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2017/03/31/07/47/chiba-2190623_1280.jpg"
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
                            spotDescription: "那須ハイランドパークは、栃木県那須町に位置する北関東最大級の遊園地です。",
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
                            spotDescription: "草津温泉は日本三名泉の一つで、自然湧出量が日本最大の毎分32,300リットルに達します。「湯畑」は温泉街の核心部に位置し、毎分4,000リットルの温泉が白い湯煙を立ち上げながら湧き出る様子は見る人を圧倒します。湯畑周辺には瓦が敷かれた遊歩道や石柵、白根山を模したベンチがあり、夜になるとライトアップされ、幻想的な風景を楽しむことができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/20/12/44/kusatsu-1404992_1280.jpg"
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
                            spotDescription: "ディズニーのテーマパークは、子供から大人まで楽しめる場所です。シンデレラ城を中心に多様なアトラクション、期間限定のスペシャルイベント、パレード、ステージショーなど、豊富なエンターテインメントが魅力的です。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/01/20/05/50/disney-land-1150973_1280.jpg"
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
                            spotDescription: "約1900年前、日本武尊が創建した秩父三社の一つであります。全国で珍しい「三ツ鳥居」を備え、その両脇には通常の狛犬ではなくオオカミの像が置かれており、犬神信仰の神社としても知られています。この神社は、神様から氣力を分けてもらえるパワースポットとしても有名で、境内にある神木を含んだ「氣守」は、訪れた多くの人々にとって手に入れたい貴重なアイテムとされています。",
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
                            spotDescription: "浅草は、東京の象徴的な下町地区です。浅草寺の正面道である仲見世通りは、雷門から宝蔵門まで約250メートルの長さがあります。このエリアは、そば、天ぷら、もんじゃ焼き、すき焼き、どぜう料理、洋食など、多種多様な伝統料理を提供する老舗店が並んでいます。また、ビー玉、けん玉、おはじきなどの伝統的なおもちゃや、風鈴、扇子などの民芸品が豊富に揃うおみやげにも最適です。さらに、日本最古の遊園地である「浅草花やしき」も多くの訪問者に愛されています。江戸時代の活気を感じたい方にとって、浅草は訪れる価値のある場所です。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2017/06/26/10/24/tokyo-2443311_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 35.710015,
                            longitude: 139.810730,
                            name: "東京スカイツリー",
                            placeId: "ChIJ35ov0dCOGGARKvdDH7NPHX0",
                            spotDescription: "「東京スカイツリー」は、高さ634メートルの自立式電波塔で、東京のランドマークの一つです。地上350メートルにある天望デッキからは、東京の広がる景色や時には富士山の姿も望むことができます。塔の基部には「東京ソラマチ」という大型商業施設があり、300店舗以上のショップやレストランが入っています。この場所は、国内外からの観光客に非常に人気があり、多くの人々が訪れています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2018/11/20/16/30/tokyo-sky-tree-3827717_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 35.715795,
                            longitude: 139.770150,
                            name: "上野動物園",
                            placeId: "ChIJf2129yiMGGAR9I6Yoe-1uHY",
                            spotDescription: "「上野動物園」は1882年に開園し、日本で最も歴史のある動物園です。1972年、日中国交回復を記念して日本初のジャイアントパンダを受け入れ、パンダは今でも園のスターです。2020年9月、新たに「パンダのもり」が開設され、東園と西園でパンダを観察できます。他の動物も自然に近い環境で展示されており、ホッキョクグマが水中を泳ぐ様子や冬眠中のクマも見ることができます。",
                            thumbnailImageUrl: ""
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
                            spotDescription: "横浜の「赤レンガ倉庫」は、かつての倉庫を活用したショッピングモールです。港町ならではの景観が楽しめ、多くのおしゃれなショップやレストランが軒を連ねています。",
                            thumbnailImageUrl: "https://photock.jp/photo/big_webp/photo0000-7661.webp"
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
                            spotDescription: "河口湖は富士五湖の一つで、五湖中最も長い湖岸線を誇ります。河口湖大橋からの富士山の眺望は特に有名です。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2015/07/17/12/24/reflection-849159_1280.jpg"
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
                            spotDescription: "善光寺は男女や宗派を問わず信者を受け入れる寺で、川中島の合戦では上杉謙信が本陣を構えた場所としても知られています。江戸時代には「一生に一度は善光寺参り」の言葉通り、全国から多くの人が訪れました。東日本最大の仏教建築である本堂は「撞木造」構造が特徴で、国宝に指定されています。",
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
                            spotDescription: "青い海と白い砂浜、そしてヤシの木が並ぶ通りがリゾート地のような雰囲気を醸し出すビーチです。夏には海水浴客で賑わい、家族連れやカップルにも人気のあるリラクゼーションスポットとして知られています。",
                            thumbnailImageUrl: "https://photock.jp/photo/big_webp/photo0000-7903.webp"
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
                            spotDescription: "昭和38年に完成した黒部ダムは、日本最大級のアーチ式ダムとして知られています。その建設過程は、石原裕次郎が主演した映画「黒部の太陽」で描かれ、広く知られています。初夏から秋にかけては観光放水が行われ、その壮大な水の落下は見る者を圧倒します。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2018/09/26/10/22/kurobe-dam-3704233_1280.jpg"
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
                            spotDescription: "白川郷の合掌造り集落は、長い歴史を持つ建物が100棟以上残り、1995年には世界文化遺産に登録されました。この地域では、現在も実際に人々が生活しており、一部の建物は内部公開が可能です。特に冬のライトアップイベントは幻想的な雰囲気を醸し出しています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2018/03/07/02/41/japan-3205106_1280.jpg"
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
                            spotDescription: "兼六園は、加賀藩主によって築かれた日本の代表的な回遊式庭園で、国の特別名勝にも指定されています。10万平方メートルを超える広大な敷地内には、四季折々の美しい風景が広がっています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2017/10/30/12/12/japan-2902290_1280.jpg"
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
                            spotDescription: "永平寺は約760年前に道元禅師によって開創された禅の修行道場です。10万坪もの広さを持ち、樹齢700年を超える老杉に囲まれた境内には70棟以上の建物が立ち並びます。ここでは150名の僧侶が日々修行に励んでおり、フランスのミシュラン・グリーンガイド・ジャポンにも2つ星で掲載されています。",
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
                            spotDescription: "名古屋城は1612年（慶長17年）に築城され、名古屋の象徴とされています。戦争による焼失後、1959年（昭和34年）には金色の鯱を戴く五層の大天守閣と小天守閣が再建されました。さらに、2018年6月には格式高い書院造の「湯殿書院」や豪華絢爛な「上洛殿」が含まれる本丸御殿が一般公開されました。400年前の障壁画も現代の絵師によって復元され、その美しさには息をのむほどです。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2021/12/22/16/06/japan-6887875_1280.jpg"
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
                            spotDescription: "比叡山延暦寺は、伝教大師・最澄によって開かれた天台宗の総本山です。東塔、西塔、横川の三塔十六谷からなり、多数のお堂や伽藍が点在しています。比叡山は琵琶湖を眼下に望み、西には古都京都を一望できる景勝地でもあります。1200年にわたる歴史と伝統が認められ、ユネスコの世界文化遺産にも登録されています。山中にはケーブルカーやドライブウェイが整備されており、寺院の拝観のみならず自然散策や史蹟探訪も楽しむことができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2018/10/25/23/18/kyoto-3773669_1280.jpg"
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
                            spotDescription: "伊勢神宮は、伊勢市とその周辺に鎮座する125社からなる神社群の総称で、「お伊勢さん」「大神宮さん」と親しまれています。中心となるのは「内宮（皇大神宮）」と「外宮（豊受大神宮）」です。内宮は国民の総氏神である天照大御神を祀り、約2000年の歴史を有します。また、唯一の神明造の御正殿をはじめ、多彩な別宮も存在します。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2017/09/25/10/05/japan-2784570_1280.jpg"
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
                            spotDescription: "東大寺は、743年に聖武天皇の勅願によって建立され、各地の国分寺の中心である総国分寺として位置付けられました。この寺院は「奈良の大仏」で知られる盧舎那仏を本尊としており、世界最大級の木造建築である大仏殿が有名です。大仏殿内には大仏の鼻と同じ大きさの穴が空いた柱があり、これをくぐることで無病息災のご利益があるとされています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2014/11/28/02/12/todaiji-548415_1280.jpg"
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
                            spotDescription: "和歌山城は、築城の名人である藤堂高虎によって建てられ、江戸時代には紀州55万5千石の城として、徳川御三家の一つとして長い歴史を刻みました。緑豊かな虎伏山に白亜の天守閣がそびえ立ち、その風格は御三家にふさわしいものです。城の石垣には紀州特産の青石が多用されており、時代による石垣の異なる積み方が観察できます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2017/04/17/05/44/wakayama-castle-2236563_1280.jpg"
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
                            spotDescription: "京都を代表する世界遺産「清水寺」は、音羽山中腹に位置し、三重塔や清水の舞台で知られる本堂、奥の院が壮大な伽藍を形成しています。舞台は崖上に建てられ、その支持柱に釘を一本も使用していないのが特徴です。清水の舞台からは京都市街の壮観な景色を望むことができ、春の桜、初夏の新緑、秋の紅葉を通じて、年間を通して美しい風景が広がり、多くの観光客を魅了しています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2017/01/13/07/41/temple-1976543_1280.jpg"
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
                            spotDescription: "1583年に豊臣秀吉によって築城された大阪城は、大阪の象徴的なランドマークです。この城は広大な敷地内に多数の重要文化財指定された遺構を保持しており、その中には大阪城天守閣、金明水井戸屋形、金蔵、焔硝蔵、大手門などが含まれます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/17/13/51/osaka-castle-1398116_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 34.666129,
                            longitude: 135.432120,
                            name: "ユニバーサル・スタジオ・ジャパン",
                            placeId: "ChIJXeLVg9DgAGARqlIyMCX-BTY",
                            spotDescription: "ユニバーサル・スタジオ・ジャパンは、スティーヴン・スピルバーグがクリエイティブ総監督を務める世界的に人気のあるテーマパークです。様々なアトラクションやライド、ショーが豊富に用意されており、小さな子供から大人まで幅広く楽しむことができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2020/04/20/10/16/hogwarts-5067655_1280.jpg"
                        ),
                        TouristSpotDataModel(
                            latitude: 34.652490,
                            longitude: 135.506263,
                            name: "通天閣",
                            placeId: "ChIJ_0Lgd2DnAGARV0X03lbPy-U",
                            spotDescription: "大阪の新世界地区に位置する通天閣は、エネルギッシュな大阪の下町文化を象徴するランドマークです。103メートルの高さからの展望台は、大阪の市街地を一望できる絶好の観光スポットです。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2020/11/06/22/56/tower-5719067_1280.jpg"
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
                            spotDescription: "開湯1300年を超える城崎温泉は、柳並木と木造の宿が立ち並ぶ風情ある温泉街で知られ、多くの文人墨客に愛されてきました。外湯めぐりは特に有名で、「一の湯」「地蔵湯」「御所の湯」など7軒の外湯を巡ることができ、それぞれに特有のご利益があります。外湯巡りには「ゆめぱ」というバーコード付きのパスを使用します。",
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
                            spotDescription: "鳥取砂丘は日本最大級の砂丘で、南北2.4キロメートル、東西16キロメートルに広がり、その中心部は海岸砂丘として国内で唯一天然記念物に指定されています。最大高低差は約90メートルに及び、風と砂が創り出す風紋や砂柱は見事です。らくだ遊覧やサンドボードなど、砂丘ならではのアクティビティも楽しむことができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2023/05/20/14/29/dunes-8006655_1280.jpg"
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
                            spotDescription: "因幡の白兎や国譲り神話に登場する大国主大神を祀る古社は、縁結びの神および福の神として親しまれ、全国から参拝者が訪れる人気のある場所です。1744年に建立された本殿は、日本で最も古い大社造りの神社建築の一つで、2013年には60年ぶりの大遷宮が行われました。毎年旧暦10月には八百万の神々が出雲に集まるとされています。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2016/05/20/15/28/izumo-1405172_1280.jpg"
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
                            spotDescription: "元禄13年（1700年）に岡山藩主・池田綱政が建設した岡山後楽園は、日本三名園の一つであり、国の特別名勝にも指定されています。この庭園は四季折々の花が咲き誇り、梅雨時には菖蒲、夏には蓮の花が見られるなど、豊かな自然美が楽しめます。",
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
                            spotDescription: "宮島は日本三景の一つで、その島内には世界文化遺産に登録された嚴島神社や弥山原始林があります。この自然豊かな島では、ニホンジカやタヌキ、野鳥など野生動物も生息しており、観光の魅力としても知られています。宮島のグルメも見逃せません。名物のもみじ饅頭や、牡蠣とあなごの宮島二大グルメは訪れた際に是非とも味わいたい逸品です。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2019/02/02/04/59/o-torii-3970153_1280.jpg"
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
                            spotDescription: "2000年11月3日に開通した角島大橋は、コバルトブルーの海と周囲の島々が作り出す風光明媚な景色で知られ、映画やCMのロケ地としても人気です。無料で通行できるこの橋は、全長1,780メートルと日本屈指の長さを誇ります。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2015/11/07/05/28/japan-1030464_1280.jpg"
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
                            spotDescription: "屋島は源平合戦の古戦場として知られる屋根型の溶岩台地であり、山上には複数の展望台が設けられています。その中でも「談古嶺」「獅子の霊巌」「遊鶴亭」は屋島三大展望台と呼ばれ、瀬戸内海や高松市街の絶景を楽しむことができます。また、四国霊場第84番札所の屋島寺や新屋島水族館など、訪れる価値のあるスポットが多数あります。",
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
                            spotDescription: "鳴門海峡は、鳴門市大毛島と淡路島の間に位置し、潮の干満によって世界三大潮流の一つが発生します。特に春と秋の大潮時には、最大直径約20メートルに及ぶ渦潮が見られ、時速約20キロメートルの潮流が観測されます。この自然現象を間近で見るには、観潮船「わんだーなると」や水面下約1メートルで渦を観察できる水中観潮船「アクアエディ」の利用が推奨されています。",
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
                            spotDescription: "道後温泉は縄文時代から知られ、聖徳太子も訪れたとされる日本最古の温泉です。その象徴である道後温泉本館は国の重要文化財に指定されており、現役の公衆浴場として営業を続けています。",
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
                            spotDescription: "桂浜は高知県を代表する景勝地で、浦戸湾口に位置する弓状の海岸です。ここは「月の名所は桂浜」と讃えられるほどの美しさで、龍頭岬には坂本龍馬の銅像があり、その生涯を紹介する坂本龍馬記念館や桂浜水族館も訪れる価値があります。",
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
                            spotDescription: "太宰府天満宮は、学問の神様として知られる菅原道真を祀る神社で、観光の中心地となっています。境内には歴史的なスポットが多く、軍師官兵衛が晩年を過ごした如水社や、幕末に商人から寄付された麒麟像も見ることができます。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2014/11/27/08/29/dazaifu-547283_1280.jpg"
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
                            spotDescription: "古湯温泉は2200年前に不老長寿の薬を求める秦の始皇帝の命で徐福によって発見されたとされ、その泉温38℃の温もりが「ぬる湯」と呼ばれ親しまれています。この地の湯治街は自然に囲まれ、砂蒸し風呂や離れの造りの宿があり、静かな滞在が楽しめます。",
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
                            spotDescription: "約152万平方メートルに広がる日本最大のテーマパークは、一年中美しい花々が咲き誇る場所で、大人から子どもまで楽しめるアトラクションが揃っています。VRやAR、プロジェクションマッピングといった最先端技術を活用したアトラクションが特徴です。また、夜には世界最大のイルミネーション「光の王国」が園内を華やかに照らします。",
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
                            spotDescription: "標高1,583メートルの活火山、由布岳は人気温泉地・由布院のシンボルであり、「豊後富士」とも親しまれています。この山は『古事記』や『豊後国風土記』に名が記され、由布院盆地や別府湾からその壮大な姿を望むことができます。",
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
                            spotDescription: "江戸時代初期に築かれ、熊本の象徴とされる熊本城は、別名「銀杏城」と呼ばれます。その美しい石垣は広く知られており、2016年の熊本地震で損傷したものの、修復作業が進んでおり、多くの観光客が訪れる名所です。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2013/05/31/16/12/castle-115034_1280.jpg"
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
                            name: "高千穂峡",
                            placeId: "ChIJLwml_t0sRzURix_JnSldeVg",
                            spotDescription: "五ヶ瀬川沿いに形成された高千穂峡は、阿蘇火山の火砕流が冷却されて生じた渓谷で、50～100メートルの柱状節理が壮観な景色を創り出しています。「真名井の滝」を含む数々の自然の造形は見応えがあり、高千穂伝説にちなんだ「鬼八の力石」なども散策の途中で楽しめます。",
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
                            spotDescription: "錦江湾に浮かぶ桜島は、活火山である御岳（北岳）が特徴的な鹿児島のシンボルです。この島は溶岩遊歩道が整備されており、多くの展望所からの絶景や、海沿いの露天風呂「古里温泉郷」、錦江湾を一望できる足湯などが観光客に人気です。",
                            thumbnailImageUrl: "https://cdn.pixabay.com/photo/2015/07/15/16/18/sakura-jima-846461_1280.jpg"
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
                            spotDescription: "首里城公園は沖縄の象徴で、首里城跡や多くの史跡が琉球王国時代の歴史を物語る文化財として点在しています。世界遺産に登録されており、有料区域と無料区域に分かれています。11月には「首里城祭」を始めとする数多くの文化イベントが開催され、訪れるすべての人々に琉球文化を体験させてくれます。",
                            thumbnailImageUrl: ""
                        ),
                    ],
                    context: context
                )
            }
        }
    }
}
