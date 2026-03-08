//
//  Plant.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import Foundation
import SQLiteData
import ULID

@Table("plants")
struct Plant: BaseEntity {
    var id: String = ULID().ulidString
    var name: String
    var isStarred = false
    
    // Auditable + SoftDeletable
    var createdAt: Date = .init()
    var updatedAt: Date = .init()
    var deletedAt: Date?
}

extension Plant {
    /// 该函数会自动应用一个 where 子句，以过滤掉已删除的列表和提醒
    ///
    /// 参考：https://swiftpackageindex.com/pointfreeco/swift-structured-queries/~/documentation/structuredqueriescore/querycookbook
    static let notDeleted = Self.where { $0.deletedAt.isNot(nil) }
}
