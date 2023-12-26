//
//  ContentViewRepresentable.swift
//  PDFKitTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {
    let pdfDocument: PDFDocument

    init(pdfDocument: PDFDocument) {
        self.pdfDocument = pdfDocument
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        print(pdfDocument.dataRepresentation()?.base64EncodedString() ?? "nil kanka")
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDocument
    }
}
