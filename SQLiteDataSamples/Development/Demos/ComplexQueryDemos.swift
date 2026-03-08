//
//  CategoriesView.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

struct ComplexQueryDemos1: View {
    // SELECT "categories"."id", "categories"."name", "categories"."deletedAt" FROM "categories" GROUP BY "categories"."id"
    @FetchAll(
        Category
            .group(by: \.id)
    )
    private var items
    
    @FetchAll(
        Plant.all
            .select(\.id)
    )
    private var bbb
    
    var body: some View {
        ForEach(items) { item in
            Text(item.name)
        }
    }
}

struct ComplexQueryDemos2: View {
    // SELECT "plant_category_relations"."id", "plant_category_relations"."plantId", "plant_category_relations"."categoryId", "plant_category_relations"."createdAt" FROM "plant_category_relations" GROUP BY "plant_category_relations"."plantId"
    @FetchAll(
        PlantCategoryRelation
            .group(by: \.plantId)
    )
    private var items
    
    var body: some View {
        ForEach(items) { item in
            Text(item.id)
        }
    }
}

// MARK: - Previews

#Preview("demo1") {
    prepareDependencies {
        $0.defaultDatabase = try! appDatabase()
        try! $0.defaultDatabase.seed()
    }
    
    return ComplexQueryDemos2()
}
