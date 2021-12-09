//
//  CSC690_Final_ProjectApp.swift
//  CSC690 Final Project
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

// MVP
// TODO: Tie TechItem.chosen to Tree[children] so child TechItem.locked values are changed when user picks item [HARD DIFF]

// NEXT STEPS
// TODO: Rename BinaryTreeData to ContentViewModel [EASY DIFF]
// TODO: Fix BinaryTreeData.dataToTree().attachTreeNodes(). If item parent not yet in tree, then infinite loop. [EASY DIFF]
// TODO: Move all the logic out of ContentView and into ContentViewModel [MEDIUM DIFF]
// TODO: Check to see if BinaryTreeData/ContentViewModel class needs to be split up [HARD DIFF]
// TODO: Add method for saving and loading data to/from JSON [HARD DIFF]
// TODO: Clean up spaghetti code [HARD DIFF]

@main
struct CSC690_Final_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
