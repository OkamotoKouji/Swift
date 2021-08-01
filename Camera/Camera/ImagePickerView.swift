//
//  ImagePickerView.swift
//  Camera
//
//  Created by 岡本幸二 on 2021/07/28.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    // UiImagePickerControllerが表示されてるか
    @Binding var isShowSheet: Bool
    // 撮影した写真
    @Binding var captureImage: UIImage?
    
    // Coordinatorでコントローラのdelegateを管理
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        // ImagePickerView型の変数を用意
        let parent: ImagePickerView
        
        // 初期化処理
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        // 撮影終了時の処理
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // 撮影した写真をcaptureImageに保存
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage {
                parent.captureImage = originalImage
            }
            
            // sheetを閉じる
            parent.isShowSheet = true
        }
        
        // キャンセル時の処理
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet = false
        }
    }
     
    // Coordinatorを生成
    func makeCoordinator() -> Coordinator {
         Coordinator(self)
    }
    
    // Viewを生成するときに実行
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        // インスタンス生成
        let myImagePickerController = UIImagePickerController()
        // カメラの設定
        myImagePickerController.sourceType = .camera
        // delegate設定
        myImagePickerController.delegate = context.coordinator
        
        return myImagePickerController
    }
    
    // Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}


