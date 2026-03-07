//
//  PreviewDatabase.swift
//  SQLiteDataSamples
//
//  Created by Gu Kaitong  on 2026/3/7.
//

import SQLiteData

extension DatabaseWriter {
    func seed() throws {
        try write { db in
            for name in ["龟背竹", "散尾葵"] {
                try Plant.insert {
                    Plant(name: name)
                }
                .execute(db)
            }
        }
    }
}
