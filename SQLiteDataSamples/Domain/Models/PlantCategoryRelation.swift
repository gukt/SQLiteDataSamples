//
//  PlantCategory.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import Foundation
import SQLiteData

@Table("plant_category_relations")
struct PlantCategoryRelation: Identifiable {
    var id: String = UUID().uuidString
    var plantId: String
    var categoryId: String
    var createdAt: Date = .init()
}
