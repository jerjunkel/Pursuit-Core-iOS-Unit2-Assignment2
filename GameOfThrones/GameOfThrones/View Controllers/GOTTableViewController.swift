//
//  GOTTableViewController.swift
//  GameOfThrones
//
//  Created by Jermaine Kelly on 11/20/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class GOTTableViewController: UITableViewController {
    let seasons = Season.allSeasons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    //MARK : - Setup Utilities
    private func setupViewController() {
        setupNavigationContoller()
        setupTableView()
    }
    
    private func setupNavigationContoller() {
        self.title = "Game Of Throne Episodes"
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let season = seasons[section]
        return "Episode \(season.number)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let season = seasons[section]
        return season.episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let season = seasons[indexPath.section]
        let episode = season.episodes[indexPath.row]
        
        cell.textLabel?.text = episode.name
        cell.detailTextLabel?.text = episode.summary
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = seasons[indexPath.section].episodes[indexPath.row]
        //let episodeVC = EpisodeViewController(episode: episode)
        let episodeVVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "episodeVC") as! EpisodeViewController
        episodeVVC.episode = episode
        navigationController?.pushViewController(episodeVVC, animated: true)
    }
}