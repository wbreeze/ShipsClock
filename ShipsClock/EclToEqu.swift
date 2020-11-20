//
  // ShipsClock
  // Created by Douglas Lovell on 11/18/20.
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
 Convert ecliptic coordinates to equatorial
*/
struct EclToEqu {
    // obliquity of the ecliptic in radians
    static let obl = 23.439 * Double.pi / 180.0
    static let cos_e = cos(obl)
    static let sin_e = sin(obl)

    /*
     Convert cartesion coordinates to spherical coordinates
     in the same reference frame.
     
     Outputs
     radius: in the same units as x, y, z
     azimuth, inclinition: in degrees
     */
    static func spherical(x:Double, y:Double, z:Double) ->
    (radius:Double, azimuth:Double, inclination:Double) {
        let r2d = 180.0 / Double.pi
        let r = sqrt(x * x + y * y + z * z)
        let a = atan2(y,x) * r2d
        let l = acos(z/r) * r2d
        return(radius: r, azimuth: a, inclination: l)
    }
    
    /*
     Convert z-axis based inclination (zero up) to equatorial
     based latitude (90 up, zero at the equator, -90 down)
     where up is through the north pole, down through the south pole
     */
    static func inclinationToLatitude(_ incl: Double) -> (Double) {
        Arcs.longitudeGiven(degrees: -incl + 90.0)
    }
    
    /*
     Convert ecliptic coordinates to equatorial
     
     Inputs ecliptic
     Ecliptic coordinates are the right hand system with the z
     axis aligned on the pole, increasing toward north.
     The x axis is aligned with the first star in aries
     Input them as spherical coordinates with
     azimuth referenced to
     the first star in aries (increasing E, decreasing W)
     and inclination referenced to
     the north pole (increasing from N = 0.0 to S = 180.0).
     azimuth, aka longitude, in degrees, -180.0 < degrees <= 180.0
     inclination, aka latitude, in degrees, -90.0 <= degrees <= 90.0
     
     Outputs equatorial
     declination in degrees, -90.0 <= degrees <= 90.0
     right ascension in degrees, -180.0 <= degrees <= 180.0
     */
    static func eclipticToEquatorial(
        longitude az: Double, latitude incl: Double) ->
    (declination: Double, rightAscension: Double) {
        let lon = Arcs.radiansGiven(degrees: az)
        let lat = Arcs.radiansGiven(degrees: incl)
        let decl = asin(cos_e * sin(lat) + sin_e * cos(lat) * sin(lon))
        let ra = atan2(cos_e * sin(lon) - sin_e * tan(lat), cos(lon))
        return(
            declination: Arcs.longitudeGiven(radians: decl),
            rightAscension: Arcs.degreesGiven(radians: ra)
        )
    }
}
