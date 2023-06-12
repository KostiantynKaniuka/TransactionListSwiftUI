//
//  ContentView.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    //MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
        
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
               //MARK: SortingButton
                ToolbarItem {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                        .foregroundStyle(Color.white, .secondary)
                    
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
