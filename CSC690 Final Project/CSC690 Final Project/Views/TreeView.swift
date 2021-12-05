//
//  TreeView.swift
//  treetest
//
//  Created by Brent Rockwell on 12/3/21.
//

import SwiftUI

struct Diagram<A: Identifiable, V: View>: View {
    var tree: Tree<A>
    var node: (A) -> V

    typealias Key = CollectDict<A.ID, Anchor<CGPoint>>

    var body: some View {
        return VStack(alignment: .center) {
            node(tree.value)
               .anchorPreference(key: Key.self, value: .center, transform: {
                   [self.tree.value.id: $0]
               })
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(tree.children, id: \.value.id, content: { child in
                    Diagram(tree: child, node: self.node)
                })
            }
        }
        .backgroundPreferenceValue(Key.self, { (centers: [A.ID: Anchor<CGPoint>]) in
                    GeometryReader { proxy in
                        ForEach(self.tree.children, id: \.value.id, content: { child in
                            Line(
                                from: proxy[centers[self.tree.value.id]!],
                                to: proxy[centers[child.value.id]!]
                            )
                                .stroke(lineWidth: 3.0)
                                .foregroundColor(.blue)
                        })
                    }
                })
    }
}
