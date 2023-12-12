//
//  ContentView.swift
//  CustomSideMenu
//
//  Created by Yunus Emre Berdibek on 14.05.2023.
//


import SwiftUI


struct ContentView: View {
    @State var showMenu: Bool = false
    
    // Offset for Both drag gesture and showing menu
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    // Gesture offset...
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        let sideBarWidth = getRect() .width - 90
        
        NavigationStack {
            HStack(spacing: 0) {
                SideMenuView(showMenu: $showMenu)
                VStack {
                    HomeView(showMenu: $showMenu, onTap: {
                        showMenu.toggle()
                    })
                }
                .frame(width: getRect().width)
                .overlay {
                    Rectangle()
                        .fill (
                            Color.primary
                                .opacity(Double((offset / sideBarWidth) / 5))
                            
                        )
                        .ignoresSafeArea(.container, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                showMenu .toggle()
                            }
                        }
                }
            }
            // Max size...
            .frame(width: getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset > 0 ? offset : 0)
            // Gesture
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value:))
            )
        }.animation(.easeOut, value: offset == 0)
            .onChange(of: showMenu) { newValue in
                
                if showMenu && offset == 0 {
                    offset = sideBarWidth
                    lastStoredOffset = offset
                }
                
                if !showMenu && offset == sideBarWidth {
                    offset = 0
                    lastStoredOffset = 0
                }
            }
            .onChange(of: gestureOffset) { newValue in
                onChange()
            }
    }
    
    func onChange() {
        
        let sideBarWidth = getRect() .width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideBarWidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    func onEnd(value: DragGesture.Value) {
        
        let sideBarWidth = getRect() .width - 90
        
        let translation = value.translation.width
        withAnimation {
            //Checking...
            if translation > 0 {
                
                if translation > (sideBarWidth / 2) {
                    //showing menu
                    offset = sideBarWidth
                    showMenu = true
                } else {
                    
                    //Extra cases
                    if offset == sideBarWidth {
                        return
                    }
                    
                    offset = 0
                    showMenu = false
                }
            } else {
                
                if -translation > (sideBarWidth / 2) {
                    offset = 0
                    showMenu = false
                } else {
                    
                    if offset == 0 || !showMenu {
                        return
                    }
                    
                    offset = sideBarWidth
                    showMenu = true
                }
            }
        }
        
        //storing last offset
        lastStoredOffset = offset
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
// Extending view to get Screen rect
extension View {
    func getRect () -> CGRect {
        return UIScreen.main.bounds
    }
}
