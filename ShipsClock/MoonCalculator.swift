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
    let epoch = 2451545.0 // calcs use base 2000-01-01 00:00 UT
    
    let delaunay: Delaunay
    let time: Double
    
    init(julianDay jd: Double) {
        time = jd - epoch
        delaunay = Delaunay(julianDay2000: time)
    }
    
    func longitude() -> Double {
        return Arcs.normalizedDegrees(
            for: MainTerms.mainLon.reduce(
                0.0,
                { lon, term in
                    return lon + term.value(delaunay)
                }
            )
            + delaunay.w1
        )
    }
}
