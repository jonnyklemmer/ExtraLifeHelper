//
//  DropController.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/23/22.
//

import Foundation
import SwiftUI

class DropController {
    private func createCSVWithString(
        from provider: NSItemProvider,
        at dropIndex: Int)
    {
//        _ = provider.loadObject(ofClass: String.self) { string, _ in
//            guard let string = string else { return }
//            let _ = ExtraLifeCSV(string: string)
//        }
    }

    @discardableResult
    func receiveDrop(
        dropIndex: Int,
        itemProviders: [NSItemProvider],
        create: Bool = true
    ) -> Bool {
        var result = false
        for provider in itemProviders {
            if provider.canLoadObject(ofClass: String.self) {
                result = true
                createCSVWithString(from: provider, at: dropIndex)
            }
        }
        return result
    }
}

extension DropController: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [.commaSeparatedText]) else {
            return false
        }

        return receiveDrop(
            dropIndex: 0,
            itemProviders: info.itemProviders(for: [.commaSeparatedText]),
            create: false
        )
    }
}
