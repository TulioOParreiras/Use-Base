//
//  SearchView.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

// MARK: Protocols

protocol SearchViewDelegate: class {
    func searchView(_ searchView: SearchView, didSelect viewModel: MediaViewModel)
}

class SearchView: UIView {
    
    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewInstructions: UIView!
    @IBOutlet weak var lblInstructions: UILabel!
    
    // MARK: Properties
    
    private var viewModel: [MediaViewModel] = [] {
        didSet {
            self.viewInstructions.isHidden = true
            self.tableView.reloadData()
        }
    }
    private let kCellId = "SearchCell"
    private var selectedIndexPath: IndexPath?
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: Life Cycle
    
    class func instanceFromNib() -> SearchView{
        let view = UINib(nibName: "SearchView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SearchView
        view.setup()
        return view
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil, let indexPath = self.selectedIndexPath {
            (self.tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(false)
        }
    }
    
    // MARK: Methods
    
    private func setup() {
        self.backgroundColor = .white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.kCellId)
        self.tableView.register(UINib(nibName: self.kCellId, bundle: nil), forCellReuseIdentifier: self.kCellId)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.keyboardDismissMode = .interactive
        
        self.lblInstructions.text = "SEARCH_INSTRUCTIONS_TEXT".localized
    }

    public func updateViewModel(_ viewModel: [MediaViewModel]) {
        self.viewModel = viewModel
    }
    
}

// MARK: Extensions

extension SearchView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        guard self.viewModel.count > row else { return }
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(true)
        self.selectedIndexPath = indexPath
        self.delegate?.searchView(self, didSelect: self.viewModel[row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(false)
    }
    
}

extension SearchView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellId, for: indexPath) as! SearchCell
        cell.viewModel = self.viewModel[indexPath.row]
        return cell
    }
    
}
