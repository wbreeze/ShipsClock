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
 */
struct MoonCalc {
    let epoch = 2451545.0 // calcs use base 2000-01-01 00:00 UT

    struct Delaunay {
        let d, f, l, lp : Double
        
        static func dms(_ d: Int, _ m:Int, _ s: Double) -> Double {
            return Double(d) + Double(m) / 60.0 + s / 3600.0
        }
        
        init(julianDay2000 t: Double) {
            let t2 = t * t
            let ts = t / 3600.0
            let t2s = t2 / 3600.0
            let t3s = t2 * t / 3600.0
            let t4s = t2 * t2 / 3600.0
            let w1 = Delaunay.dms(218, 18, 59.955_71) +
                1_732_559_343.736_04 * ts -
                6.808_4 * t2s +
                0.006_604 * t3s -
                0.000_031_69 * t4s
            let w2 = Delaunay.dms(83, 21, 11.674_75) +
                14_643_420.317_1 * ts -
                38.263_1 * t2s -
                0.045_047 * t3s +
                0.000_213_01 * t4s
            let w3 = Delaunay.dms(125, 2, 40.398_16) -
                6_967_919.538_3 * ts +
                6.359 * t2s +
                0.007_625 * t3s -
                0.000_035_86 * t4s
            let big_t = Delaunay.dms(100, 27, 59.138_85) -
                129_597_742.293 * ts -
                0.020_2 * t2s +
                0.000_009 * t3s +
                0.000_000_15 * t4s
            let omega = Delaunay.dms(102, 56, 14.457_66) +
                1_161.243_42 * ts +
                0.529_265 * t2s -
                0.000_118_14 * t3s +
                0.000_011_379 * t4s
            d = w1 - big_t + 180.0
            f = w1 - w3
            l = w1 - w2
            lp = big_t - omega
        }
    }
    
    struct MainTerms {
        let i: [Int]
        let a: Double
        let b: [Double]
        
        init(_ i1: Int, _ i2: Int, _ i3: Int, _ i4: Int,
                  _ a: Double,
                  _ b1: Double, _ b2: Double, _ b3: Double,
                  _ b4: Double, _ b5: Double, _ b6: Double) {
            i = [i1, i2, i3, i4]
            self.a = a
            b = [b1, b2, b3, b4, b5, b6]
        }
        
        func value(_ delaunay: Delaunay) -> Double {
            a * sin(
                Arcs.radiansGiven(degrees:
                    Double(i[0]) * delaunay.d +
                        Double(i[1]) * delaunay.f +
                        Double(i[2]) * delaunay.l +
                        Double(i[3]) * delaunay.lp
                )
            )
        }
    }
    
