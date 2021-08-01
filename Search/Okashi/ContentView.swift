//
//  ContentView.swift
//  Okashi
//
//  Created by 岡本幸二 on 2021/07/31.
//

import SwiftUI

struct ContentView: View {
    // OkashiDataを参照する状態変数
    @ObservedObject var okashiDataList = OkashiData()
    // 検索ワード
    @State var inputText = ""
    // SafariViewの表示変数
    @State var showSafari = false
    
    var body: some View {
        VStack {
            TextField("キーワードを入力してください", text: $inputText, onCommit: {
                // 入力完了後に検索する
                okashiDataList.searchOkashi(keyword: inputText)
            })
            .padding()
            
            // リストを表示する
            List(okashiDataList.okashiList) { okashi in
                
                Button(action: {
                    showSafari.toggle()
                }) {
                    // リストに表示
                    HStack {
                        Image(uiImage: okashi.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                        
                        Text(okashi.name)
                    }
                }
                .sheet(isPresented: self.$showSafari, content: {
                    SafariView(url: okashi.link)
                        .edgesIgnoringSafeArea(.bottom)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
