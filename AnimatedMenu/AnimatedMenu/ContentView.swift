//
//  ContentView.swift
//  AnimatedMenu
//
//  Created by Azir on 2024/3/31.
//

import SwiftUI

struct ContentView: View {
    /// View's Properties
    @State var showMenu: Bool = false
    var body: some View {
        AnimatedSideBar(
            rotatesWhenExpands: true,
            disablesIneraction: true,
            sideMenuWidth: 200,
            cornerRadius: 25,
            showMenu: $showMenu
        ) { safeArea  in
            
            NavigationStack {
                List {
                    NavigationLink("Detail View") {
                        Text("Hello Djangoc!")
                            .navigationTitle("Detail")
                    }
                    
                }
                .navigationTitle("Home")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showMenu.toggle()
                        }, label: {
                            Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                                .foregroundStyle(Color.primary)
                                .contentTransition(.symbolEffect)
                        })
                    }
                })
            }
            
        } menuView: { safeArea in
            SideBarMenuView(safeArea)
        } background: {
            Rectangle()
                .fill(.sideMenu )
        }
        
    }
        
    
    @ViewBuilder
    func SideBarMenuView(_ safeArea: UIEdgeInsets) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Side Menu")
                .font(.largeTitle.bold())
                .padding(.bottom, 10)
            
            SideBarButton(.home)
            SideBarButton(.bookmark)
            SideBarButton(.favourites)
            SideBarButton(.profile)
            Spacer(minLength: 0)
            SideBarButton(.logout)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading  )
        .environment(\.colorScheme, .dark  )
    }
    
    @ViewBuilder
    func SideBarButton(_ tab: Tab, onTap: @escaping () -> () = {}) -> some View {
        Button(action: onTap, label: {
            HStack(spacing: 12) {
                Image(systemName: tab.rawValue)
                    .font(.title3)
                Text(tab.title)
                    .font(.callout)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 10)
            .containerShape(.rect)
            .foregroundStyle(Color.primary )
        })
    }
    
    /// Sample Tabs
    enum Tab: String, CaseIterable {
        case home = "house.fill"
        case bookmark = "book.fill"
        case favourites = "heart.fill"
        case profile = "person.crop.circle"
        case logout = "rectangle.portrait.and.arrow.forward.fill"
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .bookmark: return "Bookmark"
            case .favourites: return "Favourites"
            case .profile: return "Profile"
            case .logout: return "Logout"
            }
        }
    }
    
}

#Preview {
    ContentView()
}
