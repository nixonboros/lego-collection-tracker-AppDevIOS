import SwiftUI
import PDFKit

struct PDFSheetView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}
