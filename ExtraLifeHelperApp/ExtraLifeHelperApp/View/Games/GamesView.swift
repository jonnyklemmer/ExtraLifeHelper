//
//  GamesView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/20/22.
//

import SwiftUI

struct GamesView: View {
    @EnvironmentObject private var viewModel: CSVViewModel

    var body: some View {
        Table(viewModel.donationsWithGames) {
            TableColumn("Name", value: \.donator)
            TableColumn("Game", value: \.fulfillmentNote)
        }
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
