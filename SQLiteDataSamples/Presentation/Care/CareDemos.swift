//
//  CareDemos.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/9.
//

import SQLiteData
import SwiftUI

/// 参考：https://github.com/pointfreeco/sqlite-data/blob/341468a6/Sources/SQLiteData/Documentation.docc/Articles/Fetching.md
struct CareDemos1: View {
    // 最原始的写法
    // @FetchAll
    // private var careActions: [CareAction]

    // 使用 where 过滤
    // 如果不加上这个软删除过滤，则删除后刷新列表，删除的项目又会出现
    // 结果符合期望，但逻辑错误，需要排除软删除
    // @FetchAll(CareAction.where { $0.deletedAt.is(nil) })
    // private var careActions: [CareAction]

    // 使用 Reusable Table Queries 辅助函数
    // @FetchAll(CareAction.notDeleted)
    // private var careActions: [CareAction]

    // 按 sortOrder 正序排序
    // @FetchAll(CareAction.notDeleted.order(by: \.sortOrder))
    // private var careActions: [CareAction]

    // 按 sortOrder 倒序排序
    // desc 还可以指定 nulls 排列在前面还是后面 desc(nulls: .first)
    @FetchAll(CareAction.notDeleted.order { $0.sortOrder.desc() })
    private var careActions: [CareAction]

    @Dependency(\.defaultDatabase) private var database

    var body: some View {
        List {
            ForEach(careActions) { careAction in
                Text("\(careAction.name)")
            }
            .onDelete(perform: deleteActions)
        }
    }

    private func deleteActions(at offsets: IndexSet) {
        let careActionsToDelete = offsets.map { careActions[$0] }
        print("careActionsToDelete: \(careActionsToDelete)")

        try? database.write { db in
            for careAction in careActionsToDelete {
                var updated = careAction
                updated.softDelete()
                try CareAction.update(updated).execute(db)
            }
        }
    }
}

// 定义一个 Selection 类型来承载 join 查询的结果
@Selection
struct CareRecordWithAction: Identifiable {
    let id: PlantCareRecord.ID
    let careActionId: String
    let careActionName: String
    let careActionColor: String?
    let note: String?
}

struct CareDemos2: View {
    @Dependency(\.defaultDatabase) private var database

    // @FetchAll
    // private var careRecords: [PlantCareRecord]

    // SELECT "plant_care_records"."id" AS "id", "care_actions"."id" AS "careActionId", "care_actions"."name" AS "careActionName", "care_actions"."icon" AS "careActionColor", "plant_care_records"."note" AS "note" FROM "plant_care_records" JOIN "care_actions" ON ("plant_care_records"."careActionId") = ("care_actions"."id") WHERE (("plant_care_records"."deletedAt") IS (NULL)) AND ((("plant_care_records"."performedAt") >= ('2026-03-09 16:00:00.000')) AND (("plant_care_records"."performedAt") < ('2026-03-10 16:00:00.000'))) AND (("care_actions"."deletedAt") IS (NULL)) ORDER BY "care_actions"."name" DESC
    @FetchAll(
        PlantCareRecord.all
//            .where { $0.performedToday }
            .join(CareAction.notDeleted) { $0.careActionId.eq($1.id) }
            .order { $1.name.desc() }
            .select {
                CareRecordWithAction.Columns(
                    id: $0.id,
                    careActionId: $1.id, // $1 表示 CareAction
                    careActionName: $1.name,
                    careActionColor: $1.icon,
                    note: $0.note // $0 表示 PlantCareRecord
                )
            }
    )
    private var careRecords

    var body: some View {
        List {
            ForEach(careRecords) { record in
                VStack(alignment: .leading) {
                    Text("\(record.careActionName)")
                    Text(record.note ?? "None")
                        .foregroundStyle(.secondary)
                }
            }
            .onDelete(perform: deleteActions)
        }
    }

    private func deleteActions(at offsets: IndexSet) {
        let idsToDelete = offsets.map { careRecords[$0].id }

//        try? database.write { db in
//            let now = Date()
//            // 批量软删除
//            try PlantCareRecord
//                .where { $0.id.in(idsToDelete) }
//                .update {
//                    $0.deletedAt = now
//                    $0.updatedAt = now
//                }
//                .execute(db)
//        }

        try? database.write { db in
            // 先查询出需要删除的记录
            let recordsToDelete = try PlantCareRecord
                .where { $0.id.in(idsToDelete) }
                .fetchAll(db)

            // 逐个软删除
            for var record in recordsToDelete {
                record.softDelete()
                try PlantCareRecord.update(record).execute(db)
            }
        }
    }
}

#Preview {
    setupPreviewEnvironment()
    CareDemos2()
}
