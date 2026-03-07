//
//  PlantsView.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

struct PlantsView: View {
    @FetchAll var plants: [Plant]
    @FetchAll var categories: [Category]

    var body: some View {
        Text("Plants View")

        List {
            ForEach(plants) { plant in
                Text(plant.name)
            }
            
            Section("Categories") {
                ForEach(categories) { category in
                    Text(category.name)
                }
            }
        }
    }
}

#Preview {
    prepareDependencies {
        $0.defaultDatabase = try! appDatabase()
        try! $0.defaultDatabase.seed()
    }

    return PlantsView()
}
