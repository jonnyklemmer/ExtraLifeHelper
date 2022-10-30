//
//  CSVUploadView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/19/22.
//

import Combine
import SwiftUI
import UniformTypeIdentifiers

struct CSVUploadView: View {
    @State private var showFileImport = false
    @State private var dragOver = false
    @EnvironmentObject private var viewModel: CSVViewModel

    private let strokeStyle = StrokeStyle(miterLimit: 10, dash: [8, 8])

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .stroke(.gray, style: strokeStyle)
                    .background(dragOver ? Color.red : Color.clear)
                    .frame(width: 190, height: 125)

                Text("Drag & Drop (WIP)")

            }
//            .onDrop(of: [.commaSeparatedText, .image], isTargeted: $dragOver, perform: { providers in
//                print("got here")
//                return true
//            })
            .onDrop(of: [.commaSeparatedText, .image], delegate: DropController())

            Button {
                self.showFileImport.toggle()
            } label: {
                Text("Choose CSV...")
                    .frame(maxWidth: 180)
            }
            .buttonStyle(.bordered)

            Button {
                print("upload")
            } label: {
                Text("Upload")
                    .frame(maxWidth: 180)
            }
            .buttonStyle(.borderedProminent)
        }
        .fileImporter(isPresented: $showFileImport, allowedContentTypes: [.commaSeparatedText]) { result in
            do{
                let fileUrl = try result.get()
                print(fileUrl)

                guard fileUrl.startAccessingSecurityScopedResource() else { return }

                let data = try String(contentsOf: fileUrl, encoding: .utf8)
                self.viewModel.loadCSVData(data: data)

                fileUrl.stopAccessingSecurityScopedResource()
            } catch{
                print ("Failed to load file:")
                print (error.localizedDescription)
            }
        }
    }
}

struct CSVUploadView_Previews: PreviewProvider {
    static var previews: some View {
        CSVUploadView()
    }
}
