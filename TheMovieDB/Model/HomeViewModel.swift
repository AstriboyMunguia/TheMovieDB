import SwiftUI

class HomeViewModel: ObservableObject {
    
    
    @Published var upcomingMovies: [Movies]? = []
    @Published var error: Error?
    @Published var comedyMovies: [Movies]? = []
    
    private let apiClient = APIClient()
    
    func getUpcomingMovies() {
        apiClient.getDataUpcoming() { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let upcomings):
                    self.upcomingMovies = upcomings.results
                    print("Results \(upcomings)")
                case.failure(let error):
                    print("Error \(error)")
                }
            }
            
        }
        
    }
    
    
    func getcomedy() {
        apiClient.getDataComedy() { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let comedyM):
                    self.comedyMovies = comedyM.results
                    print("Results \(comedyM)")
                case.failure(let error):
                    print("Error \(error)")
                }
            }
            
        }
        
    }
}




