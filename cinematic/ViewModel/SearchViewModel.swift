import Foundation

@Observable class SearchViewModel {
    var query: String = ""
    
    var results: [Movie] = []
    
    func perform() async {
        
    }
}
