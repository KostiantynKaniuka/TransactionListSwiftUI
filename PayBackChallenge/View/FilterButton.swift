//
//  FilterButton.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct FilterButton: View {
    @Binding var filterSwitch: Category
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: {
            showingAlert = true
            print("Button tapped")
        }) {
            HStack {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .font(.title)
                    .foregroundStyle(Color.icon, .primary)
                    .foregroundStyle(Color.white, .secondary)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.icon, radius: 5, x: 0, y: 0)
            
        }
        .alert("Show only", isPresented: $showingAlert) {
                   Button("Income", role: .none) {
                       filterSwitch = .income
                   }
                   Button("Debt", role: .none) {
                       filterSwitch = .credit
                   }
                   Button("Domestic transfer", role: .none) {
                       filterSwitch = .domesticTransfer
                   }
                   Button("All operations", role: .none) {
                       filterSwitch = .all
                   }
                   Button("Cancel", role: .cancel) {}
               }
        }
    }


struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(filterSwitch: .constant(.all))
    }
}
