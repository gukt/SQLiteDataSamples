//
//  BaseEntity.swift
//  GreenTime
//
//  基础实体协议，所有领域模型的基类
//

import Foundation
import GRDB
import SQLiteData

// MARK: - Auditable

/// 审计协议，提供创建和更新时间追踪
protocol Auditable {
    /// 创建时间
    var createdAt: Date { get set }

    /// 最后更新时间
    var updatedAt: Date { get set }
}

extension Auditable {
    /// 更新最后更新时间
    mutating func touch() {
        updatedAt = Date()
    }
}

// MARK: - SoftDeletable

/// 软删除协议
/// 实现此协议的实体支持软删除（标记删除而不是真正删除）
protocol SoftDeletable {
    /// 删除时间（nil 表示未删除）
    var deletedAt: Date? { get set }

    /// 是否已删除
    var isDeleted: Bool { get }
}

/// 软删除协议扩展，提供 isDeleted 计算属性的默认实现
extension SoftDeletable {
    var isDeleted: Bool {
        deletedAt != nil
    }

    /// 标记为已删除（软删除）
    mutating func markAsDeleted() {
        deletedAt = Date()
    }

    /// 恢复（取消软删除）
    mutating func restore() {
        deletedAt = nil
    }
}

// MARK: - Sortable

/// 可排序协议
protocol Sortable {
    /// 排序顺序
    var sortOrder: Int { get set }
}

// MARK: - EntityIdentifiable

/// 基础标识协议，提供唯一标识符
/// 所有领域模型都必须有唯一标识符
protocol EntityIdentifiable: Identifiable {
    var id: String { get set }
}

// MARK: - BaseEntity

/// 完整的领域实体类型
/// 组合了 ID 标识、审计和软删除能力
protocol BaseEntity: EntityIdentifiable, Auditable, SoftDeletable, Hashable {
    // 空协议，只做组合
    // 将来可以在这里添加额外要求
}

// MARK: - BaseEntity + Equatable

/// 扩展 BaseEntity 实现 Hashable 协议（Hashable 继承自 Equatable）
extension BaseEntity {
    /// 基于 id 的判等
    /// 在 DDD 中，实体的相等性由唯一标识符决定
    /// 即使属性不同，只要 id 相同就是"同一个"实体
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    /// 基于 id 的哈希
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension BaseEntity {
    /// 验证实体有效性
    func validate() throws {
        guard !id.isEmpty else {
            throw EntityError.emptyId
        }

        guard createdAt <= updatedAt else {
            throw EntityError.invalidTimestamp(createdAt: createdAt, updatedAt: updatedAt)
        }

        if let deletedAt = deletedAt {
            guard deletedAt >= createdAt else {
                throw EntityError.invalidDeletionTime(createdAt: createdAt, deletedAt: deletedAt)
            }
        }
    }

    /// 是否有效（不抛出异常的版本）
    var isValid: Bool {
        (try? validate()) != nil
    }

    /// 软删除并更新时间戳
    mutating func softDelete() {
        // 标记为已删除
        // 因为 BaseEntity 遵循 SoftDeletable 协议
        markAsDeleted()
        
        // 更新时间戳
        touch()
    }
}

extension BaseEntity {
    mutating func prepareForInsert() {
        let now = Date()
        createdAt = now
        updatedAt = now
    }

    mutating func prepareForUpdate() {
        touch()
    }

    /// 准备保存前的处理
    mutating func prepareForSave(isNew: Bool = false) {
        if isNew {
            let now = Date()
            createdAt = now
            updatedAt = now
        } else {
            updatedAt = Date()
        }
    }
}

// MARK: - 错误定义

enum EntityError: Error, LocalizedError {
    case emptyId
    case invalidTimestamp(createdAt: Date, updatedAt: Date)
    case invalidDeletionTime(createdAt: Date, deletedAt: Date)

    var errorDescription: String? {
        switch self {
        case .emptyId:
            return "实体 ID 不能为空"
        case .invalidTimestamp(let createdAt, let updatedAt):
            return "更新时间 (\(updatedAt)) 不能早于创建时间 (\(createdAt))"
        case .invalidDeletionTime(let createdAt, let deletedAt):
            return "删除时间 (\(deletedAt)) 不能早于创建时间 (\(createdAt))"
        }
    }
}
