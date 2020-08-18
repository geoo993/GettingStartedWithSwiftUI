//
//  RingStyle.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 16/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI
import Combine

class Ring: NSObject, ObservableObject {
    struct Wedge: Equatable, Identifiable {
        var id = UUID()
        var startAngle: Angle // where 1.0 = a whole circle
        var width: Double
        var depth: Double
        var hue: Double
    }
    
    @Published var wedges: [Int: Wedge]
    @Published var wedgeIDs: [Int]
    
    init(wedges: [Int: Wedge]) {
        self.wedges = wedges
        self.wedgeIDs = Array(wedges.keys)
    }
    
    func addWedge() {
        guard let lastID = wedgeIDs.last else {
            wedgeIDs = [0]
            wedges[0] = Wedge(startAngle: Angle(degrees: 360 * Double.random(in: 0..<1)),
                              width: Double.random(in: 0..<1),
                              depth: Double.random(in: 0..<1),
                              hue: Double.random(in: 0..<1))
            return
        }
        let newID = lastID + 1
        let previous = wedges[lastID]!
        let newAngle = previous.startAngle + Angle(degrees: 360 * Double.random(in: 0..<1))
        let newWidth = Double.random(in: 0..<1)

        wedges[newID] = Wedge(startAngle: newAngle, width: newWidth, depth: Double.random(in: 0..<1), hue: Double.random(in: 0..<1))
        wedgeIDs = Array(wedges.keys)
        return
    }
    
    func deleteWedge(with id: Int) {
        wedges.removeValue(forKey: id)
        wedgeIDs.removeAll(where: { $0 == id })
    }
    
}

extension Ring.Wedge: Animatable {
    typealias AnimatableData = AnimatablePair<Double, Double>
    
    var animatableData: AnimatableData {
        get {
            .init(width, depth)
        }
        set {
            width = newValue.first
            depth = newValue.second
        }
    }
    
}

// MARK: - WedgeShape

struct WedgeShape: Shape {
    var wedge: Ring.Wedge
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let g = WedgeGeometry(wedge, in: rect)
        
        // inner arc
        p.addArc(center: g.center, radius: g.innerRadius, startAngle: g.startAngle, endAngle: g.endAngle, clockwise: false)
        p.addLine(to: g.endOuter)
        
        // outer arc
        p.addArc(center: g.center, radius: g.outerRadius, startAngle: g.endAngle, endAngle: g.startAngle, clockwise: true)
        p.addLine(to: g.startInner)
        p.closeSubpath()
        
        return p
    }
    
    var animatableData: Ring.Wedge.AnimatableData {
        get {
            return wedge.animatableData
        }
        set {
            wedge.animatableData = newValue
        }
    }
}

extension WedgeShape {
    static func == (lhs: WedgeShape, rhs: WedgeShape) -> Bool {
        lhs.wedge == rhs.wedge
    }
}
