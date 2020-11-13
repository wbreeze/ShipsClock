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
    
    // W1, W2 and W3 are angles of the inertial mean ecliptic
    /**
     W1, W2 and W3 are angles of the inertial mean ecliptic of date referred to the departure point γ′2000.
     T and omega_bar_prime are angles of the inertial mean ecliptic of J2000 referred to the inertial mean equinox γ'2000 of J2000.
     The secular developments of these arguments are polynomial functions of time under the general formulation:
     $ a = a^{(0)} + a^{(1)} t + a^{(2)} t^2 + a^{(3)} t^3 + a^{(4)} t^4 $
     The mean motions of the Moon and the Sun (coefficient of t in W1 and T ) are also denoted as v and n'
     ν = W1; n' =T
     */
    init(julianDay2000 t: Double) {
        let tc = t / 36525.0 // express t in centuries (365.25 days / year * 100.0 year / century)
        let t1s = tc
        let t2s = tc * tc
        let t3s = t2s * tc
        let t4s = t2s * t2s
        let rad = 648_000.0 / Double.pi
        let deg = Double.pi / 180.0
        // w1: the mean longitude of the Moon
        w1 = Arcs.dmsToAngle(218, 18, 59.955_71) * deg
            + 1_732_559_343.736_04 / rad * t1s
            - 6.808_4 / rad * t2s
            + 0.6604e-02 / rad * t3s
            - 0.3169e-04 / rad * t4s
        // w2: the mean longitude of the lunar perigee
        let w2 = Arcs.dmsToAngle(83, 21, 11.674_75) * deg
            + 14_643_420.317_1 / rad * t1s
            - 38.263_1 / rad * t2s
            - 0.45047e-01 / rad * t3s
            + 0.21301e-03 / rad * t4s
        // w3: the mean longitude of the lunar ascending node
        let w3 = Arcs.dmsToAngle(125, 2, 40.398_16) * deg
            - 6_967_919.538_3 / rad * t1s
            + 6.359 / rad * t2s
            + 0.7625e-02 / rad * t3s
            - 0.3586e-04 / rad * t4s
        // eart: the heliocentric mean longitude of the Earth-Moon barycenter
        let eart = Arcs.dmsToAngle(100, 27, 59.138_85) * deg
            + 129_597_742.293 / rad * t1s
            - 0.0202 / rad * t2s
            + 0.9e-05 / rad * t3s
            + 0.15e-06 / rad * t4s
        // peri: the mean longitude of the perihelion of the Earth-Moon barycenter
        let peri = Arcs.dmsToAngle(102, 56, 14.457_66) * deg
            + 1_161.243_42 / rad * t1s
            + 0.529_265 / rad * t2s
            - 0.11814e-03 / rad * t3s
            + 0.11379e-04 / rad * t4s
        
        d = w1 - eart + Double.pi
        f = w1 - w3
        l = w1 - w2
        lp = eart - peri
    }
}
