//
//  PlantsView.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

struct PlantsView: View {
    @FetchAll(Plant.where(\.isStarred).order(by: \.name))
    var plants: [Plant]

    @FetchAll(
        #sql("""
            SELECT \(Plant.columns)
            FROM \(Plant.self)
            ORDER BY \(Plant.createdAt) DESC
        """)
    )
    var plants2: [Plant]

    @FetchAll var categories: [Category]
    @State var viewModel = PlantsViewModel()
    @State var showingStarred = false

    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: $showingStarred) {
                    Label("Starred", systemImage: "star")
                }
                List(plants2) { plant in
                    HStack {
                        Text(plant.name)
                        if plant.isStarred {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }
        }

//        LazyVStack {
        ////                Toggle(isOn: $showingStarred) {
        ////                    Label("星标", systemImage: "star")
        ////                }
//
//            List(plants) { plant in
//                HStack {
//                    Text(plant.name)
//                    if plant.isStarred {
//                        Image(systemName: "star.fill")
//                            .foregroundStyle(.yellow)
//                    }
//                }
//
//                Section("Categories") {
//                    ForEach(viewModel.categories) { category in
//                        Text(category.name)
//                    }
//                }
//            }
//        }
    }
}

#Preview {
    prepareDependencies {
        $0.defaultDatabase = try! appDatabase()
        try! $0.defaultDatabase.seed()
    }

    return PlantsView()
}
