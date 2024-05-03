import Foundation
import CoreLocation

struct GeoUtils {
    /// Gets coordinates from a generic
    func getCoordinate(address: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
