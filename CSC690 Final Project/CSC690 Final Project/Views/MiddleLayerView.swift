//
//  MiddleLayerView.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

struct MiddleLayerView: View {
    var cVM = BinaryTreeData()
    var data: Unique<TechItem>
    
    var body: some View {
        ZStack(content: {
            if (data.value.level > self.cVM.currentLevel) {
                Text("REQ LVL")
                    .font(.caption2)
                    .frame(width: self.cVM.squareSide, height: self.cVM.reqLevelHeight - self.cVM.borderWidth / 2)
                    .background(.black)
                    .foregroundColor(.white)
                Text("")
                    .frame(width: self.cVM.squareSide - self.cVM.borderWidth / 2, height: self.cVM.reqLevelHeight - self.cVM.borderWidth / 2)
                    .border(Color.gray, width: 3)
            }
        })
            .padding(self.cVM.basePadding)
            .offset(y: -(self.cVM.squareSide / 2) + (self.cVM.reqLevelHeight / 2))
    }
}
