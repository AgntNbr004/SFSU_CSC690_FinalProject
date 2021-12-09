
//
//  BottomLayerView.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

struct BottomLayerView: View {
    var cVM = BinaryTreeData()
    var data: Unique<TechItem>
    
    var body: some View {
        ZStack(content: {
            Text((data.value.level > self.cVM.currentLevel ? "\n" : "") + data.value.name)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: self.cVM.squareSide, height: self.cVM.squareSide)
                .background(LinearGradient(gradient: data.value.chosen ? self.cVM.chosenGradient
                                           : data.value.level > self.cVM.currentLevel || data.value.locked ? self.cVM.notAvailableGradient : self.cVM.notChosenGradient,
                                           startPoint: .top,
                                           endPoint: .bottom))
            Text("")
                .frame(width: self.cVM.squareSide - self.cVM.borderWidth / 2, height: self.cVM.squareSide - self.cVM.borderWidth / 2)
                .border(!data.value.chosen && data.value.level <= self.cVM.currentLevel && !data.value.locked ? Color.blue :
                            data.value.level > self.cVM.currentLevel || data.value.locked ? Color.gray : Color.white,
                        width: self.cVM.borderWidth)
        })
            .padding(self.cVM.basePadding)
            .onTapGesture(perform: {
                if (self.cVM.currentLevel >= data.value.level
                    && self.cVM.pointsAvailable > 0
                    && !data.value.locked) {
                    data.value.chosen = !data.value.chosen
                    self.cVM.pointsAvailable += data.value.chosen ? -1 : 1
                    // self.cVM.updateChildLocks(parentId: data.value.id)
                    for node in self.cVM.TechItems {
                        print(node)
                    }
                }
            })
    }
}
