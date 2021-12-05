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

let currentLevel: Int = 1
let squareSide: CGFloat = 100.0
let borderWidth: CGFloat = 3.0
let reqLevelHeight: CGFloat = 30.0
let checkboxSide: CGFloat = 40.0
let basePadding: CGFloat = 10.0

let chosenGradient = Gradient(colors: [Color("Chosen Text Background Dark"),
                                       Color("Chosen Text Background Light")])
let notChosenGradient = Gradient(colors: [Color("Not Chosen Text Background Dark"),
                                          Color("Not Chosen Text Background Dark")])
let notAvailableGradient = Gradient(colors: [Color("Not Available Text Background Dark"),
                                             Color("Not Available Text Background Light")])