    /*
     Terms taken from ELP_MAIN.S1 where the absolute value of the A term is greater than 4.0
     */
    let mainLon = [
        MainTerms(0, 2, 0, 0, -411.60287, 168.48, -18433.81, -121.62, 0.40, -0.18, 1),
        MainTerms(0, -2, 1, 0, 39.53393, -395.24, 1788.33, 720.91, -2.60, 0.90, 1),
        MainTerms(0, 0, 1, 0, 22639.55000, 0.00, 0.00, 412529.61, 0.00, 0.00, 1),
        MainTerms(0, 2, 1, 0, -45.10032, 17.41, -2019.78, -830.20, 0.09, -0.02, 1),
        MainTerms(0, 0, 2, 0, 769.02326, -257.51, -47.39, 28008.99, -6.83, -0.56, 1),
        MainTerms(0, 0, 3, 0, 36.12364, -28.42, -5.10, 1972.74, -0.93, -0.08, 1),
        MainTerms(0, 0, -2, 1, -9.67938, -235.29, 4.90, -352.52, -579.94, -0.15, 1),
        MainTerms(0, 0, -1, 1, -147.32654, -3778.62, 68.68, -2688.53, -8829.17, -0.76, 1),
        MainTerms(0, 0, 0, 1, -666.44186, -5206.84, 258.79, -555.98, -39887.79, 1.73, 1),
        MainTerms(0, 0, 1, 1, -109.38419, -2193.78, 51.64, -2018.13, -6556.10, 0.54, 1),
        MainTerms(0, 0, 2, 1, -7.63041, -156.07, 4.09, -279.89, -457.41, 0.12, 1),
        MainTerms(0, 0, 0, 2, -7.44804, -12.64, 2.98, -9.32, -891.27, 0.03, 1),
        MainTerms(1, 0, -1, 0, -18.58467, -437.66, 18.91, -346.51, -1.00, -7226.22, 1),
        MainTerms(1, 0, 0, 0, -124.98806, -2831.88, 136.18, -86.60, -2.68, -48598.15, 1),
        MainTerms(1, 0, 1, 0, -8.45308, -187.78, 10.10, -158.62, 0.77, -3286.75, 1),
        MainTerms(1, 0, 0, 1, 17.95512, 6.59, -11.64, 21.84, 1074.24, 6981.34, 1),
        MainTerms(2, 0, -1, -2, 7.37173, 165.38, -1.06, 134.79, 881.89, -0.04, 1),
        MainTerms(2, 0, 0, -2, 8.05076, 289.14, -3.14, 21.09, 962.91, -0.06, 1),
        MainTerms(2, 0, -2, -1, 8.60582, 187.04, -1.14, 313.85, 515.03, 0.02, 1),
        MainTerms(2, 0, -1, -1, 205.44315, 4157.78, -32.99, 3751.43, 12284.72, -0.13, 1),
        MainTerms(2, 0, 0, -1, 164.73458, 5378.28, -77.43, 545.71, 9844.15, -0.18, 1),
        MainTerms(2, 0, 1, -1, 14.53078, 497.46, -9.38, 307.25, 867.99, 0.00, 1),
        MainTerms(2, 0, -3, 0, 13.19400, 279.87, -3.19, 721.29, 0.65, 0.14, 1),
        MainTerms(2, 0, -2, 0, 211.65487, 4685.54, -42.06, 7715.64, 7.86, 2.12, 1),
        MainTerms(2, 0, -1, 0, 4586.43061, 87132.46, -842.12, 83586.18, -191.17, 20.31, 1),
        MainTerms(2, 2, -1, 0, -9.36601, -173.58, -417.66, -173.70, 0.48, -0.06, 1),
        MainTerms(2, -2, 0, 0, 55.17801, 530.97, 2463.55, -15.35, -6.96, 1.20, 1),
        MainTerms(2, 0, 0, 0, 2369.91227, 69551.14, -1472.50, 10817.07, -255.36, 22.07, 1),
        MainTerms(2, 2, 0, 0, -5.74170, -155.85, -254.00, -59.77, 0.64, -0.10, 1),
        MainTerms(2, -2, 1, 0, -6.38325, -72.70, -288.51, -117.47, 1.16, 0.00, 1),
        MainTerms(2, 0, 1, 0, 191.95575, 5619.27, -153.09, 4250.55, -30.10, 2.78, 1),
        MainTerms(2, 0, 2, 0, 14.37964, 417.80, -13.71, 577.47, -3.08, 0.28, 1),
        MainTerms(2, 0, -1, 1, -28.39810, 915.46, -16.70, -528.73, -1693.30, -0.38, 1),
        MainTerms(2, 0, 0, 1, -24.35910, -661.00, 29.13, -128.06, -1457.61, -5.21, 1),
        MainTerms(4, 0, -1, -1, 4.37416, 221.00, -3.71, 93.87, 260.99, -0.05, 1),
        MainTerms(4, 0, -2, 0, 30.77247, 1164.74, -12.42, 1123.35, -4.25, 1.18, 1),
        MainTerms(4, 0, -1, 0, 38.42974, 1853.28, -37.86, 849.77, -9.84, 0.08, 1),
        MainTerms(4, 0, 0, 0, 13.89903, 782.37, -19.88, 215.74, -5.22, 1.37, 1),
    ]
    
    var delaunay: Delaunay
    
    init(julianDay jd: Double) {
        let time = jd - epoch
        delaunay = Delaunay(julianDay2000: time)
    }
    
    func longitude() -> Double {
        return mainLon.reduce(0.0, { lon, term in
            return lon + term.value(delaunay)
        }) / 3600.0
    }
}
