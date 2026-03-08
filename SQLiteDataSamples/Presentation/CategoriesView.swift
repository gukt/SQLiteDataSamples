//
//  CategoriesView.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

struct CategoriesView: View {
    @FetchAll private var categories: [Category]

    // 直接全部用 SQL 的方式，会自动组装成 Projections.CategoryWithCount 类型
    @FetchAll(
        #sql("""
            SELECT c.*, COUNT(*) AS count
            FROM \(Category.self) c
            LEFT JOIN \(PlantCategoryRelation.self) pcr ON c.id = pcr.categoryId
            GROUP BY c.id
            ORDER BY c.name
        """)
    )
    private var categoriesWithCount: [Projections.CategoryWithCount]

    // 使用 SQL 的方式，手动组装成 Projections.CategoryWithCount 类型
    @FetchAll(
        Category
            .group(by: \.id)
            .leftJoin(PlantCategoryRelation.all) { $0.id.eq($1.categoryId) }
            .select {
                Projections.CategoryWithCount.Columns(
                    category: $0,
                    plantCount: $1.count()
                )
            }
    )
    private var categoriesWithCount2

    @FetchAll(
        Category
            .group(by: \.id)
            .leftJoin(PlantCategoryRelation.all) { $0.id.eq($1.categoryId) }
            .select {
                $1.count()
            }
    )
    private var categoriesWithCount3

    @FetchAll(
        Category
            .group(by: \.id)
    )
    private var aaa

    @State private var viewModel = CategoriesViewModel()
    @State private var selectedCategory: Category?

    var body: some View {
        List {
            ForEach(aaa) { category in
                Button {
                    selectedCategory = category
                } label: {
                    Text(category.name)
                }
            }

//            ForEach(categories) { category in
//                Button {
//                    selectedCategory = category
//                } label: {
//                    Text(category.name)
//                }
//            }
//
//            Section("CategoryWithCount") {
//                ForEach(categoriesWithCount) { item in
//                    Button {
//                        selectedCategory = item.category
//                    } label: {
//                        HStack {
//                            Text(item.category.name)
//                            Spacer()
//                            Text("\(item.plantCount)")
//                        }
//                    }
//                }
//            }
        }
        .sheet(item: $selectedCategory) { category in
            Text(category.name)
        }
    }
}

#Preview {
    prepareDependencies {
        $0.defaultDatabase = try! appDatabase()
        try! $0.defaultDatabase.seed()
    }

    return CategoriesView()
}
