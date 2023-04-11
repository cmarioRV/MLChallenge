//
//  SearchViewController.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Domain
import UIKit

class SearchViewController: UIViewController {
    var viewModel: SearchViewModelType!
    var onShowDetail: ((ItemDetail) -> Void)?
    
    var searchBar: UISearchBar = {
       let _searchBar = UISearchBar()
        return _searchBar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.cellIdentifier())
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        bindViewModel()
    }
    
    private func setViews() {
        searchBar.delegate = self
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self

        let guides = self.view.safeAreaLayoutGuide
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: guides.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: guides.trailingAnchor)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: guides.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guides.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guides.bottomAnchor)
        ])
        
        definesPresentationContext = true
        view.layoutIfNeeded()
    }
    
    private func bindViewModel() {
        viewModel.outputs.cellViewModels.bind { [weak self] viewModels in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.outputs.isBussy.bind { [weak self] isBussy in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isBussy {
                    self.showSpinner()
                } else {
                    self.hideSpinner()
                }
            }
        }
        
        viewModel.outputs.itemDetail.bind { [weak self] item in
            guard let self = self,
            let item = item else { return }
            DispatchQueue.main.async {
                self.onShowDetail?(item)
            }
        }
        
        viewModel.outputs.error.bind { _ in }
    }
    
    private func cellIdentifier(for viewModel: CellViewModel) -> String {
        switch viewModel {
        case is SearchTableViewCell.ViewModel:
            return SearchTableViewCell.cellIdentifier()
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = viewModel.outputs.cellViewModels.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(for: rowViewModel), for: indexPath)

        if let cell = cell as? CellConfigurable {
            cell.configure(viewModel: rowViewModel)
        }

        cell.selectionStyle = .none
        cell.layoutIfNeeded()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.getItem(at: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 3 { return }
        viewModel.inputs.search(query: searchText)
    }
}
