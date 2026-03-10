//
//  CareAction.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/8.
//

import Foundation
import SQLiteData
import ULID

/// 养护行为类型
@Table("care_actions")
struct CareAction: BaseEntity, Sortable {
    var id: String = ULID().ulidString
    /// 名称，例如：浇水、施肥、修剪、换盆
    var name: String
    /// 可选的图标名称
    var icon: String?

    /// 排序顺序
    var sortOrder: Int = 0
    
    // Auditable + SoftDeletable
    var createdAt: Date = .init()
    var updatedAt: Date = .init()
    var deletedAt: Date?
}

extension CareAction {
    static let notDeleted = Self.where { $0.deletedAt.is(nil) }
}
