//
//  SQLiteDataSamplesApp.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

@main
struct SQLiteDataSamplesApp: App {
    init() {
        print("正在设置数据库连接.")
        // 设置数据库连接
        // 在应用生命周期内，只能准备一次数据库连接，所以最好在应用启动后尽早完成
        prepareDependencies {
            $0.defaultDatabase = try! appDatabase()
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
