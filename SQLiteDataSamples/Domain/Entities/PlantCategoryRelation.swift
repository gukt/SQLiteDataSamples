//
//  PlantCategory.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import Foundation
import SQLiteData
import ULID

@Table("plant_category_relations")
struct PlantCategoryRelation: Identifiable {
    var id: String = ULID().ulidString
    var plantId: Plant.ID
    var categoryId: Category.ID
    var createdAt: Date = .init()
}
