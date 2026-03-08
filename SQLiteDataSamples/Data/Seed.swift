//
//  PreviewDatabase.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

private func _getPlantId(byName name: String) -> Plant.ID? {
    return PreviewData.plants.first { $0.name == name }?.id
}

private func _getCategoryId(byName name: String) -> Category.ID? {
    return PreviewData.categories.first { $0.name == name }?.id
}

extension DatabaseWriter {
    func seed() throws {
        try write { db in
            // Seed categories
            for category in PreviewData.categories {
                try Category.insert { category }
                    .execute(db)
            }

            // Seed plants
            for plant in PreviewData.plants {
                try Plant.insert { plant }.execute(db)
            }

            // Seed plant-category relations
            for (categoryName, plantNames) in PreviewData.plantCategoryRelations {
                guard let categoryId = _getCategoryId(byName: categoryName) else { continue }
                for plantName in plantNames {
                    guard let plantId = _getPlantId(byName: plantName) else { continue }
                    try PlantCategoryRelation.insert {
                        PlantCategoryRelation(plantId: plantId, categoryId: categoryId)
                    }
                    .execute(db)
                }
            }
        }
    }
}

@discardableResult
func setupPreviewEnvironment() -> EmptyView {
    // Prepare database and seed
    prepareDependencies {
        $0.defaultDatabase = try! appDatabase()
        try! $0.defaultDatabase.seed()
    }

    return EmptyView()
}
