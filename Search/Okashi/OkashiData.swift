//
//  OkashiData.swift
//  Okashi
//
//  Created by 岡本幸二 on 2021/07/31.
//

import Foundation
import UIKit

// お菓子情報の構造体
struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: UIImage
}

// お菓子データ検索用クラス
class OkashiData: ObservableObject {
    
    // JSONデータ
    struct ResultJson: Codable {
        struct Item: Codable {
            // お菓子名称
            let name: String?
            // 掲載URL
            let url: URL?
            // 画像URL
            let image: URL?
        }
        
        let item: [Item]?
    }
    
    // お菓子リスト
    @Published var okashiList: [OkashiItem] = []
    
    func searchOkashi(keyword: String) {
        print(keyword)
        
        // お菓子の検索キーワードをURLにエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)
        
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッションを作成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                // 受け取ったJSONデータを解析し格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                // お菓子情報のチェック
                if let items = json.item {
                    self.okashiList.removeAll()
                    
                    for item in items {
                        if let name = item.name,
                           let link = item.url,
                           let imageUrl = item.image,
                           let imageData = try? Data(contentsOf: imageUrl),
                           let image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal) {
                            
                            // 構造体に格納
                            let okashi = OkashiItem(name: name, link: link, image: image)
                            
                            self.okashiList.append(okashi)
                        }
                    }
                }
            } catch {
                print("エラー")
            }
        })
        
        task.resume()
    }
}
