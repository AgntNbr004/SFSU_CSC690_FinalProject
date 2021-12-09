//
//  ContentView.swift
//  CSC690 Final Project
//
//  Created by Brent Rockwell on 12/3/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cVM = BinaryTreeData()
    
    var body: some View {
        VStack(content: {
            // Level control
            HStack(content: {
                Button(action: {
                    if (self.cVM.currentLevel > 1) {
                        self.cVM.currentLevel -= 1
                        self.cVM.pointsAvailable = self.cVM.calculateLevelPoints()
                        while (self.cVM.chosen.count > self.cVM.pointsAvailable) {
                            self.cVM.chosen.removeLast()
                        }
                    }
                },
                       label: { Image(systemName: "minus.square") })
                    .padding(.trailing)
                    .font(.largeTitle)
                VStack(content: {
                    Text("Level: \(self.cVM.currentLevel)")
                    Text("Points Available: \(self.cVM.pointsAvailable)")
                        .font(.caption2)
                })
                    .padding(.horizontal)
                    .foregroundColor(.white)
                Button(action: {
                    self.cVM.currentLevel += 1
                    self.cVM.levelPoints = (self.cVM.currentLevel % 10 == 0 ? Int(self.cVM.currentLevel) : 3)
                    self.cVM.pointsAvailable += self.cVM.levelPoints
                },
                       label: { Image(systemName: "plus.square") })
                    .font(.largeTitle)
                    .padding(.leading)
            }).padding(.top, 5.0)
            
            // Tier pick
            HStack(content: {
                Button(action: { self.cVM.activeTier = 1; self.cVM.pullTierData(); self.cVM.dataToTree() },
                       label: { Text("TIER 1").padding().foregroundColor(self.cVM.activeTier == 1 ? Color.gray : Color.blue) }
                ).overlay(RoundedRectangle(cornerRadius: 10).stroke(self.cVM.activeTier == 1 ? Color.gray : Color.blue, lineWidth: 2))
                Button(action: { self.cVM.activeTier = 2; self.cVM.pullTierData(); self.cVM.dataToTree() },
                       label: { Text("TIER 2").padding().foregroundColor(self.cVM.activeTier == 2 ? Color.gray : Color.blue) }
                ).overlay(RoundedRectangle(cornerRadius: 10).stroke(self.cVM.activeTier == 2 ? Color.gray : Color.blue, lineWidth: 2))
                Button(action: { self.cVM.activeTier = 3; self.cVM.pullTierData(); self.cVM.dataToTree() },
                       label: { Text("TIER 3").padding().foregroundColor(self.cVM.activeTier == 3 ? Color.gray : Color.blue) }
                ).overlay(RoundedRectangle(cornerRadius: 10).stroke(self.cVM.activeTier == 3 ? Color.gray : Color.blue, lineWidth: 2))
                Button(action: { self.cVM.activeTier = 4; self.cVM.pullTierData(); self.cVM.dataToTree() },
                       label: { Text("TIER 4").padding().foregroundColor(self.cVM.activeTier == 4 ? Color.gray : Color.blue) }
                ).overlay(RoundedRectangle(cornerRadius: 10).stroke(self.cVM.activeTier == 4 ? Color.gray : Color.blue, lineWidth: 2))
            })
                .padding([.top, .bottom], 5.0)
            
            // The main tree
            ScrollView(.horizontal) {
                ScrollView(.vertical) {
                    Diagram(tree: self.cVM.uniqueTree,
                            node: { value in
                        ZStack(content: {
                            BottomLayerView(cVM: cVM, data: value)
                            MiddleLayerView(cVM: cVM, data: value)
                            TopLayerView(cVM: cVM, data: value)
                        })
                            .padding(self.cVM.basePadding)
                    })
                        .padding([.top, .trailing], self.cVM.basePadding * 2)
                }
            }
        })
            .background(Color("Screen Background"))
    }
}

/* -------------------------------------------------- */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
