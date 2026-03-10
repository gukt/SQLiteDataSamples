//
//  PreviewData+Plants.swift
//  GreenTime
//
//  Preview 测试数据 - 植物实体
//  仅用于 SwiftUI Preview，不影响真实数据
//

import Foundation

#if DEBUG

/// Preview 测试数据命名空间
enum PreviewData {}

// MARK: - Categories

extension PreviewData {
    static let categories = [
        Category(name: "阳台"),
        Category(name: "庭院"),
        Category(name: "办公室")
    ]

    static let defaultCategory = categories[0]
}

// MARK: - Plant Category Relations

extension PreviewData {
    /// 植物和分类的关系映射
    /// 格式：[分类名称: [植物名称]]
    static let plantCategoryRelations: [String: [String]] = [
        "阳台": ["吊兰", "绿萝", "常春藤", "白掌", "龟背竹"],
        "庭院": ["龙沙宝石", "长寿花", "蝴蝶兰"],
        "办公室": ["虎皮兰", "发财树", "橡皮树", "龟背竹"],
    ]
}

// MARK: - Plants

extension PreviewData {
    static let plants = [
        Plant(
            name: "吊兰",
            isStarred: true,
            createdAt: 30.days.ago,
            updatedAt: 30.days.ago
        ),
        Plant(
            name: "龟背竹",
            createdAt: 45.days.ago,
            updatedAt: 45.days.ago
        ),
        Plant(
            name: "虎皮兰",
            createdAt: 90.days.ago,
            updatedAt: 90.days.ago
        ),
        Plant(
            name: "龙沙宝石",
            createdAt: 70.days.ago,
            updatedAt: 70.days.ago
        ),
        Plant(
            name: "常春藤",
            createdAt: 40.days.ago,
            updatedAt: 40.days.ago
        ),
        Plant(
            name: "绿萝",
            createdAt: 33.days.ago,
            updatedAt: 33.days.ago
        ),
        Plant(
            name: "长寿花",
            createdAt: 120.days.ago,
            updatedAt: 120.days.ago
        ),
        Plant(
            name: "橡皮树",
            createdAt: 200.days.ago,
            updatedAt: 200.days.ago
        ),
        Plant(
            name: "蝴蝶兰",
            isStarred: true,
            createdAt: 60.days.ago,
            updatedAt: 60.days.ago
        ),
        Plant(
            name: "发财树",
            createdAt: 11.days.ago,
            updatedAt: 11.days.ago
        ),
        Plant(
            name: "白掌",
            createdAt: 9.days.ago,
            updatedAt: 9.days.ago
        ),
    ]

    static let defaultPlant = plants[0]
}

// MARK: - Care Actions

extension PreviewData {
    static let careActions: [CareAction] = [
        CareAction(name: "浇水", icon: "water"),
        CareAction(name: "施肥", icon: "fertilizer"),
        CareAction(name: "修剪", icon: "prune"),
        CareAction(name: "换盆", icon: "pot"),
    ]
}

// MARK: - Plant Care Records

extension PreviewData {
    static let plantCareRecords: [PlantCareRecord] = [
        PlantCareRecord(
            plantId: PreviewData.defaultPlant.id, 
            careActionId: PreviewData.careActions[0].id, 
            performedAt: Date(),
            note: "今天浇了水，浇了半桶水"
        ),
        PlantCareRecord(
            plantId: PreviewData.defaultPlant.id, 
            careActionId: PreviewData.careActions[1].id, 
            performedAt: Date(),
            note: "施了 10 克有机肥"
        ),
        PlantCareRecord(
            plantId: PreviewData.defaultPlant.id, 
            careActionId: PreviewData.careActions[2].id, 
            performedAt: Date(),
            note: "把枯叶剪掉了"
        ),
        PlantCareRecord(
            plantId: PreviewData.defaultPlant.id, 
            careActionId: PreviewData.careActions[3].id, 
            performedAt: Date(),
            note: "换了盆，换了新的盆土"
        ),
    ]
}

#endif
