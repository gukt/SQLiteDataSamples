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
    var careActionId: CareAction.ID
    /// 养护发生时间（用户可能补记，所以和 createdAt 可能不同）
    var recordedAt: Date = .init()
    /// 用户笔记（可选）
    var note: String?

    // Auditable + SoftDeletable
    var createdAt: Date = .init()
    var updatedAt: Date = .init()
    var deletedAt: Date?
}
