//
//  PlantPicker.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

struct PlantPickerView: View {
    @FetchAll var plants: [Plant]
    @Dependency(\.context) private var context

    var body: some View {
        Text("\(context)")
        List(plants) { plant in
            HStack {
                Text(plant.name)
                Spacer()
                Label("Selected", systemImage: "checkmark")
                    .labelStyle(.iconOnly)
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}

#Preview {
    setupPreviewEnvironment()
    PlantPickerView()
}
