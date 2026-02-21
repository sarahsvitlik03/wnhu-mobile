import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var user = UserModel (
        firstName: "Sarah",
        lastName: "Svitlik",
        email: "s@unh.newhaven.edu",
    )
    
    @Published var songs: [LikedSongModel] = [
        LikedSongModel(songName: "Heavy", artistName: "The Marias"),
        LikedSongModel(songName: "No One Noticed", artistName: "The Marias"),
        LikedSongModel(songName: "Some Kind of Angel", artistName: "Georgia Gets By"),
        LikedSongModel(songName: "Older", artistName: "Searows"),
        LikedSongModel(songName: "Bluebird", artistName: "Lana Del Rey")
    ]
}

/* Update UserData to be pulled from the database*/
