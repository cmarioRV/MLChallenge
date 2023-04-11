//
//  SearchTableViewCell.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell, CellConfigurable {
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.textColor = .black
        return lbl
    }()
    
    let iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var uniqueId: Int? = nil
    private let imageDownloader = ImageDownloader()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? ViewModel else { return }
        let uniqueValue = Int.random(in: 0...Int.max)
        uniqueId = uniqueValue
        
        titleLabel.text = viewModel.title
        iconImageView.image = nil
        
        if let imageUrl = viewModel.image {
            imageDownloader.downloadImage(url: imageUrl) { [weak self] image, _ in
                if self?.uniqueId != uniqueValue { return }
                self?.iconImageView.image = image
            }
        }
    }
    
    private func configureContents() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        let guides = contentView.safeAreaLayoutGuide
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: guides.leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: guides.topAnchor, constant: 5),
            iconImageView.bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: -5),
            iconImageView.widthAnchor.constraint(equalTo: guides.widthAnchor, multiplier: 0.25),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: guides.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor)
        ])
        
        contentView.layoutIfNeeded()
    }
}

extension SearchTableViewCell {
    struct ViewModel: CellViewModel {
        let image: URL?
        let title: String
    }
}
