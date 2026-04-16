import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var user = UserModel (
        firstName: "",
        lastName: "",
        email: "",
    )
    
    @Published var songs: [LikedSongModel] = []
    
    func fetchLikedSongs() {
        guard !user.email.isEmpty else { return }
        
        guard let url = URL(string: "http://localhost:8000/pullLikedSongs") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": user.email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching liked songs: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Parse JSON as a dictionary and extract the songs array
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard let json = jsonObject as? [String: Any] else {
                    print("Error: Root JSON is not a dictionary")
                    return
                }
                guard let songsArray = json["songs"] as? [[String: Any]] else {
                    print("Error: 'songs' key missing or not an array of dictionaries")
                    return
                }

                // Map explicitly-typed dictionaries to models to aid type inference
                let likedSongs: [LikedSongModel] = songsArray.compactMap { (songDict: [String: Any]) -> LikedSongModel? in
                    guard let title = songDict["title"] as? String,
                          let artist = songDict["artist"] as? String else {
                        return nil
                    }
                    return LikedSongModel(songName: title, artistName: artist)
                }

                DispatchQueue.main.async {
                    self.songs = likedSongs
                }
            } catch {
                print("Error parsing liked songs: \(error.localizedDescription)")
            }
        }.resume()
    }
}

/* Update UserData to be pulled from the database*/
// Need to write a route for like and disliked songs 

