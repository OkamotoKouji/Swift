//
//  ContentView.swift
//  Camera
//
//  Created by 岡本幸二 on 2021/07/28.
//

import SwiftUI

struct ContentView: View {
    
    // 撮影した写真を保存する変数
    @State var captureImage: UIImage? = nil
    // 撮影画面のシート
    @State var isShowSheet = false
    // フォトライブラリーかカメラを保持する変数
    @State var isPhotolibrary = false
    // ActionShee
    @State var isShowAction = false
    
    var body: some View {
        VStack {
            
            // カメラボタン
            Button(action: {
                // 撮影写真の初期化
                captureImage = nil
                // 使用可能
                isShowAction = true
                
            }) {
                Text("カメラ")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            // カメラのSheetを表示
            .sheet(isPresented: $isShowSheet) {
                
                if let unwrapCaptureImage = captureImage {
                    // 撮影した写真がある場合エフェクト画面を表示
                    EffectView(isShowSheet: $isShowSheet,
                               captureImage: unwrapCaptureImage)
                } else {
                    // フォトライブラリが選択された
                    if isPhotolibrary {
                        PHPickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                    } else {
                        ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                    }
                }
            }
            .actionSheet(isPresented: $isShowAction) {
                ActionSheet(title: Text("確認"),
                            message: Text("選択してください"),
                            buttons: [
                                
                                .default(Text("カメラ"),action: {
                                    isPhotolibrary = false
                                    // カメラが使用可能かチェックする
                                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                        isShowSheet = true
                                    }
                                }),
                                
                                .default(Text("フォトライブラリー"),action: {
                                    isPhotolibrary = true
                                    isShowSheet = true
                                }),
                                .cancel()
                            ])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
