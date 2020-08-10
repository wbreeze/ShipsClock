//
  // ShipsClock
  // Created by Douglas Lovell on 8/4/20.
  // Copyright © 2020 Douglas Lovell
  /*
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
  */

import Foundation

struct PertTerms {
    let power: Int
    let big_s: Double
    let big_c: Double
    let i: [Int]

    init(_ power: Int,
         _ big_s: Double, _ big_c: Double,
         _ i1: Int, _ i2: Int, _ i3: Int, _ i4: Int,
         _ i5: Int, _ i6: Int, _ i7: Int, _ i8: Int,
         _ i9: Int, _ i10: Int, _ i11: Int, _ i12: Int,
         _ i13: Int, _ i14: Int, _ i15: Int, _ i16: Int
         ) {
        self.power = power
        self.big_s = big_s
        self.big_c = big_c
        i = [i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13]
    }

    func value(time t: Double, delaunay: Delaunay) -> Double {
        let theta = Arcs.radiansGiven(degrees:
          Double(i[0]) * delaunay.d + Double(i[1]) * delaunay.f +
          Double(i[2]) * delaunay.l + Double(i[3]) * delaunay.lp
        )
        var value = big_s * sin(theta) + big_c * cos(theta)
        for _ in 0..<power {
            value *= t
        }
        return value
    }

    // The terms need to be read and computed line by line from a file.
    // Reading the entire file into memory will be unnecessarily demanding
    // Creating an array data structure from the terms causes system
    // memory exhaustion from Xcode.
    
    func pertLon() -> [PertTerms] {
        return []
    }
}
