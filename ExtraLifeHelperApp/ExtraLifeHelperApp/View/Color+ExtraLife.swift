//
//  Color+ExtraLife.swift
//  ExtraLifeHelperApp
//
//  Created by Jonny Klemmer on 11/4/22.
//

import Foundation
import SwiftUI

extension Color {
    static let wheelColors: [Color] = [
        Color(hex: "EDF8FC"),
        Color(hex: "DCF1FA"),
        Color(hex: "B8E2F5"),
        Color(hex: "94D3F0"),
        Color(hex: "70C4EB"),
        Color(hex: "4CB5E6"),
    ]

    static let wheelText = Color(hex: "040F16")
    static let wheelPinRim = Color(hex: "000022")
    static let wheelPinTop = Color(hex: "001242")
    static let wheelPointer = Color(hex: "5EBFE7")
    static let wheelBorder = Color(hex: "156A8E")

    init(hex: String, alpha: Double = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }

        let scanner = Scanner(string: cString)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(.sRGB, red: Double(r) / 0xff, green: Double(g) / 0xff, blue:  Double(b) / 0xff, opacity: alpha)
    }
}
