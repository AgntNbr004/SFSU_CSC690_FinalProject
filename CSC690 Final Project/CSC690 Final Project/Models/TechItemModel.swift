//
//  TechItem.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import Foundation

struct Tier: Codable {
    var tier: Int16
    var items: [TechItem]
}

struct TechItem: Codable, Identifiable {
    var id: Int16
    var name: String
    var level: Int16
    var chosen: Bool
    var parent: Int16
    var locked: Bool
}
