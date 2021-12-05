//
//  MiddleLayerView.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

struct MiddleLayerView: View {
    var data: Unique<TechItem>
    
    var body: some View {
        ZStack(content: {
            if (data.value.level > currentLevel) {
                Text("REQ LVL")
                    .font(.caption2)
                    .frame(width: squareSide, height: reqLevelHeight - borderWidth / 2)
                    .background(.black)
                    .foregroundColor(.white)
                Text("")
                    .frame(width: squareSide - borderWidth / 2, height: reqLevelHeight - borderWidth / 2)
                    .border(Color.gray, width: 3)
            }
        })
            .padding(basePadding)
            .offset(y: -(squareSide / 2) + (reqLevelHeight / 2))
    }
}
