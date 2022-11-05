//
//  FortuneWheel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//  https://github.com/sameersyd/FortuneWheel
//  Modifications by Jonny Klemmer on 01/11/22.
//

import ConfettiSwiftUI
import SwiftUI

public struct FortuneWheel: View {
    private let diameter: CGFloat
    @ObservedObject private var viewModel: FortuneWheelViewModel

    /// TODO: Theres a bug here due to the param being created in the body
    /// and this wheel being unable to tell that it should update
    public init(viewModel: FortuneWheelViewModel, diameter: CGFloat) {
        self.diameter = diameter
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                ZStack(alignment: .center) {
                    SpinWheelView(
                        data: (0..<viewModel.titles.count).map { index in
                            // Remove support for weights (for now)
                            //                        let weight = viewModel.weights[index]
                            //                        let totalWeights = viewModel.weights.reduce(0, +)
                            //                        let percentOneSlice = (100 / totalWeights)
                            //                        return Double(weight * percentOneSlice)

                            let count = viewModel.titles.count
                            let percentOneSlice = (100 / count)
                            return Double(percentOneSlice)
                        },
                        labels: viewModel.titles,
                        colors: viewModel.colors
                    )
                    .frame(width: diameter, height: diameter)
                    .overlay(
                        RoundedRectangle(cornerRadius: diameter / 2)
                            .stroke(lineWidth: viewModel.strokeWidth)
                            .foregroundColor(viewModel.strokeColor)
                    )
                    .rotationEffect(.degrees(viewModel.degree))
                    .onTapGesture {
                        viewModel.spinWheel()
                    }

                    SpinWheelBolt()

                }
                SpinWheelPointer(pointerColor: viewModel.pointerColor).offset(x: 0, y: -25)
            }
            .rotationEffect(.degrees(90))

            ZStack(alignment: .center) {
                if viewModel.winner != nil {
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(20)

                    Text(viewModel.winner ?? "GLITCH!")
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(20)
                }
            }
            .confettiCannon(counter: $viewModel.counter, num: 100, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 500, repetitions: 3, repetitionInterval: 0.1)
            .fixedSize()
        }
    }
}
