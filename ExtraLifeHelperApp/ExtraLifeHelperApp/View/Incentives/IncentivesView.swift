//
//  IncentivesView.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/20/22.
//

import SwiftUI

struct IncentivesView: View {
    @EnvironmentObject private var viewModel: CSVViewModel

    var body: some View {
        Table(viewModel.donations) {
            TableColumn("Timestamp", value: \.timestamp)
            TableColumn("Name", value: \.donator)
            TableColumn("Incentive", value: \.incentive.rawValue)
            TableColumn("Note", value: \.fulfillmentNote)
        }
    }
}

struct IncentivesView_Previews: PreviewProvider {
    static var previews: some View {
        IncentivesView()
            .environmentObject(CSVViewModel())
    }
}
