//
//  ContentView.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContactsViewModel = .init()
    @State private var shouldShowCreateContact: Bool = false

    var body: some View {
        NavigationStack {
            LazyVStack {
                if viewModel.contacts.isEmpty {
                    Text("There are no contacts please tap the plus to add some")
                } else {
                    ForEach(viewModel.contacts) { contact in
                        ContactInfoView(contact: contact)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        shouldShowCreateContact.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $shouldShowCreateContact, content: {
                CreateContactView(action: { contact in
                    viewModel.add(contact)
                })
            })
        }
    }
}

#Preview {
    ContentView()
}
