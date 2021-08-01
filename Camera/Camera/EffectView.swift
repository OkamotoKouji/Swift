//
//  EffectView.swift
//  Camera
//
//  Created by 岡本幸二 on 2021/07/29.
//

import SwiftUI

let filterArray = ["CIPhotoEffectMono",
                   "CIPhotoEffectChrome",
                   "CIPhotoEffectFade",
                   "CIPhotoEffectInstant",
                   "CIPhotoEffectNoir",
                   "CIPhotoEffectProcess",
                   "CIPhotoEffectTonal",
                   "CIPhotoEffectTransfer",
                   "CISepiaTone"
]

var filterSelectNumber = 0

struct EffectView: View {
    // エフェクトシートの表示変数
    @Binding var isShowSheet: Bool
    // 撮影した写真
    let captureImage: UIImage
    // 表示する写真
    @State var showImage: UIImage?
    // シェア画面の管理変数
    @State var isShowActitivity = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if let unwrapShowImage = showImage {
                Image(uiImage: unwrapShowImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            // エフェクトボタン
            Button(action: {
                // フィルタ名を配列から取得
                let filterName = filterArray[filterSelectNumber]
                
                filterSelectNumber += 1
                if filterSelectNumber == filterArray.count {
                    filterSelectNumber = 0
                }
                
                // 元々の画像の回転角度を取得
                let rotate = captureImage.imageOrientation
                // UIImageからCIImageに変換
                let inputImage = CIImage(image: captureImage)
                
                guard let effectFilter = CIFilter(name: filterName) else {
                    return
                }
                
                // フィルタ加工パラメータの初期化
                effectFilter.setDefaults()
                // インスタンスに加工する画像を設定
                effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
                // フィルタ加工の情報を作成
                guard let outputImage = effectFilter.outputImage else {
                    return
                }
                // CIContextのインスタンス
                let ciContext = CIContext(options: nil)
                
                // 加工画像を描画し、CGImage形式の画像を取得
                guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                    return
                }
                
                // 加工画像を回転角度を設定し、UIImage形式に戻す
                showImage = UIImage(cgImage: cgImage,scale: 1.0, orientation: rotate)
                
            }) {
                Text("エフェクト")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            
            // シェアボタン
            Button(action: {
                isShowActitivity = true
            }){
                Text("シェア")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .sheet(isPresented: $isShowActitivity) {
                ActivityView(shareItems: [showImage!.resize()!])
            }
            .padding()
            
            // 閉じるボタン
            Button(action: {
                isShowSheet = false
            }){
                Text("閉じる")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        // 表示される際に１度だけ実行される
        .onAppear {
            showImage = captureImage
        }
        
    }
}

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(
            isShowSheet: Binding.constant(true),
            captureImage: UIImage(named: "preview_use")!
        )
    }
}
