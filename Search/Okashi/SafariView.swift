//
//  SafariView.swift
//  Okashi
//
//  Created by 岡本幸二 on 2021/07/31.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    // 表示URL
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

