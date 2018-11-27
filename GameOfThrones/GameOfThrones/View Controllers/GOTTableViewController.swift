//
//  GOTTableViewController.swift
//  GameOfThrones
//
//  Created by Jermaine Kelly on 11/20/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class GOTTableViewController: UITableViewController {
    private let seasons = Season.allSeasons
    private var searchResults: [GOTEpisode]?
    private var tableViewState: TableViewState = .showingAllEpisodes
    @IBOutlet weak var searchBar: UISearchBar!
    
    private enum TableViewState {
        case isBeingSearched
        case showingAllEpisodes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    //MARK : - Setup Utilities
    private func setupViewController() {
        setupNavigationContoller()
        setupTableView()
        setupSearchBar()
    }
    
    private func setupNavigationContoller() {
        self.title = "Game Of Throne Episodes"
    }
    
    private func setupTableView() {
        tableView.register(GOTTableViewCell.self, forCellReuseIdentifier: GOTTableViewCell.identifier)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        switch tableViewState {
        case .isBeingSearched:
            return 1
        case .showingAllEpisodes:
            return seasons.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableViewState {
        case .isBeingSearched:
            guard let searchResultsCount = searchResults?.count, searchResultsCount > 0 else {
                return "No Results found"
            }
            return "\(searchResultsCount) results found"
        case .showingAllEpisodes:
            let season = seasons[section]
            return "Season \(season.number)"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewState {
        case .isBeingSearched:
            guard let searchResults = searchResults else { return 0 }
            return searchResults.count
        case .showingAllEpisodes:
            let season = seasons[section]
            return season.episodes.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GOTTableViewCell.identifier, for: indexPath) as! GOTTableViewCell
        
        switch tableViewState {
        case .isBeingSearched:
            if let searchResults = searchResults {
                cell.episode = searchResults[indexPath.row]
            }
        case .showingAllEpisodes:
            let season = seasons[indexPath.section]
            let episode = season.episodes[indexPath.row]
            cell.episode = episode
        }
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

extension GOTTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let results = searchEpisodes(for: searchText)
    }
    
    private func searchEpisodes(for queryString: String) -> [GOTEpisode] {
        return GOTEpisode.allEpisodes.filter { $0.name.contains(queryString) }
    }
    
}
