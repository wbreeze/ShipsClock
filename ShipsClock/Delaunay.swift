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

struct Delaunay {
    let w1, d, f, l, lp : Double
    
    init(julianDay2000 t: Double) {
        let tc = t / 100.0 // express t in centuries
        let tc2 = tc * tc
        let t1s = tc / 3600.0
        let t2s = tc2 / 3600.0
        let t3s = tc2 * tc / 3600.0
        let t4s = tc2 * tc2 / 3600.0
        w1 = Arcs.dmsToAngle(218, 18, 59.955_71) +
            1_732_559_343.736_04 * t1s -
            6.808_4 * t2s +
            0.006_604 * t3s -
            0.000_031_69 * t4s
        let w2 = Arcs.dmsToAngle(83, 21, 11.674_75) +
            14_643_420.317_1 * t1s -
            38.263_1 * t2s -
            0.045_047 * t3s +
            0.000_213_01 * t4s
        let w3 = Arcs.dmsToAngle(125, 2, 40.398_16) -
            6_967_919.538_3 * t1s +
            6.359 * t2s +
            0.007_625 * t3s -
            0.000_035_86 * t4s
        let big_t = Arcs.dmsToAngle(100, 27, 59.138_85) +
            129_597_742.293 * t1s -
            0.020_2 * t2s +
            0.000_009 * t3s +
            0.000_000_15 * t4s
        let omega = Arcs.dmsToAngle(102, 56, 14.457_66) +
            1_161.243_42 * t1s +
            0.529_265 * t2s -
            0.000_118_14 * t3s +
            0.000_011_379 * t4s
        d = w1 - big_t + 180.0
        f = w1 - w3
        l = w1 - w2
        lp = big_t - omega
    }
}
