//
//  WheelView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/20/22.
//

import Combine
import SwiftUI

struct WheelView: View {
    @EnvironmentObject private var viewModel: CSVViewModel
    private var cancellable: AnyCancellable?

    private let widthScalar = 0.9

    var body: some View {
        GeometryReader { geometry in
            let viewModel = FortuneWheelViewModel(
                titles: viewModel.games,
                weights: viewModel.gameWeights,
                onSpinEnd: onSpinEnd
            )

            VStack {
                Spacer(minLength: 20)
                HStack {
                    Spacer(minLength: 20)
                    FortuneWheel(viewModel: viewModel, diameter: calcSize(for: geometry.size))
                    Spacer(minLength: 20)
                }
                Spacer(minLength: 20)
            }
        }
    }

    private func calcSize(for size: CGSize) -> CGFloat {
        let tall = min(size.width, size.height)
        return tall * widthScalar
    }

    private func onSpinEnd(index: Int) {
        print("New game: \(viewModel.games[index])")
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView()
    }
}
