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
    
    var body: some View {
        createPoints(numberOfSides: numberOfSides)
        return NavigationView {
            VStack  {
                Form {
                    Stepper(value: $numberOfSides, in: 3...12, label: { Text("Number of sides: \(numberOfSides)")})
                    Toggle(isOn: $filledPolygon) { Text("Filled")}
                }
                    .frame(maxHeight: 124)
                     .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    Text("\(Polygons())")
                        .font(.system(size: 28))
                        .padding(.bottom, 10)
                    Text("The sum of interior angles: \(Radians()[0], specifier: "%.0f")° and \(Radians()[1], specifier: "%.0f") rad")
                    Path { path in
                        path.move(
                            to: CGPoint(
                                x: PolygonParameters.points[0].xFactor,
                                y: PolygonParameters.points[0].yFactor
                            )
                        )
                        
                        PolygonParameters.points.forEach {
                            path.addLine(
                                to: .init(
                                    x: $0.xFactor,
                                    y: $0.yFactor
                                )
                            )
                        }
                        path.closeSubpath()
                    }
                    .fill( LinearGradient(
                               gradient: Gradient(colors: [.green, .white]),
                               startPoint: .top,
                               endPoint: .bottom
                           ))
                    .opacity(0.9)
                }
             .navigationBarTitle(Text("HelloPoly"))
        }
    }
    
    func Polygons() -> String {
        switch numberOfSides {
        case 3:
           return "Triangle"
        case 4:
            return "Quadrilateral or Tetragon"
        case 5:
            return "Pentagon"
        case 6:
            return "Hexagon"
        case 7:
            return "Heptagon or Septagon"
        case 8:
            return "Octagon"
        case 9:
            return "Nonagon or Enneagon"
        case 10:
            return "Decagon"
        case 11:
            return "Hendecagon or Undecagon"
        default:
           return "Dodecagon or Duodecagon"
        }
    }
    
    func Radians() -> [Double] {
        return [Double((numberOfSides-2) * 180), Double((numberOfSides - 2)) * Double.pi]
    }
    
    func createPoints(numberOfSides: Int) {
        PolygonParameters.points.removeAll()
        for i in 0...numberOfSides-1 {
            PolygonParameters.points.append(
                PolygonParameters.Segment(
                    xFactor:  (CGFloat(175 + 100 * sin(Double(i) * 2 * Double.pi / Double(numberOfSides)))),
                    yFactor:  (CGFloat(150 + 100 * cos(Double(i) * 2 * Double.pi / Double(numberOfSides))))
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
