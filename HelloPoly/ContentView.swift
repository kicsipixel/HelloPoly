    //
//  ContentView.swift
//  HelloPoly
//
//  Created by Szabolcs Toth on 27/11/2019.
//  Copyright © 2019 purzelbaum.hu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var numberOfSides: Int = 3
    @State var filledPolygon: Bool = true
    
    var arrayOfPoint = [Float]()
    
    struct Poly: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(
                    to: CGPoint(
                        x: rect.size.width / 2  + PolygonParameters.points[0].xFactor,
                        y: rect.size.height / 2 + PolygonParameters.points[0].yFactor
                    )
                )
                
                PolygonParameters.points.forEach {
                    path.addLine(
                        to: .init(
                            x: rect.size.width / 2 + $0.xFactor,
                            y: rect.size.height / 2 + $0.yFactor
                        )
                    )
                }
                path.closeSubpath()
            return path
        }
    }
    
    var body: some View {
        createPoints(numberOfSides: numberOfSides)
        
        return NavigationView {
            VStack  {
               VStack {
                    Stepper(value: $numberOfSides, in: 3...12, label: { Text("Number of sides: \(numberOfSides)")})
                    Toggle(isOn: $filledPolygon) { Text("Filled")}
                    Text("The interior angle is: \(Radians()[0], specifier: "%.0f")° or \(Radians()[1], specifier: "%.4f") rad")
                }
                .padding()
               .offset(y: -180)
                               
                Text("\(Polygons())")
                    .font(.system(size: 24))
                    .foregroundColor(filledPolygon ? .white  : .green)
                    .background(filledPolygon ?
                        Poly().fill(Color.green)
                            .overlay(Poly().stroke(Color.green)) :
                        Poly().fill(Color.white)
                            .overlay(Poly().stroke(Color.green, lineWidth: 2))
                    )
                }
             .navigationBarTitle(Text("HelloPoly"))
        }
    }
    
    func Polygons() -> String {
        switch numberOfSides {
        case 3:
           return "Triangle"
        case 4:
            return "Quadrilateral"
        case 5:
            return "Pentagon"
        case 6:
            return "Hexagon"
        case 7:
            return "Heptagon"
        case 8:
            return "Octagon"
        case 9:
            return "Nonagon"
        case 10:
            return "Decagon"
        case 11:
            return "Hendecagon"
        default:
           return "Dodecagon"
        }
    }
    
    func Radians() -> [Double] {
        return [Double((numberOfSides - 2) * 180 / numberOfSides), Double(Double(numberOfSides - 2) * Double.pi / Double(numberOfSides))]
    }
    
    func createPoints(numberOfSides: Int) {
        PolygonParameters.points.removeAll()
        for i in 0...numberOfSides-1 {
            PolygonParameters.points.append(
                PolygonParameters.Segment(
                    xFactor:  (CGFloat(-120 * sin(Double(i) * 2 * Double.pi / Double(numberOfSides)))),
                    yFactor:  (CGFloat(-120 * cos(Double(i) * 2 * Double.pi / Double(numberOfSides))))
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
