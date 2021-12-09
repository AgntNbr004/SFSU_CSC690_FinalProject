//
//  ContentViewModel.swift
//  treetest
//
//  Created by Brent Rockwell on 12/3/21.
//

import Foundation
import SwiftUI

class BinaryTreeData: ObservableObject {
    // Player info
    @Published var currentLevel: Int16 = 1
    @Published var pointsAvailable: Int = 0
    @Published var levelPoints: Int = 0
    @Published var activeTier: Int = 1
    @Published var chosen: [TechItem] = []
    
    // Data
    @Published var Tiers = [Tier] ()
    @Published var TechItems = [TechItem] ()
    @Published var binaryTree: Tree<TechItem> = Tree<TechItem>(TechItem(id: -1, name: "temp", level: -1, chosen: false, parent: -1, locked: true))
    @Published var uniqueTree: Tree<Unique<TechItem>> = Tree<TechItem>(TechItem(id: -1, name: "temp", level: -1, chosen: false, parent: -1, locked: true)).map(Unique.init)
        
    // UI
    @Published var squareSide: CGFloat = 80.0
    @Published var borderWidth: CGFloat = 3.0
    @Published var reqLevelHeight: CGFloat = 25.0
    @Published var checkboxSide: CGFloat = sqrt((25.0 * 25.0) + (25.0 * 25.0))
    @Published var basePadding: CGFloat = 8.0
    @Published var chosenGradient = Gradient(colors: [Color("Chosen Text Background Dark"),
                                                      Color("Chosen Text Background Light")])
    @Published var notChosenGradient = Gradient(colors: [Color("Not Chosen Text Background Dark"),
                                                         Color("Not Chosen Text Background Dark")])
    @Published var notAvailableGradient = Gradient(colors: [Color("Not Available Text Background Dark"),
                                                            Color("Not Available Text Background Light")])
    
    init() {
        loadData()
        pullTierData()
        dataToTree()
    }
    
    // Read the initial JSON data into the Tier array
    func loadData() {
        guard let path = Bundle.main.url(forResource: "CSC690FinalData", withExtension: "json")
        else {
            print("Could not read data from JSON file.")
            return
        }
        
        let data = try? Data(contentsOf: path)
        let Tiers = try? JSONDecoder().decode([Tier].self, from: data!)
        self.Tiers = Tiers!
    }
    
    // Pull information from the Tier array for the Tier currently on the screen.
    func pullTierData() {
        self.TechItems = self.Tiers[(activeTier - 1)].items
        if (self.TechItems.isEmpty) {
            print("No data was found for Tier \(activeTier)")
        }
    }
    
    // When an item is chosen, traverse the tree and update all child items to set locked to false
    func updateChildLocks(parentId: Int16) {
        var node: Tree<TechItem> = Tree<TechItem>(TechItem(id: -1, name: "temp", level: -1, chosen: false, parent: -1, locked: true))
        
        func searchTree(currentNode: Tree<TechItem>) {
            if parentId == currentNode.value.id {
                node = currentNode
            } else {
                for child in currentNode.children {
                    searchTree(currentNode: child)
                }
            }
        }
        
        searchTree(currentNode: binaryTree)
        
        for child in node.children {
            child.value.locked = node.value.chosen
        }
        
        uniqueTree = binaryTree.map(Unique.init)
    }
    
    // Convert the Tier information into a Tree
    func dataToTree() {
        binaryTree = Tree<TechItem>(self.TechItems[0])
        var remainders: [TechItem] = []
        
        // Initial process to thin the number of items to sort
        for item in self.TechItems.suffix(self.TechItems.count - 1) {
            if (item.parent == binaryTree.value.id) {
                binaryTree.addChild(childNode: Tree<TechItem>(item))
            } else {
                remainders.append(item)
            }
        }
        
        // Add the remaining items to the tree
        while !(remainders.isEmpty) {
            let results = attachTreeNodes(binaryTree: binaryTree, remainders: remainders)
            binaryTree = results.newTree
            remainders = results.newRemains
        }
        
        // Function for finding where to add the remaining nodes and adding them
        func attachTreeNodes(binaryTree: Tree<TechItem>, remainders: [TechItem]) -> (newTree: Tree<TechItem>, newRemains: [TechItem], found: Bool) {
            let returnTree = binaryTree
            var returnArray = remainders
            var recordFound: Bool = false
            
            if (returnTree.value.id == remainders[0].parent) {
                returnTree.addChild(childNode: Tree<TechItem>(returnArray[0]))
                returnArray.removeFirst()
                recordFound = true
                return (returnTree, returnArray, recordFound)
            } else {
                for (index, item) in returnTree.children.enumerated() {
                    let tempResults = attachTreeNodes(binaryTree: item, remainders: returnArray)
                    returnTree.children[index] = tempResults.newTree
                    returnArray = tempResults.newRemains
                    recordFound = tempResults.found
                    if (recordFound) {
                        break
                    }
                }
            }
            
            return (returnTree, returnArray, recordFound)
        }
        
        // Convert the Tree to a Unique Tree so it can be used in a ForEach loop
        uniqueTree = binaryTree.map(Unique.init)
    }
    
    // Used to determine how many points to remove from the user.
    func calculateLevelPoints() -> Int {
        var totalPoints: Int = 0
        for point in 1...Int(self.currentLevel) {
            totalPoints += (point % 10 == 0 ? point : 3)
        }
        return totalPoints
    }
}
