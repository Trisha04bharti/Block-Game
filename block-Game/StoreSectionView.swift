//
//  StoreSectionView.swift
//  block-Game
//
//  Created by Vikram Kumar on 01/04/26.
//

import SwiftUI

struct StoreSectionView: View {
    var title: String
    var items: [String]

    var body: some View {
        Section(title) {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
        }
    }
}

#Preview {
    List {
        StoreSectionView(title: "Sample", items: ["Item 1", "Item 2"])
    }
}
