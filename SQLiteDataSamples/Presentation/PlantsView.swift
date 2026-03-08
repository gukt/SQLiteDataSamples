//
//  PlantsView.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

struct PlantsView: View {
    @FetchAll(Plant.notDeleted.where(\.isStarred).order(by: \.name))
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
    }
}

#Preview {
    setupPreviewEnvironment()
    PlantsView()
}
