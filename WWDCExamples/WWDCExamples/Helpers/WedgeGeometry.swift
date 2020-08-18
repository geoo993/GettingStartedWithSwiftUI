//
//  WedgeGeometry.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 16/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import Foundation
import SwiftUI

class WedgeGeometry {
    var wedge: Ring.Wedge
    var bounds: CGRect
    
    init(_ wedge: Ring.Wedge, in bounds: CGRect) {
        self.wedge = wedge
        self.bounds = bounds
    }
    
    lazy var center: CGPoint = {
        var x = bounds.origin.x
        var y = bounds.origin.y
    
        return CGPoint(x: x + bounds.width/2, y: y + bounds.height/2)
    }()
    
    lazy var startAngle: Angle = {
        return wedge.startAngle
    }()
    
    lazy var endAngle: Angle = {
        return Angle(degrees: 360 * wedge.width) + wedge.startAngle
    }()
    
    lazy var innerRadius = CGFloat(75)
    
    lazy var outerRadius: CGFloat = {
        return min(bounds.width, bounds.height) * CGFloat(wedge.depth)/2
    }()
    
    var startOuter: CGPoint {getPoint(startAngle, outerRadius)}
    
    var endOuter: CGPoint {getPoint(endAngle, outerRadius)}
    
    var startInner: CGPoint {getPoint(startAngle, innerRadius)}
    
    var endInner: CGPoint { getPoint(endAngle, innerRadius) }
    
    func getPoint(_ angle: Angle, _ radius: CGFloat) -> CGPoint {
        let x = center.x + (CGFloat(cos(angle.radians)) * radius)
        let y = center.y + (CGFloat(sin(angle.radians)) * radius)
        return CGPoint(x: x, y: y)
    }
}
