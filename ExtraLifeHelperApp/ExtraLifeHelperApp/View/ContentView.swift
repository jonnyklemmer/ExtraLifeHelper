//
//  ContentView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/19/22.
//

import SwiftUI

enum SelectedState {
    case incentives
    case games
    case wheel
}

struct ContentView: View {
    @EnvironmentObject var viewModel: CSVViewModel
    @Binding var document: CSVDocument
    @State var selected: Int = 0
    private let tabs: [SelectedState] = [.incentives, .games, .wheel]

    var body: some View {
        VStack {
            SegmentedPicker(items: ["incentives", "games", "wheel of games"], selection: $selected)
                .padding()

            switch selected {
            case 0:
                IncentivesView()
            case 1:
                GamesView()
            case 2:
                WheelView()
            default:
                EmptyView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(CSVDocument()))
    }
}
