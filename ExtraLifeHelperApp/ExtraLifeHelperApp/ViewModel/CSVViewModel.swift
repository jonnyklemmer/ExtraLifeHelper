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
    @Published private(set) var games: [String] = []
    @Published private(set) var gameWeights: [Int] = []

    // Donations where fulfillment note was accidentally missed
    private let overrides = [
        "10/28/2022 1:51PM": "Path of Exile",
        "10/29/2022 8:50PM": "Jump King"
    ]

    // Cleaning up game requests to fit on wheel better
    private let gameNameMapping = [
        "One of my favorite Steam titles ever... Portal 2. The game has everything!": "Portal 2",
        "Powerwashing simulator or post apocalyptic stray cat are the vibes i'm after": "Powerwash / Stray"
    ]

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
                // Filter out donations without incentives
                return nil
            }

            let donator = lineElements[0]
            let timestamp = lineElements[4]
            var fulfillmentNote = lineElements[9]
            if let override = overrides[timestamp], override.isEmpty == false {
                fulfillmentNote = override
            }

            return Donation(
                timestamp: timestamp,
                donator: donator,
                incentive: incentive,
                fulfillmentNote: fulfillmentNote
            )
        }

        updateDonations(newDonations)
    }

    private func updateDonations(_ newDonations: [Donation]) {
        self.donations = newDonations

        let newDonationsWithGames = newDonations.filter { donation in
            (donation.incentive == .addGame || donation.incentive == .addGameForce) && donation.fulfillmentNote.isEmpty == false
        }

        var newGames: [String:Int] = [:]

        newDonationsWithGames.forEach { donation in
            var gameName = donation.fulfillmentNote
            if let shortenedName = gameNameMapping[gameName], shortenedName.isEmpty == false {
                gameName = shortenedName
            }

            if let gameCount = newGames[gameName], gameCount > 0 {
                newGames[gameName] = gameCount + 1
            } else {
                newGames[gameName] = 1
            }
        }

        self.donationsWithGames = newDonationsWithGames
        self.games = Array(newGames.keys)
        self.gameWeights = Array(newGames.values)
    }
}
