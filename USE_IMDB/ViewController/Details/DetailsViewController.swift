//
//  DetailsViewController.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: UI Components
    
    lazy var detailsView: DetailsView = {
        let view = DetailsView.instanceFromNib(mediaViewModel: self.mediaViewModel)
        return view
    }()
    
    // MARK: Properties
    
    var mediaViewModel: MediaViewModel
    
    // MARK: Life Cycle
    
    override func loadView() {
        self.view = self.detailsView
    }
    
    init(mediaViewModel: MediaViewModel) {
        self.mediaViewModel = mediaViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("aDecoder init not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.getMediaDetails()
    }
    
    // MARK: Methods
    
    public func getMediaDetails() {
        guard let objectId = self.mediaViewModel.objectId, !objectId.isEmpty else {
            self.showAlertCommon(message: "DETAILS_MEDIA_WITHOUT_IDENTIFIER_ERROR_MESSAGE".localized) { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.popViewController(animated: true)
            }
            return
        }
        self.playProgress()
        API.getMediaDetails(mediaId: objectId, success: { [weak self] (mediaDetailsModel) in
            guard let strongSelf = self else { return }
            strongSelf.detailsView.mediaDetailsModel = mediaDetailsModel
        }) { [weak self] (code, message) in
            guard let strongSelf = self else { return }
            strongSelf.showAlertCommon(message: message) { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func playProgress() {
        self.detailsView.playProgress()
    }
    
    public func stopProgress() {
        self.detailsView.stopProgress()
    }

}
