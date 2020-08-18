//
//  CircleView.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 16/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//
// https://github.com/murphys-law/BuildingCustomViewsSwiftUI/blob/master/BuildingCustomViewsSwiftUI/ContentView.swift
// https://developer.apple.com/videos/play/wwdc2019/237

import SwiftUI

struct CircleView: View {
    @EnvironmentObject var ring: Ring
    @State private var drawStyle: Int = 0
    var spectrum: Gradient {
        Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
    }
    var conic: AngularGradient {
        AngularGradient(gradient: spectrum, center: .center, angle: .degrees(-90))
    }
    var body: some View {
        VStack(spacing: 10) {
            Picker(selection: $drawStyle, label: Text("What is your favorite color?")) {
                Text("Fill").tag(0)
                Text("Stroke").tag(1)
                Text("Animation").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.all)
            
            DrawingView(drawStyle: $drawStyle, conic: conic)
            
            Button(action: {
                self.ring.addWedge()
            }) {
                Text("Add Wedge")
            }
        }.padding(.top)
        
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView().environmentObject(Ring(wedges:
            [
            0: Ring.Wedge(startAngle: Angle(radians: 0), width: 0.3, depth: 0.5, hue: 0),
            1: Ring.Wedge(startAngle: Angle(radians: 1), width: 0.1, depth: 1, hue: 0.1),
            2: Ring.Wedge(startAngle: Angle(radians: 2), width: 0.3, depth: 0.2, hue: 0.5),
            3: Ring.Wedge(startAngle: Angle(radians: 3), width: 0.2, depth: 0.8, hue: 0.9)
            ])
        )
    }
}

struct DrawingView: View {
    @EnvironmentObject var ring: Ring
    @Binding var drawStyle: Int
    var conic: AngularGradient
    var body: some View {
        switch drawStyle {
        case 0: return AnyView(
            Circle()
                .fill(conic)
                .padding(.all, 50)
            )
        case 1: return AnyView(
            Circle()
                .strokeBorder(conic, lineWidth: 30)
                .padding(.all, 50)
            )
        default:
            let wedges = ZStack {
                ForEach(ring.wedgeIDs, id: \.self) { id in
                    WedgeView(wedge: self.ring.wedges[id]!)
                    .onTapGesture {
                        withAnimation {
                            self.ring.deleteWedge(with: id)
                        }
                    }
                }
            }
            .flipsForRightToLeftLayoutDirection(true)
            .padding()
            
            // this a special way of drawing graphics, we wrap the wedge container in a drawing group so that
            // everything draws into a single CALayer using Metal.
            // The CALayer content are rendered by the app, removing the
            // rendering work from the shared render server.
            let drawWedges = wedges.drawingGroup()
            return AnyView( drawWedges)
        }
    }
}

struct WedgeView: View {
    var wedge: Ring.Wedge
    
    var body: some View {
        WedgeShape(wedge: wedge)
            .fill(AngularGradient(gradient:
                Gradient(colors:
                    [Color(hue: wedge.hue, saturation: 1, brightness: 1),
                    Color(hue: wedge.hue, saturation: 1, brightness: 0.3)]),
                                  center: .center))
            .transition(self.scaleAndfade) // custom transition for insertion and deletion
    }
    
    var scaleAndfade: AnyTransition {
        AnyTransition.modifier(active: ScaleAndFade(isActive: true),
                               identity: ScaleAndFade(isActive: false))
    }
    
}

struct ScaleAndFade: ViewModifier {
    var isActive: Bool
    
    func body(content: Content) -> some View {
        return content
            .scaleEffect(isActive ? 0.1 : 1)    // scale: 10% or 100%
            .opacity(isActive ? 0 : 1)          // opacity: 0% or 100%
    }
    
}
