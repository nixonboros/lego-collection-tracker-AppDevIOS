import SwiftUI
import PDFKit

struct PDFSheetView: View {
    let url: URL
    
    var body: some View {
        VStack(spacing: 0) {
            // Drag indicator at top
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 8)
            
            // PDF View
            PDFKitView(url: url)
        }
        .background(Color(.systemBackground))
    }
}

struct PDFKitView: UIViewRepresentable {
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
