//
//  Home.swift
//  StackedCardView
//
//  Created by Jason on 2024/5/17.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            
            StackedCards(items: items, stackedDisplayCount: 1,itemHeight: 70) {  item in
                CardView(item)
            }
            
            BottomActionBar()
        }
        .padding(20 )
    }
    
    @ViewBuilder
    func CardView(_ item: Item) -> some View {
        HStack(spacing: 12) {
            Image(item.logo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.callout)
                    .fontWeight(.bold)
                
                Text(item.description)
                    .font(.caption)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .frame(maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
    /// Bottom Action Bar
    @ViewBuilder
    func BottomActionBar() -> some View {
        HStack {
            Button(action: {},  label: {
                 Image(systemName: "flashlight.off.fill")
                    .font(.title3  )
                    .frame(width: 35, height: 35)
            })
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.2))
            .buttonBorderShape(.circle)
            
            Spacer()
            
            Button(action: {},  label: {
                 Image(systemName: "camera.fill")
                    .font(.title3  )
                    .frame(width: 35, height: 35)
            })
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.2))
            .buttonBorderShape(.circle)
        }
    }
}

#Preview {
    ContentView  ()
}
