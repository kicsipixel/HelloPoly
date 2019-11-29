//
//  Helper.swift
//  HelloPoly
//
//  Created by Szabolcs Toth on 27/11/2019.
//  Copyright © 2019 purzelbaum.hu. All rights reserved.
//

import SwiftUI

struct PolygonParameters {
    struct Segment {
        let xFactor: (CGFloat)
        let yFactor: (CGFloat)
    }

   static var points = [
        Segment(xFactor: CGFloat(), yFactor: CGFloat())
    ]
}
