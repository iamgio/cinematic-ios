import Foundation

/// The base API URL.
let apiBaseUrl = "http://www.omdbapi.com/?apikey=44ade1ff"

private func getEndpointURL(endpoint: String) -> URL {
    URL(string: "\(apiBaseUrl)/\(endpoint)")!
}

/// Sends an HTTP request.
/// - Parameters:
///     - endpoint: Name of the endpoint to send the request to.
///     - method: HTTP method
///     - body: Optional HTTP body data to send as JSON.
///     - user: If present, sets the authorization token.
/// - Returns: The response data.
private func sendRequest(
    endpoint: String,
    method: String,
    body: Encodable?
) async throws -> Data {
    let url = getEndpointURL(endpoint: endpoint)
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let data = body {
        let encoder = JSONEncoder()
        request.httpBody = try! encoder.encode(data)
        
#if DEBUG
        print("\nREQUEST")
        print(String(decoding: request.httpBody!, as: UTF8.self))
#endif
    }
    
    let (responseData, _) = try await URLSession.shared.data(for: request)
    
#if DEBUG
    print("\nRESPONSE")
    print(String(decoding: responseData, as: UTF8.self))
#endif
    
    return responseData
}

/// Sends an HTTP request and decodes its response.
/// - Parameters:
///     - endpoint: Name of the endpoint to send the request to.
///     - method: HTTP method
///     - body: Optional HTTP body data to send as JSON.
/// - Returns: The decoded object from the response data.
private func sendRequest<T : Decodable>(
    endpoint: String,
    method: String,
    body: Encodable?
) async throws -> T {
    let data = try await sendRequest(endpoint: endpoint, method: method, body: body)
    
    let decoder = JSONDecoder()
    
    return try decoder.decode(T.self, from: data)
}

/// Sends a get request and decodes its response.
/// - Parameters:
///     - endpoint: Name of the endpoint to send the request to.
/// - Returns: The decoded object from the response data.
func sendGetRequest<T : Decodable>(
    endpoint: String
) async throws -> T {
    return try await sendRequest(endpoint: endpoint, method: "GET", body: nil)
}

/// Sends a post request.
/// - Parameters:
///     - endpoint: Name of the endpoint to send the request to.
///     - data: Optional data to send as JSON.
func sendPostRequest(
    endpoint: String,
    data: Encodable? = nil
) async throws {
    let _ = try await sendRequest(endpoint: endpoint, method: "POST", body: data)
}

/// Sends a post request and decodes its response.
/// - Parameters:
///     - endpoint: Name of the endpoint to send the request to.
///     - data: Optional data to send as JSON.
/// - Returns: The decoded object from the response data.
func sendPostRequest<T : Decodable>(
    endpoint: String,
    data: Encodable? = nil
) async throws -> T {
    return try await sendRequest(endpoint: endpoint, method: "POST", body: data)
}

/// - Parameters:
///     - date: Date to stringify.
/// - Returns: The date in an API-ready string format.
func stringifyDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: date)
}
