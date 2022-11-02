//
//  FortuneWheel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//  https://github.com/sameersyd/FortuneWheel
//  Modifications by Jonny Klemmer on 01/11/22.
//

import SwiftUI

public struct FortuneWheel: View {
    private let diameter: CGFloat
    @ObservedObject private var viewModel: FortuneWheelViewModel
    
    public init(viewModel: FortuneWheelViewModel, diameter: CGFloat) {
        self.diameter = diameter
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                SpinWheelView(
                    data: (0..<viewModel.titles.count).map { index in
                        let weight = viewModel.weights[index]
                        let totalWeights = viewModel.weights.reduce(0, +)
                        let percentOneSlice = (100 / totalWeights)
                        return Double(weight * percentOneSlice)
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
    }
}
