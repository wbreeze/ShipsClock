//
  // ShipsClock
  // Created by Douglas Lovell on 7/29/20.
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

/*
 Moon longitude calculation following:
 The lunar theory ELP revisited. Introduction of new planetary perturbations
 J.  Chapront, G.  Francou
 A&A 404 (2) 735-742 (2003)
 DOI: 10.1051/0004-6361:20030529
 
 and
 
 LUNAR SOLUTION ELP version ELP/MPP02
 Jean CHAPRONT and G ́erard FRANCOU Observatoire de Paris -SYRTE department - UMR 8630/CNRS October 2002
 */
struct MoonCalculator {
    static func sumOfProduct(_ a1:[Double], _ a2:[Double]) -> Double {
        return zip(a1,a2).map { a,b in
            a * b
        }.reduce(0.0, { a,b in
            a + b
        })
    }
    struct Perturbation {
        var x: Double
        var y: [Double]
        func value(_ t: [Double]) -> Double {
            x * sin(MoonCalculator.sumOfProduct(y,t))
        }
    }
    let epoch = 2451545.0 // calcs use base 2000-01-01 00:00 UT
    let cent = 36525.0 // 365.25 days / year * 100 years
    let rad = (365.0 * 60.0 * 60.0) / Double.pi
    let w = [3.81034, 8399.68473, -0.3e-04]
    let mp = [
        Perturbation(x:22639.58588, y:[ 2.35555,  8328.69142,  0.15e-3]),
        Perturbation(x: 4586.43832, y:[ 8.04138,  7214.06287, -0.22e-3]),
        Perturbation(x: 2369.91394, y:[10.39693, 15542.75429, -0.70e-4])
    ]
    
    func longitude(julianDay jd: Double) -> Double {
        let tc = (jd - epoch) / cent
        let t = [1.0, tc, tc * tc]
        return mp.reduce(0.0, { lon, term in
            lon + term.value(t)
        }) / rad + MoonCalculator.sumOfProduct(w,t)
    }
}
