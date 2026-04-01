//
//  DetailView.swift
//  block-Game
//
//  Created by Vikram Kumar on 01/04/26.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            Text("hellooo ")
                .padding()
            
            Image(systemName: "star")
                .padding()
            
            Image(systemName: "tree")
                .font(.system(size: 50))
                .frame(width: 90, height: 100)
                .background(Color.brown.opacity(0.5))
        }
        .navigationTitle("Details")
    }
}

#Preview {
    DetailView()
}
