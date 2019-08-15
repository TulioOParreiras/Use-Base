//
//  DetailsView.swift
//  USE_IMDB
//
//  Created by Usemobile on 15/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

import SkeletonView

class DetailsView: UIView {
    
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
    
    // MARK: Properties
    
    private var mediaViewModel: MediaViewModel?
    public var mediaDetailsModel: MediaDetailsModel? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setupMediaDetailsModel()
            }
        }
    }
    
    // MARK: Life Cycle
    
    class func instanceFromNib(mediaViewModel: MediaViewModel) -> DetailsView{
        let view = UINib(nibName: "DetailsView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! DetailsView
        view.mediaViewModel = mediaViewModel
        view.setup()
        return view
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyBottomBorder(to: self.headerView)
        self.applyBottomBorder(to: self.viewPlot)
        self.applyBottomBorder(to: self.viewCast)
        self.applyBottomBorder(to: self.viewDirectors)
        self.applyBottomBorder(to: self.viewWriters)
    }
    
    // MARK: Methods
    
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
        self.backgroundColor = .white
        self.imvStar.image = UIImage(named: "star-yellow")
        self.setTitles()
        self.setupMediaViewModel()
    }
    
    private func setTitles() {
        self.lblCastTitle.text = "CAST_TEXT".localized
        self.lblDirectorsTitle.text = "DIRECTORS_TEXT".localized
        self.lblWritersTitle.text = "WRITERS_TEXT".localized
        
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    private func setupMediaViewModel() {
        self.lblTitle.text = self.mediaViewModel?.title
        self.lblYear.text = self.mediaViewModel?.year
        self.imvPoster.cast(urlStr: self.mediaViewModel?.posterLink, placeholder: UIImage(named: "placeholder"))
        
        self.layoutIfNeeded()
    }
    
    private func setupMediaDetailsModel() {
        self.stopProgress()
        
        self.lblTitle.text = self.mediaDetailsModel?.title
        self.lblYear.text = self.mediaDetailsModel?.year
        self.lblDuration.text = self.mediaDetailsModel?.runtime
        self.lblGenre.text = self.mediaDetailsModel?.genre
        self.lblRate.text = self.mediaDetailsModel?.imdbRating
        
        self.imvPoster.cast(urlStr: self.mediaDetailsModel?.poster, placeholder: UIImage(named: "placeholder"))
        self.lblPlot.text = self.mediaDetailsModel?.plot
        
        self.lblCast.text = self.mediaDetailsModel?.actors
        self.lblDirectors.text = self.mediaDetailsModel?.director
        self.lblWriters.text = self.mediaDetailsModel?.writer
        
        self.layoutIfNeeded()
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
}
