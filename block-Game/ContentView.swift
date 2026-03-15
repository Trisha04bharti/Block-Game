//
//  ContentView.swift
//  block-Game
//
//  Created by Vikram Kumar on 14/03/26.
//

// ContentView.swift
// Project 1 — Basic NavigationStack
// Minimum iOS 16 required

import SwiftUI

struct ContentView : View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("hello jii welcome")
                    .padding()
                Image(systemName: "cloud.fill")
                
                NavigationLink("go to bed"){
                    VStack{
                        Text("hellooo ")
                            .padding()
                        
                        Image(systemName: "star")
                            .padding()
                        
                        Image(systemName: "tree")
                            .font(.system(size: 50))
                            .frame(width: 90 , height: 100)
                            .background(Color.brown.opacity(0.5))
                    }
                }
                
                Section("book store"){
                    Text("book side")
                    Text("book color")
                }
                
                List {
                    Section("Fruits") {
                        Text("Apple")
                        Text("Mango")
                    }

                    Section("Vegetables") {
                        Text("Carrot")
                        Text("Spinach")
                    }
                }
                
                
            }
            .navigationTitle("home")
        }
    }
}



#Preview {
    ContentView()
}
