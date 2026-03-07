//
//  Plant.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import Foundation
import SQLiteData

@Table("plants")
struct Plant: Identifiable {
    var id: UUID = .init()
    var name: String
    var isStarred = false
    var deletedAt: Date = .init()
}
