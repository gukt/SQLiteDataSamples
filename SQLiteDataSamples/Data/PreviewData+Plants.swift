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

// MARK: - Plants

extension PreviewData {
    private static let plantIdPrefix = "preview_plant"

    static let plants: [Plant] = [
        Plant(
            id: "\(plantIdPrefix)_1",
            name: "吊兰",
            description: "吊兰是一种常见的室内观叶植物，叶片细长，四季常绿，具有很强的空气净化能力。",
            isStarred: true,
            createdAt: 30.days.ago,
            updatedAt: 30.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_2",
            name: "蝴蝶兰",
            description: "蝴蝶兰花形优美，花色艳丽，是非常受欢迎的观赏花卉。",
            isStarred: true,
            createdAt: 60.days.ago,
            updatedAt: 60.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_3",
            name: "龟背竹",
            description: "龟背竹叶片宽大，形状独特，是热带雨林的代表植物之一。",
            isStarred: false,
            createdAt: 45.days.ago,
            updatedAt: 45.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_4",
            name: "虎皮兰",
            isStarred: false,
            createdAt: 90.days.ago,
            updatedAt: 90.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_5",
            name: "仙人球",
            isStarred: false,
            createdAt: 15.days.ago,
            updatedAt: 15.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_6",
            name: "仙人掌",
            isStarred: false,
            createdAt: 20.days.ago,
            updatedAt: 20.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_7",
            name: "多肉",
            isStarred: false,
            createdAt: 25.days.ago,
            updatedAt: 25.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_8",
            name: "月季",
            isStarred: true,
            createdAt: 70.days.ago,
            updatedAt: 70.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_9",
            name: "茉莉",
            isStarred: false,
            createdAt: 55.days.ago,
            updatedAt: 55.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_10",
            name: "常春藤",
            isStarred: false,
            createdAt: 40.days.ago,
            updatedAt: 40.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_11",
            name: "富贵竹",
            isStarred: false,
            createdAt: 10.days.ago,
            updatedAt: 10.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_12",
            name: "绿萝",
            isStarred: false,
            createdAt: 33.days.ago,
            updatedAt: 33.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_13",
            name: "紫竹",
            isStarred: false,
            createdAt: 77.days.ago,
            updatedAt: 77.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_14",
            name: "文竹",
            isStarred: false,
            createdAt: 22.days.ago,
            updatedAt: 22.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_15",
            name: "长寿花",
            isStarred: false,
            createdAt: 120.days.ago,
            updatedAt: 120.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_16",
            name: "橡皮树",
            isStarred: false,
            createdAt: 200.days.ago,
            updatedAt: 200.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_17",
            name: "发财树",
            isStarred: false,
            createdAt: 11.days.ago,
            updatedAt: 11.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_18",
            name: "玉树",
            isStarred: false,
            createdAt: 99.days.ago,
            updatedAt: 99.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_19",
            name: "金花茶",
            isStarred: false,
            createdAt: 80.days.ago,
            updatedAt: 80.days.ago
        ),
        Plant(
            id: "\(plantIdPrefix)_20",
            name: "白掌",
            isStarred: false,
            createdAt: 9.days.ago,
            updatedAt: 9.days.ago
        ),
    ]
}

#endif
