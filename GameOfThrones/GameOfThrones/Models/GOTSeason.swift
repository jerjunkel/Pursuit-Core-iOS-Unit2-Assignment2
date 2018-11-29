//
//  GOTSeason.swift
//  GameOfThrones
//
//  Created by Jermaine Kelly on 11/20/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Season {
    let number: Int
    let episodes: [GOTEpisode]
    
    static var allSeasons: [Season] {
        let allSeasons = (1...7).map { seasonNumber -> Season in //O(1)
            let episodes = GOTEpisode.allEpisodes
                .filter { $0.season == seasonNumber } //O(n)
                .sorted { $0.number < $1.number } //O(m)
            return Season(number: seasonNumber, episodes: episodes)
        }
        
        return allSeasons
    }
}
