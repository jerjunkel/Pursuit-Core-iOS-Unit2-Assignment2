//
//  EpisodeViewController.swift
//  GameOfThrones
//
//  Created by Jermaine Kelly on 11/20/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    var episode: GOTEpisode!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIElements()
    }
    
    //    init(episode: GOTEpisode) {
    //        self.episode = episode
    //        super.init(nibName: nil, bundle: nil)
    //        updateUIElements()
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    private func setupVC() {
        view.backgroundColor = .white
    }
    
    private func updateUIElements() {
        setTextLabels()
        setImage()
    }
    
    private func setImage() {
        DispatchQueue.main.async {
            self.episodeImageView.image = UIImage(named: self.episode.originalImageID)
        }
    }
    
    private func setTextLabels() {
        title = episode.name
        titleLabel.text = episode.name
        descriptionTextView.text = episode.summary
        seasonLabel.text = "Season: \(episode.season) || Episode: \(episode.number) || Runtime: \(episode.runtime)"
    }
}
