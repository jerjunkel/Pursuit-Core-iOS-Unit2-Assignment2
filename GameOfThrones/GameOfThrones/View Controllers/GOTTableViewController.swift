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
    private var tableViewState: TableViewState = .showingAllEpisodes {
        didSet {
            reloadTableview()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    private enum TableViewState {
        case isBeingSearched
        case showingAllEpisodes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    //MARK: - Setup Utilities
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
    
    private func reloadTableview() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func makeSectionHeader(title: String) -> UIView {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = .red
            
            let titleLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = title
                label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
                label.textColor = .white
                return label
            }()
            
            view.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
            
            return view
        }()
        
        return view
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var title = ""
        switch tableViewState {
        case .isBeingSearched:
            if let searchResultsCount = searchResults?.count, searchResultsCount > 0  {
                title =  "\(searchResultsCount) results found"
            } else {
                title = "No Results found"
            }
        case .showingAllEpisodes:
            let season = seasons[section]
            title =  "Season \(season.number)"
        }
        return makeSectionHeader(title: title)
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
        let episodeVVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "episodeVC") as! EpisodeViewController
        
        switch tableViewState {
        case .isBeingSearched:
            if let searchResults = searchResults {
                let episode = searchResults[indexPath.row]
                episodeVVC.episode = episode
            }
        case .showingAllEpisodes:
            let episode = seasons[indexPath.section].episodes[indexPath.row]
            episodeVVC.episode = episode
        }
        //let episodeVC = EpisodeViewController(episode: episode)
        
        navigationController?.pushViewController(episodeVVC, animated: true)
    }
}
//MARK: - Search bar delegate methods
extension GOTTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty {
            tableViewState = .showingAllEpisodes
            searchResults = nil
        } else {
            tableViewState = .isBeingSearched
            let results = searchEpisodes(for: searchText.lowercased())
            searchResults = results
        }
    }
    
    private func searchEpisodes(for queryString: String) -> [GOTEpisode] {
        return GOTEpisode.allEpisodes.filter { $0.name.lowercased().contains(queryString) }
    }
}
