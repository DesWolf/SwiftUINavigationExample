//
//  ContentView.swift
//  NavigationExample
//
//  Created by Максим Окунеев on 09.01.2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: Сreating NavigationStack
    // Where you can push and pop Views
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        NavigationStack(path: $mainStack) {
            // MARK: Complex Structure with TabView
            TabView {
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                Text("Liked")
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                Text("Settings")
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                    }
            }
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // MARK: Simply push new View
                        mainStack.append(.dm)
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.callout)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // MARK: Simply push new View
                        mainStack.append(.camera)
                    } label: {
                        Image(systemName: "camera")
                            .font(.callout)
                    }
                }
            }
            
            // MARK: NewApi that can push new based on DataType
            .navigationDestination(for: NavigationType.self) { value in
                // MARK: Push your View based on value
                switch value {
                case .camera: VStack {
                    Text("Camera View")
                    // Pop View is Simple
                    // Just remove last or witch View you need to remove from stack
                    Button("Pop") {
                        mainStack.removeLast()
                    }
                    Button("Go to DM View") {
                        mainStack.append(.dm)
                    }
                }
                case .home: Text("Home View")
                case .dm:  VStack {
                    Text("DM View")
                    Button("Pop") {
                        mainStack.removeLast()
                    }
                    // Simplyfy clear the Items on the Stack
                    Button("Pop to Root") {
                        mainStack.removeAll()
                     }
                }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Enum Case for Navigation Stack Items
enum NavigationType: String, Hashable {
    case dm = "DM VIEW"
    case camera = "CAMERA VIEW"
    case home = "HOME"
}
