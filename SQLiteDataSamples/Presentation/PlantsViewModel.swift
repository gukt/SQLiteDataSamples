//
//  PlantsView.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData
import SwiftUI

@Observable
class PlantsViewModel {
    @ObservationIgnored
    @FetchAll var categories: [Category]
}
