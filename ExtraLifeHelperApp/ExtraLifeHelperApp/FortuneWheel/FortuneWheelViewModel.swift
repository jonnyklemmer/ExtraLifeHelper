//
//  FortuneWheelModel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 24/10/22.
//  https://github.com/sameersyd/FortuneWheel
//  Modifications by Jonny Klemmer on 01/11/22.
//

import SwiftUI

public class FortuneWheelViewModel: ObservableObject {
    @Published var degree = 0.0
    @Published var winner: String?
    @Published var counter = 0

    let titles: [String]
    let weights: [Int]
    let colors: [Color]
    let pointerColor: Color
    let strokeWidth: CGFloat
    let strokeColor: Color
    let animDuration: Double
    let animation: Animation
    let getWheelItemIndex: (() -> (Int))? // TODO: WAT IS THIS

    private var pendingRequestWorkItem: DispatchWorkItem?

    public init(
        titles: [String],
        weights: [Int],
        colors: [Color]? = nil,
        pointerColor: Color? = nil,
        strokeWidth: CGFloat = 15,
        strokeColor: Color? = nil,
        animDuration: Double = Double(6),
        animation: Animation? = nil,
        getWheelItemIndex: (() -> (Int))? = nil
    ) {
        self.titles = titles
        self.weights = weights
        self.colors = colors ?? Color.wheelColors
        self.pointerColor = pointerColor ?? Color.wheelPointer
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor ?? Color.wheelBorder
        self.animDuration = animDuration
        self.animation = animation ?? Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animDuration)
        self.getWheelItemIndex = getWheelItemIndex
    }

    func spinWheel() {
        withAnimation(animation) {
            self.degree = Double(360 * Int(self.degree / 360)) + getWheelStopDegree();
        }
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            let count = self.titles.count
            let distance = self.degree.truncatingRemainder(dividingBy: 360)
            let pointer = floor(distance / (360 / Double(count)))
            let index = count - Int(pointer) - 1
            self.handleSpinEnded(onIndex: index)
        }
        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration, execute: requestWorkItem)
    }

    private func getWheelStopDegree() -> Double {
        let randomDegree = Int.random(in: 180...360)
        let randomSpins = Int.random(in: 6...20)
        let finalDegree = randomSpins * (360 + randomDegree)

        return Double(finalDegree)
    }

    private func handleSpinEnded(onIndex index: Int) {
        guard titles.indices.contains(index) else {
            print("WHEEL LANDED IN A BAD SPOT")
            return
        }

        DispatchQueue.main.async {
            let winner = self.titles[index]
            self.winner = winner
            print("Wheel Winner: \(winner)")
            self.counter += 1
        }
    }
}
