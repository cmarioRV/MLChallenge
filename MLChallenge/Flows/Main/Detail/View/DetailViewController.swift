//
//  DetailViewController.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import UIKit
import Domain

class DetailViewController: UIViewController {
    var viewModel: DetailViewModelType!
    
    let scrollView: UIScrollView = {
       let _scrollView = UIScrollView()
        return _scrollView
    }()
    
    let containerView: UIView = {
       let _view = UIView()
        return _view
    }()
    
    let imageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()

    let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    let priceTitleLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lbl.setContentCompressionResistancePriority(.required, for: .horizontal)
        return lbl
    }()
    
    let priceLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        lbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lbl
    }()
    
    let conditionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    let conditionTitleLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lbl.setContentCompressionResistancePriority(.required, for: .horizontal)
        return lbl
    }()
    
    let conditionLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        lbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lbl
    }()
    
    let reputationTitleLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        return lbl
    }()
    
    public var item: ItemDetail!
    private let imageDownloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        bindViewModel()
    }
    
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        let guides = self.view.safeAreaLayoutGuide
        
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceStackView)
        priceStackView.addArrangedSubview(priceTitleLabel)
        priceStackView.addArrangedSubview(priceLabel)
        containerView.addSubview(conditionStackView)
        conditionStackView.addArrangedSubview(conditionTitleLabel)
        conditionStackView.addArrangedSubview(conditionLabel)
        containerView.addSubview(reputationTitleLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        conditionStackView.translatesAutoresizingMaskIntoConstraints = false
        reputationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guides.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guides.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: guides.widthAnchor)
        ])
        
        containerView.heightAnchor.constraint(equalTo: guides.heightAnchor).priority = .defaultLow
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            priceStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            priceStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            conditionStackView.topAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: 12),
            conditionStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            conditionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            reputationTitleLabel.topAnchor.constraint(equalTo: conditionStackView.bottomAnchor, constant: 12),
            reputationTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            reputationTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            reputationTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        titleLabel.text = item.title
        priceTitleLabel.text = "Precio: "
        priceLabel.text = "\(item.price)"
        conditionTitleLabel.text = "Condición: "
        conditionLabel.text = item.condition
        
        if let imageUrl = item.imageUrl {
            imageDownloader.downloadImage(url: imageUrl) { [weak self] image, _ in
                self?.imageView.image = image
            }
        }
    }
    
    private func bindViewModel() {
    }
}
