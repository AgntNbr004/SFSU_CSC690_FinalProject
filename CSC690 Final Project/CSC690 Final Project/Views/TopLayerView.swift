//
//  TopLayerVIew.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

struct TopLayerView: View {
    var cVM = BinaryTreeData()
    var data: Unique<TechItem>
    
    var body: some View {
        ZStack(content: {
            Text("")
                .frame(width: self.cVM.checkboxSide, height: self.cVM.checkboxSide)
                .background(LinearGradient(gradient: data.value.chosen ? self.cVM.chosenGradient
                                           : data.value.level > self.cVM.currentLevel || data.value.locked ? self.cVM.notAvailableGradient
                                           : self.cVM.notChosenGradient,
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .rotationEffect(Angle(degrees: 45))
            ZStack(content: {
                if data.value.chosen { Image(systemName: "checkmark") }
                else if data.value.level > self.cVM.currentLevel { Text(String(data.value.level)) }
                else if data.value.locked { Image(systemName: "lock.fill") }
                else { Text("") }
            })
                .frame(width: self.cVM.checkboxSide, height: self.cVM.checkboxSide)
                .foregroundColor(.white)
            Text("")
                .frame(width: self.cVM.checkboxSide - self.cVM.borderWidth / 2, height: self.cVM.checkboxSide - self.cVM.borderWidth / 2)
                .border(!data.value.chosen && data.value.level <= self.cVM.currentLevel && !data.value.locked ? Color.blue :
                            data.value.level > self.cVM.currentLevel  || data.value.locked ? Color.gray : Color.white,
                        width: 3)
                .rotationEffect(Angle(degrees: 45))
        })
            .padding(self.cVM.basePadding)
            .offset(x: (self.cVM.squareSide / 2) - 1.5, y: -(self.cVM.squareSide / 2) + 1.5)
    }
}
