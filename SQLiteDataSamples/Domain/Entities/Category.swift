//
//  Plant.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import Foundation
import SQLiteData
import ULID

@Table("categories")
struct Category: BaseEntity {
    var id: String = ULID().ulidString
    var name: String

    // Auditable + SoftDeletable
    var createdAt: Date = .init()
    var updatedAt: Date = .init()
    var deletedAt: Date?
}

extension Category {
    static let notDeleted = Self.where { $0.deletedAt.is(nil) }
}
