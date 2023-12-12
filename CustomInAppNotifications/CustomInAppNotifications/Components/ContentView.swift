//
//  ContentView.swift
//  CustomInAppNotifications
//
//  Created by Yunus Emre Berdibek on 12.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Sheet") {
                    showSheet.toggle()
                }
                .sheet(isPresented: $showSheet, content: {
                    Button("Show AirDrop Notification") {
                        UIApplication.shared.inAppNotification(adaptForDynamicIsland: true, timeout: 5, swipeToClose: true) {
                            HStack {
                                Image(systemName: "wifi")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white)
                                
                                VStack(alignment: .leading, spacing: 2, content: {
                                    Text("AirDrop")
                                        .font(.caption.bold())
                                        .foregroundStyle(.white)
                                    
                                    Text("From iJustine")
                                        .textScale(.secondary)
                                        .foregroundStyle(.gray)
                                })
                                .padding(.top, 20)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(15)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                            }
                        }
                    }
                })
                
                Button("Show Notification") {
                    UIApplication.shared.inAppNotification(adaptForDynamicIsland: true, timeout: 5, swipeToClose: true) {
                        HStack {
                            Image(.spidey)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .clipShape(.circle)
                            
                            VStack(alignment: .leading, spacing: 6, content: {
                                Text("iJustine")
                                    .font(.caption.bold())
                                    .foregroundStyle(.white)
                                
                                Text("Hello, This is iJustine!")
                                    .textScale(.secondary)
                                    .foregroundStyle(.gray)
                            })
                            .padding(.top, 20)
                            
                            Spacer(minLength: 0)
                            
                            Button(action: {}, label: {
                                Image(systemName: "speaker.slash.fill")
                                    .font(.title2)
                            })
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.circle)
                            .tint(.white)
                        }
                        .padding(15)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.black)
                        }
                    }
                }
            }
            .navigationTitle("In App Notification's")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
