//
//  FortuneWheelModel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 24/10/22.
//  https://github.com/sameersyd/FortuneWheel
//  Modifications by Jonny Klemmer on 01/11/22.
//

import SwiftUI

public class FortuneWheelViewModel: ObservableObject {
    @Published var degree = 0.0

    let titles: [String]
    let weights: [Int]
    let onSpinEnd: ((Int) -> ())?
    let colors: [Color]
    let pointerColor: Color
    let strokeWidth: CGFloat
    let strokeColor: Color
    let animDuration: Double
    let animation: Animation
    let getWheelItemIndex: (() -> (Int))? // TODO: WAT IS THIS

    private var pendingRequestWorkItem: DispatchWorkItem?

    public init(
        titles: [String],
        weights: [Int],
        onSpinEnd: ((Int) -> ())?,
        colors: [Color]? = nil,
        pointerColor: Color? = nil,
        strokeWidth: CGFloat = 15,
        strokeColor: Color? = nil,
        animDuration: Double = Double(6),
        animation: Animation? = nil,
        getWheelItemIndex: (() -> (Int))? = nil
    ) {
        self.titles = titles
        self.weights = weights
        self.onSpinEnd = onSpinEnd
        self.colors = colors ?? Color.wheelColors
        self.pointerColor = pointerColor ?? Color.wheelPointer
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor ?? Color.wheelBorder
        self.animDuration = animDuration
        self.animation = animation ?? Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animDuration)
        self.getWheelItemIndex = getWheelItemIndex
    }

    func spinWheel() {
        withAnimation(animation) {
            self.degree = Double(360 * Int(self.degree / 360)) + getWheelStopDegree();
        }
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            let count = self.titles.count
            let distance = self.degree.truncatingRemainder(dividingBy: 360)
            let pointer = floor(distance / (360 / Double(count)))
            if let onSpinEnd = self.onSpinEnd {
                onSpinEnd(count - Int(pointer) - 1)
            }
        }
        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration + 1, execute: requestWorkItem)
    }

    private func getWheelStopDegree() -> Double {
        let randomDegree = Int.random(in: 0...360)
        let randomSpins = Int.random(in: 4...20)
        let finalDegree = randomSpins * (360 + randomDegree)

        return Double(finalDegree)
    }
}

extension Color {
//    static let wheelColors: [Color] = [
//        Color(hex: "F1F7EE"),
//        Color(hex: "E0EDC5"),
//        Color(hex: "99D19C"),
//        Color(hex: "C0E6DE"),
//        Color(hex: "BCD3F2"),
//        Color(hex: "E6AACE"),
//        Color(hex: "FFC6AC"),
//        Color(hex: "EFBC9B"),
//        Color(hex: "C6AFB1"),
//        Color(hex: "F2D0A4")
//    ]

    static let wheelColors: [Color] = [
//        Color(hex: "9FA5A8"),
//        Color(hex: "B4B9BB"),
//        Color(hex: "C9CDCF"),
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
