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
        Perturbation(x:   -411.59573, y:[    3.25581,   16866.93232,   -1.30e-04 ]),
        Perturbation(x:     39.53330, y:[   -0.90026,   -8538.24089,    2.80e-04 ]),
        Perturbation(x:  22639.58588, y:[    2.35555,    8328.69142,    1.50e-04 ]),
        Perturbation(x:    -45.09961, y:[    5.61137,   25195.62374,    2.00e-05 ]),
        Perturbation(x:    769.02572, y:[    4.71111,   16657.38285,    3.00e-04 ]),
        Perturbation(x:     36.12381, y:[    7.06666,   24986.07427,    4.60e-04 ]),
        Perturbation(x:   -147.32138, y:[   -2.39868,   -7700.38947,   -1.50e-04 ]),
        Perturbation(x:   -666.41754, y:[   -0.04313,     628.30196,   -0.00e+00 ]),
        Perturbation(x:   -109.38036, y:[    2.31243,    8956.99338,    1.50e-04 ]),
        Perturbation(x:    -18.58471, y:[    2.84291,    -557.31428,   -1.90e-04 ]),
        Perturbation(x:   -124.98812, y:[    5.19847,    7771.37715,   -3.00e-05 ]),
        Perturbation(x:     17.95447, y:[    5.15534,    8399.67910,   -4.00e-05 ]),
        Perturbation(x:    205.43595, y:[    8.08450,    6585.76091,   -2.20e-04 ]),
        Perturbation(x:    164.72862, y:[   10.44006,   14914.45233,   -6.00e-05 ]),
        Perturbation(x:     14.53028, y:[   12.79561,   23243.14376,    9.00e-05 ]),
        Perturbation(x:     13.19406, y:[    3.33027,   -9443.31998,   -5.20e-04 ]),
        Perturbation(x:    211.65555, y:[    5.68582,   -1114.62856,   -3.70e-04 ]),
        Perturbation(x:   4586.43832, y:[    8.04138,    7214.06287,   -2.20e-04 ]),
        Perturbation(x:     55.17706, y:[    7.14112,   -1324.17803,    6.00e-05 ]),
        Perturbation(x:   2369.91394, y:[   10.39693,   15542.75429,   -7.00e-05 ]),
        Perturbation(x:    191.95620, y:[   12.75249,   23871.44571,    9.00e-05 ]),
        Perturbation(x:     14.37970, y:[   15.10804,   32200.13714,    2.40e-04 ]),
        Perturbation(x:    -28.39710, y:[    7.99825,    7842.36482,   -2.20e-04 ]),
        Perturbation(x:    -24.35823, y:[   10.35381,   16171.05625,   -7.00e-05 ]),
        Perturbation(x:     30.77258, y:[   16.08276,   14428.12573,   -4.40e-04 ]),
        Perturbation(x:     38.42983, y:[   18.43831,   22756.81716,   -2.80e-04 ]),
        Perturbation(x:     13.89906, y:[   20.79387,   31085.50858,   -1.30e-04 ]),
    ]
    let mlatp = [
        Perturbation(x:  18461.24006, y:[    1.62791,    8433.46616,   -6.00e-05 ]),
        Perturbation(x:    999.69366, y:[    0.72765,    -104.77473,    2.20e-04 ]),
        Perturbation(x:   1010.16715, y:[    3.98346,   16762.15758,    9.00e-05 ]),
        Perturbation(x:     31.75967, y:[    3.08320,    8223.91669,    3.70e-04 ]),
        Perturbation(x:     61.91195, y:[    6.33901,   25090.84901,    2.40e-04 ]),
        Perturbation(x:     29.57660, y:[    8.81215,    6480.98618,    0.00e+00 ]),
        Perturbation(x:     15.56627, y:[    4.05792,   -9548.09472,   -3.10e-04 ]),
        Perturbation(x:    166.57412, y:[    6.41347,   -1219.40329,   -1.50e-04 ]),
        Perturbation(x:    199.48376, y:[    9.66928,   15647.52902,   -2.80e-04 ]),
        Perturbation(x:    623.65247, y:[    8.76903,    7109.28813,   -0.00e+00 ]),
        Perturbation(x:    117.26070, y:[   12.02484,   23976.22045,   -1.30e-04 ]),
        Perturbation(x:     33.35720, y:[   11.12458,   15437.97956,    1.50e-04 ]),
        Perturbation(x:     15.12155, y:[   14.38039,   32304.91187,    2.00e-05 ]),
        Perturbation(x:    -12.09415, y:[    8.72590,    7737.59009,   -0.00e+00 ]),
    ]
    let mdistp = [
        Perturbation(x: 385000.52904, y:[    1.57080,       0.00000,    0.00e+00 ]),
        Perturbation(x:     79.66057, y:[    0.67054,   -8538.24089,    2.80e-04 ]),
        Perturbation(x: -20905.35514, y:[    3.92635,    8328.69142,    1.50e-04 ]),
        Perturbation(x:   -569.92513, y:[    6.28191,   16657.38285,    3.00e-04 ]),
        Perturbation(x:    -23.21043, y:[    8.63746,   24986.07427,    4.60e-04 ]),
        Perturbation(x:   -129.62022, y:[   -0.82788,   -7700.38947,   -1.50e-04 ]),
        Perturbation(x:     48.88833, y:[    1.52767,     628.30196,   -0.00e+00 ]),
        Perturbation(x:    104.75529, y:[    3.88323,    8956.99338,    1.50e-04 ]),
        Perturbation(x:    108.74270, y:[    6.76926,    7771.37715,   -3.00e-05 ]),
        Perturbation(x:    -16.67472, y:[    6.72614,    8399.67910,   -4.00e-05 ]),
        Perturbation(x:     10.05620, y:[    7.29975,   -1742.93051,   -3.70e-04 ]),
        Perturbation(x:   -152.13781, y:[    9.65530,    6585.76091,   -2.20e-04 ]),
        Perturbation(x:   -204.58612, y:[   12.01086,   14914.45233,   -6.00e-05 ]),
        Perturbation(x:    -12.83140, y:[   14.36641,   23243.14376,    9.00e-05 ]),
        Perturbation(x:     14.40269, y:[    4.90107,   -9443.31998,   -5.20e-04 ]),
        Perturbation(x:    246.15848, y:[    7.25662,   -1114.62856,   -3.70e-04 ]),
        Perturbation(x:  -3699.11093, y:[    9.61218,    7214.06287,   -2.20e-04 ]),
        Perturbation(x:     10.32111, y:[    8.71192,   -1324.17803,    6.00e-05 ]),
        Perturbation(x:  -2955.96756, y:[   11.96773,   15542.75429,   -7.00e-05 ]),
        Perturbation(x:   -170.73308, y:[   14.32328,   23871.44571,    9.00e-05 ]),
        Perturbation(x:    -10.44476, y:[   16.67884,   32200.13714,    2.40e-04 ]),
        Perturbation(x:     24.20850, y:[    9.56905,    7842.36482,   -2.20e-04 ]),
        Perturbation(x:     30.82386, y:[   11.92460,   16171.05625,   -7.00e-05 ]),
        Perturbation(x:    -21.63634, y:[   17.65355,   14428.12573,   -4.40e-04 ]),
        Perturbation(x:    -34.78252, y:[   20.00911,   22756.81716,   -2.80e-04 ]),
        Perturbation(x:    -11.64995, y:[   22.36466,   31085.50858,   -1.30e-04 ]),
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
    
    /*
     Compute the hour angle of the moon in degrees relative
     to the given longitude at the given time.
     */
    func hourAngle(julianDay jd: Double, longitude lon: Double) -> Double {
        let xyz = location(julianDay: jd)
        let r = EclToEqu.spherical(x: xyz.x, y: xyz.y, z: xyz.z)
        let eclLon = Arcs.normalizedDegrees(for: r.azimuth)
        let eclLat = EclToEqu.inclinationToLatitude(r.inclination)
        let s = EclToEqu.eclipticToEquatorial(
            longitude: eclLon, latitude: eclLat)
        return CelestialTime.hourAngle(julianDay: jd,
                                       longitude: lon,
                                       rightAscension: s.rightAscension)
    }
}
