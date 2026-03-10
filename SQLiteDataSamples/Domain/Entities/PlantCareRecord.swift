//
//  PlantCareRecord.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/8.
//

import Foundation
import SQLiteData
import ULID

/// 每日养护记录
///
/// 养护记录主表。每个植物的每种养护行为（CareAction），每天仅对应一条记录。
@Table("plant_care_records")
struct PlantCareRecord: BaseEntity {
    var id: String = ULID().ulidString
    /// 所属植物 ID
    var plantId: Plant.ID
    /// 所属养护行为 ID
    var careActionId: CareAction.ID
    /// 养护行为执行时间（用户可能补记，所以和 createdAt 可能不同）
    var performedAt: Date = .init()
    /// 用户笔记（可选）
    var note: String?

    // Auditable + SoftDeletable
    var createdAt: Date = .init()
    var updatedAt: Date = .init()
    var deletedAt: Date? = nil

    /// 默认情况下，每个 Table 都有一个默认属性 all，表示选择该表的所有行
    /// 这里我们修改其默认行为：过滤掉软删除的行
    /// 如果想要查询中包含所有的行（包括已被软删除的行），使用 Entity.unscoped
    static let all = Self.where { $0.isNotDeleted }
}

/// 扩展可重用的表查询辅助函数
/// 参考：
/// - https://swiftpackageindex.com/pointfreeco/swift-structured-queries/~/documentation/structuredqueriescore/querycookbook#Reusable-table-queries
/// - https://swiftpackageindex.com/pointfreeco/swift-structured-queries/~/documentation/structuredqueriescore/querycookbook#Default-scopes
extension PlantCareRecord {
    /// 不包含软删除的记录
    /// 由于我们覆盖 all 的默认行为，并使用 unscoped 查询所有行，因此我们不再需要提供 notDeleted 辅助函数
    /// static let notDeleted = Self.where { $0.deletedAt.is(nil) }

    /// 默认情况下，每个 Table 都有一个默认属性 all，表示选择该表的所有行
    /// 这里我们修改其默认行为：过滤掉软删除的行
    /// 如果想要查询中包含所有的行（包括已被软删除的行），使用 Entity.unscoped
//    static let all = Self.where { $0.deletedAt.is(nil) }

    // /// 今天执行的养护记录
    // /// 内部使用表列查询辅助函数 performedToday
    // static let performedToday = Self.where { $0.performedToday }
}

/// 扩展表列查询辅助函数
/// 参考：https://swiftpackageindex.com/pointfreeco/swift-structured-queries/~/documentation/structuredqueriescore/querycookbook#Reusable-column-queries
extension PlantCareRecord.TableColumns {
    // // 今天执行的养护记录
    // var performedToday: some QueryExpression<Bool> {
    //     let startOfDay = Calendar.current.startOfDay(for: Date())
    //     let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
    //     return performedAt >= startOfDay && performedAt < endOfDay
    // }

    var isDeleted: some QueryExpression<Bool> {
        deletedAt.isNot(nil)
    }

    var isNotDeleted: some QueryExpression<Bool> {
        deletedAt.is(nil)
    }
}
