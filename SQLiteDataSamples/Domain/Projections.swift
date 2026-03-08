//
//  Projections.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//
import SQLiteData

enum Projections {
    @Selection
    struct CategoryWithCount: Identifiable {
        let category: Category
        let plantCount: Int
        
        var id: String { category.id }
    }
}
