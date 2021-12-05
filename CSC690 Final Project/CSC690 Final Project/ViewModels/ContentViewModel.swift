//
//  ContentViewModel.swift
//  treetest
//
//  Created by Brent Rockwell on 12/3/21.
//

import Foundation

let binaryTree = BinaryTreeData().binaryTree
let uniqueTree: Tree<Unique<TechItem>> = binaryTree.map(Unique.init)

class BinaryTreeData: ObservableObject {
    @Published var CurrentLevel: Int16 = 1
    @Published var TechItems = [TechItem] ()
    @Published var binaryTree: Tree<TechItem> = Tree<TechItem>(TechItem(id: -1, name: "temp", level: -1, chosen: false, parent: -1, desc: ""))
    
    init(currentLevel: Int16 = 1) {
        self.CurrentLevel = currentLevel
        loadData()
        dataToTree()
    }
    
    func loadData() {
        guard let path = Bundle.main.url(forResource: "CSC690FinalData", withExtension: "json")
        else {
            print("Could not read data from JSON file.")
            return
        }
        
        let data = try? Data(contentsOf: path)
        let TechItems = try? JSONDecoder().decode([TechItem].self, from: data!)
        self.TechItems = TechItems!
    }
    
    func dataToTree() {
        binaryTree = Tree<TechItem>(self.TechItems[0])
        var remainders: [TechItem] = []
        
        // Initial process to thin the number of items to sort
        for item in self.TechItems.suffix(self.TechItems.count - 1) {
            if (item.parent == binaryTree.value.id) {
                binaryTree.children.append(Tree<TechItem>(item))
            } else {
                remainders.append(item)
            }
        }
        
        while !(remainders.isEmpty) {
            let results = attachTreeNodes(binaryTree: binaryTree, remainders: remainders)
            binaryTree = results.newTree
            remainders = results.newRemains
        }
        
        func attachTreeNodes(binaryTree: Tree<TechItem>, remainders: [TechItem]) -> (newTree: Tree<TechItem>, newRemains: [TechItem], found: Bool) {
            var returnTree = binaryTree
            var returnArray = remainders
            var recordFound: Bool = false
            
            if (returnTree.value.id == remainders[0].parent) {
                returnTree.children.append(Tree<TechItem>(returnArray[0]))
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
            
            // TODO: Fix this function. If the items parent is not yet in the list, it will fall into an infinite loop.
            
            return (returnTree, returnArray, recordFound)
        }
    }
}
