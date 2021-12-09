//
//  TreeViewModel.swift
//  treetest
//
//  Created by Brent Rockwell on 12/3/21.
//

import Foundation
import SwiftUI

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
