//
//  ContentView.swift
//  PDFKitTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @State var url: URL?
    @State var isImporting: Bool = false
    @State var showPDFDetail: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .sheet(isPresented: $showPDFDetail, content: {
                if let url = url {
                    if let pdfDoc = PDFDocument(url: url) {
                        PDFKitView(pdfDocument: pdfDoc)
                    }
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isImporting = true
                    }, label: {
                        Label("Import file",
                              systemImage: "square.and.arrow.down")
                    })
                }
            }
            .fileImporter(isPresented: $isImporting, allowedContentTypes: [.pdf]) { result in
                switch result {
                case .success(let url):
                    self.url = url
                    showPDFDetail.toggle()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
