//
//  AsyncImageView.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 17/2/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import UIKit
import Nuke

@IBDesignable
class AsyncImageView: UIView {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var spinner: UIActivityIndicatorView!

    var isRound: Bool = false

    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    var url: URL? {
        didSet {
            guard let url = url else {
                image = nil
                return
            }
            
            load(from: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isRound {
            let radius = isRound ? bounds.width / 2 : 0
            imageView.layer.cornerRadius = radius
            imageView.layer.masksToBounds = true
        }
    }

    private func load(from url: URL) {
        spinner.startAnimating()
        var options = ImageLoadingOptions.shared
        options.contentModes = ImageLoadingOptions.ContentModes.init(success: .scaleToFill, failure: .scaleToFill, placeholder: .scaleToFill)
        Nuke.loadImage(with: url, options: options, into: imageView, progress: nil) { [weak self] response, _ in
            self?.imageView.image = response?.image
            self?.spinner.stopAnimating()
        }
    }
    
    func prepareForReuse() {
        imageView.image = nil
        spinner.stopAnimating()
    }
}
