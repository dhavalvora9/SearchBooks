//
//  ViewController.swift
//  SearchBooks
//
//  Created by Dhaval on 12/03/22.
//

import UIKit

class SearchBookViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    lazy var viewModel = {
        BookViewModel()
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    // MARK: - Initialization
    
    func initView() {
        // TableView customization
        booksTableView.dataSource = self
        booksTableView.delegate = self
        booksTableView.separatorColor = .white
        booksTableView.separatorStyle = .singleLine
        booksTableView.tableFooterView = UIView()
        booksTableView.allowsSelection = false
        booksTableView.keyboardDismissMode = .onDrag
        
        // Register cell
        booksTableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.identifier)
        
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - IBActions
    
    @IBAction func searchAction(_ sender: UIButton) {
        // Get books data
        if let searchText = searchField.text {
            // Display activity indicator
            searchIndicator.startAnimating()
            
            // Hide search button to avoid multiple request
            searchButton.isHidden = true
            
            // Fetch data using webservice
            viewModel.searchBooks(for: searchText) { [weak self] success, results, error in
                // Handle error
            }
            
            // Reload TableView closure
            viewModel.reloadTableView = { [weak self] in
                DispatchQueue.main.async {
                    self?.searchIndicator.stopAnimating()
                    self?.searchButton.isHidden = false
                    self?.booksTableView.reloadData()
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let searchText = textField.text {
            searchButton.isEnabled = !searchText.isEmpty
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - UITableViewDataSource

extension SearchBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookCell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as? BookCell else {
            fatalError("xib does not exists")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        bookCell.cellViewModel = cellVM
        return bookCell
    }
}
