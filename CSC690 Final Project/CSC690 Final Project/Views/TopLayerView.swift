//
//  TopLayerVIew.swift
//  treetest
//
//  Created by Brent Rockwell on 12/4/21.
//

import SwiftUI

struct TopLayerView: View {
    var data: Unique<TechItem>
    
    var body: some View {
        ZStack(content: {
            Text("")
                .frame(width: checkboxSide, height: checkboxSide)
                .background(LinearGradient(gradient: data.value.chosen ? chosenGradient : notChosenGradient,
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .rotationEffect(Angle(degrees: 45))
            ZStack(content: {
                if (data.value.chosen) { Image(systemName: "checkmark") }
                if (!data.value.chosen && data.value.level > currentLevel) { Text(String(data.value.level)) }
                if (!data.value.chosen && data.value.level <= currentLevel) { Text("") }
            })
                .frame(width: checkboxSide, height: checkboxSide)
                .foregroundColor(.white)
            Text("")
                .frame(width: checkboxSide - borderWidth / 2, height: checkboxSide - borderWidth / 2)
                .border(!data.value.chosen && data.value.level <= currentLevel ? Color.blue :
                            data.value.level > currentLevel ? Color.gray : Color.white,
                        width: 3)
                .rotationEffect(Angle(degrees: 45))
        })
            .padding(basePadding)
            .offset(x: (squareSide / 2) - 1.5, y: -(squareSide / 2) + 1.5)
    }
}
