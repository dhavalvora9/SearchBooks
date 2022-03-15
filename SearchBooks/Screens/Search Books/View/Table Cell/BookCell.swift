//
//  BookCell.swift
//  SearchBooks
//
//  Created by Dhaval on 12/03/22.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: BookCellViewModel? {
        didSet {
            initView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    
    func setupUI() {
        self.coverImage.layer.cornerRadius = 4
    }
    
    func initView() {
        self.titleLabel.text = cellViewModel?.title
        
        // Authoer name
        if let authorName = cellViewModel?.authorName {
            self.authorLabel.text = authorName.joined(separator: " & ")
        } else {
            self.authorLabel.text = "Unknown"
        }
        
        // Publish year
        if let publishYear = cellViewModel?.firstPublishYear {
            self.yearLabel.text = String(publishYear)
        } else {
            self.yearLabel.text = "Unknown"
        }
        
        // Check if cover is available
        if let _ = cellViewModel?.coverID,
           let editionKey = cellViewModel?.editionKey?.first {
            
            // Cover loading indicator & transition
            self.coverImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.coverImage.sd_imageIndicator?.startAnimatingIndicator()
            self.coverImage.sd_imageTransition = .fade
            
            let imagePath = Constant.imageAPI + editionKey + ".jpg"
            let imageURL = URL(string: imagePath)
            self.coverImage.sd_setImage(with: imageURL)
        } else {
            self.coverImage.image = UIImage(named: "cover_placeholder")
        }
    }
}
