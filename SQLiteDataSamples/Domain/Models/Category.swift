//
//  Plant.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import Foundation
import SQLiteData

@Table("categories")
struct Category: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var deletedAt: Date = .init()
}
