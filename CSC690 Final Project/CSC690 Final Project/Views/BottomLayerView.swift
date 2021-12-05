//
//  BottomLayerView.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

struct BottomLayerView: View {
    var data: Unique<TechItem>
    
    var body: some View {
        ZStack(content: {
            Text(data.value.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: squareSide, height: squareSide)
                .background(LinearGradient(gradient: data.value.chosen ? chosenGradient
                                           : data.value.level > currentLevel ? notAvailableGradient : notChosenGradient,
                                           startPoint: .top,
                                           endPoint: .bottom))
            Text("")
                .frame(width: squareSide - borderWidth / 2, height: squareSide - borderWidth / 2)
                .border(!data.value.chosen && data.value.level <= currentLevel ? Color.blue :
                            data.value.level > currentLevel ? Color.gray : Color.white,
                        width: borderWidth)
        })
            .padding(basePadding)
            .onTapGesture(perform: {
                if currentLevel >= data.value.level {
                    data.value.chosen = !data.value.chosen
                }
            })
    }
}
