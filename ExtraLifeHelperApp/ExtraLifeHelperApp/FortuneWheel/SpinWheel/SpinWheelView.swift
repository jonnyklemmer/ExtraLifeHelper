//
//  SpinWheelView.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 19/04/21.
//  https://github.com/sameersyd/FortuneWheel
//  Modifications by Jonny Klemmer on 01/11/22.
//

import SwiftUI

struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY), control1: CGPoint(x: rect.maxX, y: rect.minY), control2: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct SpinWheelPointer: View {
    var pointerColor: Color
    var body: some View {
        Triangle().frame(width: 50, height: 50)
            .foregroundColor(pointerColor).cornerRadius(24)
            .rotationEffect(.init(degrees: 180))
            .shadow(color: Color(hex: "212121", alpha: 0.5), radius: 5, x: 0.0, y: 1.0)
    }
}

struct SpinWheelBolt: View {
    var body: some View {
        ZStack {
            Circle().frame(width: 28, height: 28)
                .foregroundColor(Color(hex: "F4C25B"))
            Circle().frame(width: 18, height: 18)
                .foregroundColor(Color(hex: "FFD25A"))
                .shadow(color: Color(hex: "404040", alpha: 0.35), radius: 3, x: 0.0, y: 1.0)
        }
    }
}

struct SpinWheelView: View {
    @State var data: [Double]
    var labels: [String]
    
    private let colors: [Color]
    private let sliceOffset: Double = -.pi / 2
    
    init(data: [Double], labels: [String], colors: [Color]) {
        self.data = data
        self.labels = labels
        self.colors = colors
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ForEach(0..<data.count, id: \.self) { index in
                    SpinWheelCell(
                        startAngle: startAngle(for: index),
                        endAngle: endAngle(for: index)
                    )
                    .fill(colors[index % colors.count])

                    Text(labels[index])
                        .font(Font.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(Color.wheelText)
                        .frame(width: (geo.size.width/2)*0.6)
                        .rotationEffect(.radians(avgAngle(for: index)), anchor: .center)
                        .offset(viewOffset(for: index, in: geo.size))
                        .minimumScaleFactor(0.5)
                        .zIndex(1)
                }
            }

        }
    }
    
    private func startAngle(for index: Int) -> Double {
        switch index {
        case 0: return sliceOffset
        default:
            let ratio: Double = data[..<index].reduce(0.0, +) / data.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }
    
    private func endAngle(for index: Int) -> Double {
        switch index {
        case data.count - 1: return sliceOffset + 2 * .pi
        default:
            let ratio: Double = data[..<(index + 1)].reduce(0.0, +) / data.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }

    private func avgAngle(for index: Int) -> CGFloat {
        let startAngle = startAngle(for: index)
        let endAngle = endAngle(for: index)
        return CGFloat((startAngle+endAngle)/2)
    }

    private func viewOffset(for index: Int, in size: CGSize) -> CGSize {
        let radius = min(size.width, size.height) / 3
        let angle = avgAngle(for: index)

        return CGSize(width: radius * cos(angle), height: radius * sin(angle))
    }
}
