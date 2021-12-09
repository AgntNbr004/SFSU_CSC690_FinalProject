//
//  Tree.swift
//  treetest
//
//  Created by Brent Rockwell on 12/3/21.
//

import Foundation
import SwiftUI

/*
class Tree<A> {
    var value: A
    var children: [Tree]
    
    init(_ value: A, children: [Tree] = []) {
        self.value = value
        self.children = children
    }
    
    func addChild(childNode: Tree) {
        children.append(childNode)
    }
}
*/

class Tree<TechItem> {
    var value: TechItem
    var children: [Tree]
    
    init(_ value: TechItem, children: [Tree] = []) {
        self.value = value
        self.children = children
    }
    
    func addChild(childNode: Tree) {
        children.append(childNode)
    }
}

/*
extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        Tree<B>(transform(value), children: children.map { $0.map(transform) })
    }
}
*/

extension Tree {
    func map<B>(_ transform: (TechItem) -> B) -> Tree<B> {
        Tree<B>(transform(value), children: children.map { $0.map(transform) })
    }
}

/*
class Unique<A>: Identifiable {
    var value: A
    init(_ value: A) {
        self.value = value
    }
}
*/

class Unique<TechItem>: Identifiable {
    var value: TechItem {
        willSet {  }
        didSet { updateChildLocks() }
    }
    private var oldChosen: Bool?
    private var newChosen: Bool?
    
    init(_ value: TechItem) {
        self.value = value
    }
    
    func updateChildLocks() {
        print(self.value)
        // I still dont have access to the list of children...
        // I might be able to merge this class with the main class so
        // that its also identifiable for the ForEach loop?
    }
}
