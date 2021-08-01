//
//  ActivityView.swift
//  Camera
//
//  Created by 岡本幸二 on 2021/07/28.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    // シェアする写真
    let shareItems: [Any]
    
    // Viewの生成
    func makeUIViewController(context: Context) -> UIActivityViewController {
        // シェア機能を生成
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        return controller
    }
    
    // Viewが更新される時に実行
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
        
    }
}

