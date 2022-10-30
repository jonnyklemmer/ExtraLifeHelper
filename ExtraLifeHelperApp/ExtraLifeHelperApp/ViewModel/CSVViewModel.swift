//
//  CSVViewModel.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 10/29/22.
//

import Foundation

enum Incentive: String {
    case spinWheel = "Spin Wheel"
    case addGame = "Add Game to Wheel"
    case addGameForce = "Add & Force Next Game"
}
struct Donation: Identifiable {
    let id = UUID()
    let timestamp: String
    let donator: String
    let incentive: Incentive
    let fulfillmentNote: String
}

class CSVViewModel: ObservableObject {
    @Published private(set) var donations: [Donation] = []
    @Published private(set) var donationsWithGames: [Donation] = []
    @Published private(set) var games: [String] = ["Path Of Exile", "HoN", "Dota2"]
    @Published private(set) var gameWeights: [Int] = [2,1,2]

    func loadCSVData(data: String) {
        let lines = data.split(whereSeparator: \.isNewline)

        let filteredLines = lines.dropFirst(3)

        let parsedData: [[String]] = filteredLines.map { line in
            let elements = line.components(separatedBy: ",")

            return elements
        }

        let newDonations: [Donation] = parsedData.compactMap { lineElements in
            guard
                lineElements.indices.count == 10,
                let incentive = Incentive(rawValue: lineElements[8])
            else {
                print("WE GOT PROBLEMS!")
                return nil
            }

            return Donation(
                timestamp: lineElements[4],
                donator: lineElements[0],
                incentive: incentive,
                fulfillmentNote: lineElements[9]
            )
        }

        updateDonations(newDonations)
    }

    private func updateDonations(_ newDonations: [Donation]) {
        self.donations = newDonations

        let newDonationsWithGames = newDonations.filter { donation in
            donation.incentive == .addGame || donation.incentive == .addGameForce
        }

        var newGames: [String:Int] = [:]

        newDonationsWithGames.forEach { donation in
            guard donation.fulfillmentNote.isEmpty == false else { return }

            if let gameCount = newGames[donation.fulfillmentNote], gameCount > 0 {
                newGames[donation.fulfillmentNote] = gameCount + 1
            } else {
                newGames[donation.fulfillmentNote] = 1
            }
        }

        self.donationsWithGames = newDonationsWithGames
        self.games = Array(newGames.keys)
        self.gameWeights = Array(newGames.values)
    }
}
