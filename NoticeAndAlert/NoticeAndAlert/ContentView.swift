//
//  ContentView.swift
//  NoticeAndAlert
//
//  Created by 岡本幸二 on 2021/07/26.
//

import SwiftUI
import UserNotifications //通知を使うのに必要

struct ContentView: View {
    
    @State var msgText: String = "ローカル通知の発行"
    @State var alertFlag = false
    @State private var showingAlert: AlertItem?
    @State var msg: String = ""
    
    // アラートの状態オブジェクト
    struct AlertItem: Identifiable {
        var id = UUID()
        var alert: Alert
    }
    
    // 通知処理
    func makeNotification() {
        // 通知のタイミングを指定する
        // 繰り返し(repeats)を使う場合はIntervalが60秒以上必要
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // 通知内容を設定
        let content = UNMutableNotificationContent()
        content.title = "通知タイトル"
        content.body = "通知内容"
        content.sound = UNNotificationSound.default //通知音
        
        // 通知タイミングと内容をまとめてリクエストを作成する
        let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)
        
        // 通知を実行
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // ローカル通知
            Button(action: {
                UNUserNotificationCenter.current().requestAuthorization (options: [.alert,.sound]){
                    (granted, _) in
                    
                    if granted { // 通知が許可された時
                        // 通知を実行
                        makeNotification()
                        msgText = "5秒後に発行します。\nホームに戻ってください"
                    } else { // 通知が拒否された時
                        msgText = "通知が拒否されたので発行できません"
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        msgText = "ローカル通知の発行"
                    }
                }
            }){
                Text(msgText)
            }
            
            // アラート
            Button(action: {
                alertFlag = true
            }){
                Text("基本アラート")
            }
            .alert(isPresented: $alertFlag) {
                Alert(title: Text("タイトル"),
                      message: Text("閉じる際にフラグを下げるよ"),
                      dismissButton: .default(Text("フラグを下げる")))
            }
            
            // 複数アラート
            VStack(spacing: 30) {
                
                Button("二つボタンアラート") {
                    showingAlert = AlertItem(
                        alert: Alert(title: Text("二つのボタン"),
                                     message: Text("どちらか選んでね"),
                                     primaryButton: .default(Text("左ボタン")),
                                     secondaryButton: .default(Text("右ボタン"))
                        )
                    )
                }
                
                Button("削除キャンセルアラート") {
                    showingAlert = AlertItem(
                        alert: Alert(title: Text("どちらか選んでね"),
                                     message: Text("どうする"),
                                     // キャンセル用 (青フォント, ボールド, 左に表示される)
                                     primaryButton: .cancel(Text("キャンセル")),
                                     // 破壊的変更用 (赤フォント)
                                     secondaryButton: .destructive(Text("削除"),
                                                                   action: {msg = ""})
                        ))
                }
                
                Button("アラートアクション") {
                    showingAlert = AlertItem(
                        alert: Alert(title: Text("どちらか選んでね"),
                                     message: Text("何食べる?"),
                                     primaryButton: .default(Text("ラーメン"),
                                                             action: {msg = "ラーメンを食べます"}),
                                     secondaryButton: .destructive(Text("カレー"),
                                                                   action: {msg = "カレーを食べます"})
                        
                        ))
                }
                Text(msg)
            }
            .alert(item: $showingAlert) { item in
                item.alert
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
