//
//  ContentView.swift
//  CSC690 Final Project
//
//  Created by Brent Rockwell on 12/3/21.
//

import SwiftUI

struct ContentView: View {
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1
    @State var tree = uniqueTree
    
    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                Diagram(tree: tree,
                        node: { value in
                    ZStack(content: {
                        BottomLayerView(data: value)
                        MiddleLayerView(data: value)
                        TopLayerView(data: value)
                    })
                        .padding(basePadding)
                })
                    .scaleEffect(finalScale + currentScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { newScale in
                                currentScale = newScale}
                            .onEnded { scale in
                                finalScale = scale
                                currentScale = 0
                            }
                    )
            }
        }.background(Color("Screen Background"))
    }
}

/* -------------------------------------------------- */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
