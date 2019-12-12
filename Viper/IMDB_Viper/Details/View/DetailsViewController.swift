//
//  DetailsViewController.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

import SkeletonView

class DetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var imvStar: UIImageView!
    @IBOutlet weak var lblRate: UILabel!
    
    @IBOutlet weak var viewPlot: UIView!
    @IBOutlet weak var imvPoster: UIImageView!
    @IBOutlet weak var lblPlot: UILabel!
    
    @IBOutlet weak var viewCast: UIView!
    @IBOutlet weak var lblCastTitle: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    
    @IBOutlet weak var viewDirectors: UIView!
    @IBOutlet weak var lblDirectorsTitle: UILabel!
    @IBOutlet weak var lblDirectors: UILabel!
    
    @IBOutlet weak var viewWriters: UIView!
    @IBOutlet weak var lblWritersTitle: UILabel!
    @IBOutlet weak var lblWriters: UILabel!
    
    var presenter: DetailsViewToPresenterProtocol?
    var media: MediaEntity?
    var mediaDetails: MediaDetailsModel? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.setupMediaDetails()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.setupMedia()
        self.getMediaDetails()
    }
    
    // MARK: Methods
    
    public func getMediaDetails() {
        guard let media = self.media else { return }
        self.playProgress()
        self.presenter?.getDetails(for: media)
    }
    
    private func applyBottomBorder(to view: UIView, borderHeight: CGFloat = 1.0) {
        let borderName = "BorderLayer"
        view.layer.sublayers?.filter({ $0.name == borderName }).forEach({ $0.removeFromSuperlayer() })
        
        let borderLayer = CAShapeLayer()
        borderLayer.name = borderName
        
        let viewBounds = view.bounds
        let viewWidth = viewBounds.width
        let viewHeight = viewBounds.height
        
        borderLayer.path = UIBezierPath(rect: CGRect(x: 0, y: viewHeight - borderHeight, width: viewWidth, height: borderHeight)).cgPath
        borderLayer.fillColor = UIColor.lightGray.cgColor
        
        view.layer.addSublayer(borderLayer)
    }
    
    private func setup() {
        self.imvStar.image = UIImage(named: "star-yellow")
        self.setTitles()
        self.setupMedia()
    }
    
    private func setTitles() {
        self.lblCastTitle.text = "CAST_TEXT".localized
        self.lblDirectorsTitle.text = "DIRECTORS_TEXT".localized
        self.lblWritersTitle.text = "WRITERS_TEXT".localized
        
        self.view.layoutIfNeeded()
        self.applyBorders()
    }
    
    private func setupMedia() {
        self.lblTitle.text = self.media?.title
        self.lblYear.text = self.media?.year
        self.imvPoster.cast(urlStr: self.media?.poster, placeholder: UIImage(named: "placeholder"))
        
        self.view.layoutIfNeeded()
        self.applyBorders()
    }
    
    fileprivate func applyBorders() {
        self.applyBottomBorder(to: self.headerView)
        self.applyBottomBorder(to: self.viewPlot)
        self.applyBottomBorder(to: self.viewCast)
        self.applyBottomBorder(to: self.viewDirectors)
        self.applyBottomBorder(to: self.viewWriters)
    }
    
    private func setupMediaDetails() {
        self.stopProgress()
        
        self.lblTitle.text = self.mediaDetails?.title
        self.lblYear.text = self.mediaDetails?.year
        self.lblDuration.text = self.mediaDetails?.runtime
        self.lblGenre.text = self.mediaDetails?.genre
        self.lblRate.text = self.mediaDetails?.imdbRating
        
        self.imvPoster.cast(urlStr: self.mediaDetails?.poster, placeholder: UIImage(named: "placeholder"))
        self.lblPlot.text = self.mediaDetails?.plot
        
        self.lblCast.text = self.mediaDetails?.actors
        self.lblDirectors.text = self.mediaDetails?.director
        self.lblWriters.text = self.mediaDetails?.writer
        
        self.view.layoutIfNeeded()
        self.applyBorders()
    }
    
    public func playProgress() {
        if self.lblTitle.text == nil {
            self.lblTitle.showAnimatedGradientSkeleton()
        }
        if self.lblYear.text == nil {
            self.lblYear.showAnimatedGradientSkeleton()
        }
        if self.imvPoster.image == nil {
            self.imvPoster.showAnimatedGradientSkeleton()
        }
        
        self.lblDuration.showAnimatedGradientSkeleton()
        self.lblGenre.showAnimatedGradientSkeleton()
        self.lblRate.showAnimatedGradientSkeleton()
        
        self.lblPlot.showAnimatedGradientSkeleton()
        
        self.lblCast.showAnimatedGradientSkeleton()
        self.lblDirectors.showAnimatedGradientSkeleton()
        self.lblWriters.showAnimatedGradientSkeleton()
    }
    
    public func stopProgress() {
        self.lblTitle.hideSkeleton()
        self.lblYear.hideSkeleton()
        
        self.lblDuration.hideSkeleton()
        self.lblGenre.hideSkeleton()
        self.lblRate.hideSkeleton()
        
        self.imvPoster.hideSkeleton()
        self.lblPlot.hideSkeleton()
        
        self.lblCast.hideSkeleton()
        self.lblDirectors.hideSkeleton()
        self.lblWriters.hideSkeleton()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: DetailsPresenterToViewProtocol {
    
    func showDetails(details: MediaDetailsModel) {
        self.mediaDetails = details
    }
    
    func showError(errorMessage: String) {
        self.showAlertCommon(message: errorMessage)
    }
    
}
