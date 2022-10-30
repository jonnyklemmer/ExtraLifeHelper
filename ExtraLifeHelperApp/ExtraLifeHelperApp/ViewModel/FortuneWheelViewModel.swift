//
//  FortuneWheelViewModel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 19/04/21.
//

import SwiftUI

@available(macOS 10.15, *)
@available(iOS 13.0, *)
class FortuneWheelViewModel: ObservableObject {

    private var pendingRequestWorkItem: DispatchWorkItem?
    @Published var degree = 0.0

    private let model: FortuneWheelModel

    init(model: FortuneWheelModel) {
        self.model = model
    }

    private func getWheelStopDegree() -> Double {
        let randomDegree = Int.random(in: 0...360)
        let randomSpins = Int.random(in: 4...20)
        let finalDegree = randomSpins * (360 + randomDegree)

        return Double(finalDegree)
    }
    
    func spinWheel() {
        withAnimation(model.animation) {
            self.degree = Double(360 * Int(self.degree / 360)) + getWheelStopDegree();
        }
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            let count = self.model.titles.count
            let distance = self.degree.truncatingRemainder(dividingBy: 360)
            let pointer = floor(distance / (360 / Double(count)))
            if let onSpinEnd = self.model.onSpinEnd {
                onSpinEnd(count - Int(pointer) - 1)
            }
        }
        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + model.animDuration + 1, execute: requestWorkItem)
    }
}
