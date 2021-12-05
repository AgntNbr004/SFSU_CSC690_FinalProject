//
//  Tree.swift
//  treetest
//
//  Created by Brent Rockwell on 12/3/21.
//

import Foundation
import SwiftUI

struct Tree<A> {
    var value: A
    var children: [Tree<A>] = []
    init(_ value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
}

extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        Tree<B>(transform(value), children: children.map { $0.map(transform) })
    }
}

class Unique<A>: Identifiable {
    var value: A
    init(_ value: A) { self.value = value }
}
