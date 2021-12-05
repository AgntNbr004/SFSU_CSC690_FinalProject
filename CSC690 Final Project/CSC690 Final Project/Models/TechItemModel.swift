//
//  TechItem.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import Foundation

struct TechItem: Codable {
    var id: Int16
    var name: String
    var level: Int16
    var chosen: Bool
    var parent: Int16
    var desc: String
}
