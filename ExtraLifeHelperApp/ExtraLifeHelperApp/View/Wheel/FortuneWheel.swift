//
//  FortuneWheel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//

import SwiftUI

@available(macOS 11.0, *)
@available(iOS 14.0, *)

public struct FortuneWheel: View {

    private let model: FortuneWheelModel
    private let diameter: CGFloat
    @StateObject private var viewModel: FortuneWheelViewModel
    
    public init(model: FortuneWheelModel, diameter: CGFloat) {
        self.model = model
        self.diameter = diameter
        _viewModel = StateObject(wrappedValue: FortuneWheelViewModel(model: model))
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                SpinWheelView(
                    data: (0..<model.titles.count).map { index in
                        let weight = model.weights[index]
                        let oneSlice = (100 / model.titles.count)
                        return Double(weight*oneSlice)
                    },
                    labels: model.titles,
                    colors: model.colors
                )
                .frame(width: diameter, height: diameter)
                .overlay(
                    RoundedRectangle(cornerRadius: diameter / 2)
                        .stroke(lineWidth: model.strokeWidth)
                        .foregroundColor(model.strokeColor)
                )
                .rotationEffect(.degrees(viewModel.degree))
                .onTapGesture {
                    viewModel.spinWheel()
                }

                SpinWheelBolt()
            }
            SpinWheelPointer(pointerColor: model.pointerColor).offset(x: 0, y: -25)
        }
    }
}
