//
//  ContentView.swift
//  Map
//
//  Created by 岡本幸二 on 2021/07/16.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // 入力中の文字列を保持する
    @State var inputText:String = ""
    // 検索キーワドを保持する状態変数
    @State var dispSearchKey:String = ""
    // マップ種類の最初は標準から
    @State var dispMapType:MKMapType = .standard
    
    var body: some View {
        // 垂直レイアウト
        VStack {
            // テキストフィールド
            TextField("キーワードを入力してください",
                      text: $inputText, onCommit: {
                // 入力が完了したので検索キーワードに設定する
                dispSearchKey = inputText
                // 検索キーワードをデバッグエリアに出力する
                print("入力したキーワード:" + dispSearchKey)
            })
                .padding()
            
            //奥行レイアウト
            ZStack(alignment: .bottomTrailing){
                // マップを表示
                MapView(searchKey: dispSearchKey, mapType: dispMapType)
                
                // マップ種類切り替えボタン
                Button(action: {
                    // mapTypeプロパティー値をトルグ
                    // 標準 -> 航空写真 -> 航空写真 + 標準
                    // -> 3D Flyover -> 3D Flyover + 標準
                    // -> 交通機関
                    if dispMapType == .standard {
                        dispMapType = .satellite
                    } else if dispMapType == .satellite {
                        dispMapType = .hybrid
                    } else if dispMapType == .hybrid {
                        dispMapType = .satelliteFlyover
                    } else if dispMapType == .satelliteFlyover {
                        dispMapType = .hybridFlyover
                    } else if dispMapType == .hybridFlyover {
                        dispMapType = .mutedStandard
                    } else {
                        dispMapType = .standard
                    }
                }) {
                    // マップアイコン表示
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0,
                               height: 35.0,
                               alignment: .leading)
                }
                // 右の余白を20空ける
                .padding(.trailing, 20.0)
                // 下の余白を30空ける
                .padding(.bottom, 30.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
