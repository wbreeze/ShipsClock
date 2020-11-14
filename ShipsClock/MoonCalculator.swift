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
        return zip(a1,a2).map { a,b -> Double in
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
    let rad = (180.0 * 60.0 * 60.0) / Double.pi
    let a405 = 384747.9613701725
    let aelp = 384747.980674318
    let w = [3.81034, 8399.68473, -0.3e-04]
    let p = 0.1e-04
    let q = 0.11e-03
    let mlonp = [
        Perturbation(x: 22639.58588, y:[ 2.35555,  8328.69142,  0.15e-3]),
        Perturbation(x:  4586.43832, y:[ 8.04138,  7214.06287, -0.22e-3]),
        Perturbation(x:  2369.91394, y:[10.39693, 15542.75429, -0.70e-4])
    ]
    let mlatp = [
        Perturbation(x: 18461.24006, y:[ 1.62791,  8433.46616, -0.60e-4]),
        Perturbation(x:   999.69366, y:[ 0.72765,  -104.77473,  0.22e-3]),
        Perturbation(x:  1010.16715, y:[ 3.98346, 16762.15758,  0.90e-4])
    ]
    let mdistp = [
        Perturbation(x:385000.52904, y:[ 1.57080,     0.0    ,  0.0    ]),
        Perturbation(x:-20905.35514, y:[ 3.92635,  8328.69142,  0.15e-3]),
        Perturbation(x: -3699.11093, y:[ 9.61218,  7214.06287, -0.22e-3]),
        Perturbation(x: -2955.96756, y:[11.96773, 15542.75429, -0.70e-4])
    ]

    func longitude(julianDay jd: Double) -> Double {
        let tc = (jd - epoch) / cent
        let t = [1.0, tc, tc * tc]
        return mlonp.reduce(0.0, { lon, term in
            lon + term.value(t)
        }) / rad + MoonCalculator.sumOfProduct(w,t)
    }
    
    func latitude(julianDay jd: Double) -> Double {
        let tc = (jd - epoch) / cent
        let t = [1.0, tc, tc * tc]
        return mlatp.reduce(0.0, { lon, term in
            lon + term.value(t)
        }) / rad
    }

    func distance(julianDay jd: Double) -> Double {
        let tc = (jd - epoch) / cent
        let t = [1.0, tc, tc * tc]
        return mdistp.reduce(0.0, { lon, term in
            lon + term.value(t)
        }) * a405 / aelp
    }
    
    func location(julianDay jd: Double) -> ( x: Double, y: Double, z: Double ) {
        let tc = (jd - epoch) / cent
        let t = [1.0, tc, tc * tc]
        
        let lat = mlatp.reduce(0.0, { acc, term in
            acc + term.value(t)
        }) / rad
        let lon = mlonp.reduce(0.0, { acc, term in
            acc + term.value(t)
        }) / rad + MoonCalculator.sumOfProduct(w,t)
        let dist = mdistp.reduce(0.0, { acc, term in
            acc + term.value(t)
        }) * a405 / aelp
        
        let clamb = cos(lon)
        let slamb = sin(lon)
        let cbeta = cos(lat)
        let sbeta = sin(lat)
        let cw = dist * cbeta
        let sw = dist * sbeta
        let x1 = cw * clamb
        let x2 = cw * slamb
        let x3 = sw
        let pw = p * tc
        let qw = q * tc
        let ra = 2.0 * sqrt(1 - pw * pw - qw * qw)
        let pwqw = 2.0 * pw * qw
        let pw2 = 1.0 - 2.0 * pw * pw
        let qw2 = 1.0 - 2.0 * qw * qw
        let pwra = pw * ra
        let qwra = qw * ra

        return (
            x: pw2 * x1 + pwqw * x2 + pwra * x3,
            y: pwqw * x1 + qw2 * x2 - qwra * x3,
            z: -pwra * x1 + qwra * x2 + (pw2 + qw2 - 1.0) * x3
        )
    }
}
