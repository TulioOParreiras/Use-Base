//
//  SearchCell.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    // MARK: IBOutlets

    @IBOutlet weak var imvPoster: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYearTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblTypeTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    // MARK: Properties
    
    var viewModel: MediaViewModel? {
        didSet {
            self.fillViewModel()
        }
    }
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.imvPoster.contentMode = .scaleAspectFill
        self.lblYearTitle.text = "YEAR_TEXT".localized
        self.lblTypeTitle.text = "TYPE_TEXT".localized
    }
    
    // MARK: Methods
    
    private func fillViewModel() {
        self.lblTitle.text = self.viewModel?.title
        self.lblYear.text = self.viewModel?.year
        self.lblType.text = self.viewModel?.type
        
        self.imvPoster.cast(urlStr: self.viewModel?.posterLink, placeholder: UIImage(named: "placeholder"))
    }
    
    public func setContentSelected(_ selected: Bool) {
        self.contentView.backgroundColor    = selected ? .lightGray : .clear
        self.lblTitle.textColor             = selected ? .white : .black
        self.lblYearTitle.textColor         = selected ? .white : .black
        self.lblYear.textColor              = selected ? .white : .black
        self.lblTypeTitle.textColor         = selected ? .white : .black
        self.lblType.textColor              = selected ? .white : .black
    }
    
}
