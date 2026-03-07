//
//  AppDatabase.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import OSLog
import SQLiteData

/// 此函数提供一个依赖于上下文的数据库，
/// 例如，在预览和测试中，它将提供独特的临时数据库，不会与实时应用程序的数据库发生冲突。
///
/// 返回的是一个any DatabaseWriter。
/// 这使我们能够从中返回 DatabaseQueue 或 DatabasePool
func appDatabase() throws -> any DatabaseWriter {
    /// 来自于 Swift Dependencies 库，用于检查应用运行的环境：正式、预览或测试
    @Dependency(\.context) var context
    var configuration = Configuration()

    #if DEBUG
    configuration.prepareDatabase { db in
        db.trace(options: .profile) {
            if context == .preview {
                // 打印跟踪事件的描述，其中绑定参数已展开
                print("\($0.expandedDescription)")
            } else {
                logger.debug("\($0.expandedDescription)")
            }
        }
    }
    #endif

    // 创建数据库连接
    let database = try defaultDatabase(configuration: configuration)
    logger.info("open '\(database.path)'")

    // 迁移数据库
    try _migrate(database)

    return database
}

private func _migrate(_ database: any DatabaseWriter) throws {
    logger.info("正在迁移数据库...")
    var migrator = DatabaseMigrator()
    #if DEBUG
    // 检测到迁移定义有变化时，从头重新创建整个数据库
    migrator.eraseDatabaseOnSchemaChange = true
    #endif

    migrator.registerMigration("init_db") { db in
        // 执行 SQL 创建相关表
        try #sql("""
            CREATE TABLE "plants" (
                id TEXT PRIMARY KEY NOT NULL,
                name TEXT NOT NULL,
                isStarred INTEGER NOT NULL DEFAULT 0,
                createdAt TEXT,
                updatedAt TEXT,
                deletedAt TEXT
            ) STRICT
        """)
        .execute(db)

        // 创建分类表
        try #sql("""
        CREATE TABLE "categories" (
            id TEXT PRIMARY KEY NOT NULL,
            name TEXT NOT NULL,
            deletedAt TEXT
        ) STRICT
        """)
        .execute(db)

        // 创建植物和分类的关系表
        try #sql("""
        CREATE TABLE "plant_category_relations" (
            id TEXT PRIMARY KEY NOT NULL,
            plantId TEXT NOT NULL,
            categoryId TEXT NOT NULL,
            createdAt TEXT,
            FOREIGN KEY (plantId) REFERENCES plants(id) ON DELETE CASCADE,
            FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
        ) STRICT
        """)
        .execute(db)

        // 为关系表创建索引以提高查询性能
        try #sql("""
        CREATE INDEX idx_plant_category_relations_plantId ON plant_category_relations(plantId)
        """)
        .execute(db)

        try #sql("""
        CREATE INDEX idx_plant_category_relations_categoryId ON plant_category_relations(categoryId)
        """)
        .execute(db)
    }
    try migrator.migrate(database)
}

private let logger = Logger(subsystem: "MyApp", category: "Database")
