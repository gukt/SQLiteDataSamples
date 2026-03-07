//
//  PreviewDatabase.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

extension DatabaseWriter {
    func seed() throws {
        try write { db in
            // Seed categories
            var categoryMap: [String: String] = [:]
            for category in PreviewData.categories {
                let insertedCategory = try Category.insert {
                    Category(name: category.name)
                }
                .returning()
                .execute(db)
                categoryMap[insertedCategory.name] = insertedCategory.id.uuidString
            }

            // Seed plants
            var plantMap: [String: String] = [:]
            for plant in PreviewData.plants {
                let insertedPlant = try Plant.insert {
                    Plant(name: plant.name, isStarred: plant.isStarred)
                }
                .returning()
                .execute(db)
                plantMap[insertedPlant.name] = insertedPlant.id
            }

            // Seed plant-category relations
            for (categoryName, plantNames) in PreviewData.plantCategoryRelations {
                guard let categoryId = categoryMap[categoryName] else { continue }
                
                for plantName in plantNames {
                    guard let plantId = plantMap[plantName] else { continue }
                    
                    try PlantCategoryRelation.insert {
                        PlantCategoryRelation(plantId: plantId, categoryId: categoryId)
                    }
                    .execute(db)
                }
            }
        }
    }
}

@ViewBuilder
func setupPreviewEnvironment() -> EmptyView {
    // TODO: seed here

    return EmptyView()
}
