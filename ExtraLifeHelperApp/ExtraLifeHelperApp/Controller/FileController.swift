//
//  FileController.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/23/22.
//

import Foundation
import AppKit

class FileController: ObservableObject  {



//    private func unwrapImage(
//      from provider: NSItemProvider,
//      completion: @escaping (UIImage?) -> Void
//    ) {
//      _ = provider.loadObject(ofClass: UIImage.self) { image, error in
//        var unwrappedImage: UIImage?
//        defer {
//          completion(unwrappedImage)
//        }
//        if let error = error {
//          print("image drop failed -", error.localizedDescription)
//        } else {
//          unwrappedImage = image as? UIImage
//        }
//      }
//    }

//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let myURL = urls.first else {
//           return
//        }
//        print("import result : \(myURL)")
//    }
//
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        print("view was cancelled")
//        dismiss(animated: true, completion: nil)
//    }
//
//    func selectFile() {
//        let importMenu = UIDocumentPickerViewController(documentTypes: [(kUTTypeCommaSeparatedText as String)], in: .import)
//        importMenu.delegate = self
//        importMenu.modalPresentationStyle = .formSheet
//        self.present(importMenu, animated: true, completion: nil)
//    }
}
