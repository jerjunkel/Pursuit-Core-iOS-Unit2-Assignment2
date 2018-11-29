//
//  GOTTableViewCell.swift
//  GameOfThrones
//
//  Created by Jermaine Kelly on 11/21/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class GOTTableViewCell: UITableViewCell {
    static let identifier = "GOTCellID"
    private let padding: CGFloat = 10
    var episode: GOTEpisode! {
        didSet {
            updateCellUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cell UI Utilities
    private func updateCellUI() {
        setImage(named: episode.mediumImageID)
        setLabels(title: episode.name, description: "Episode: \(episode.number)")
    }
    
    private func setLabels(title: String, description: String) {
        cellTitleLabel.text = title
        cellDescriptionLabel.text = description
    }
    
    private func setImage(named imageString: String) {
        DispatchQueue.main.async {
            self.cellImageView.image = UIImage(named: imageString)
        }
    }
    
    //MARK: - Setup Utilities
    private func setupCell() {
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        addSubview(cellImageView)
        addSubview(cellTitleLabel)
        addSubview(cellDescriptionLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cellTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cellTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellTitleLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            cellDescriptionLabel.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor, constant: padding * 2),
            cellDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellDescriptionLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            cellImageView.widthAnchor.constraint(equalToConstant: 100),
            cellImageView.heightAnchor.constraint(equalToConstant: 100),
            cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cellImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            cellImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
            ])
    }
    
    //MARK: - Properties
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
}
