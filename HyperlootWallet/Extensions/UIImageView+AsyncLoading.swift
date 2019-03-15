//
//  UIImageView+AsyncLoading.swift
//  HyperlootWallet
//
//  Copyright © 2019 Hyperloot DAO. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
    
    func prepareForReuse() {
        af_cancelImageRequest()
        self.image = nil
    }
    
    func setImage(withURL: String?, placeholderImage: UIImage? = nil, tag: Int) {
        af_cancelImageRequest()
        if let imageURLString = withURL, let imageURL = URL(string: imageURLString) {
            self.tag = tag
            af_setImage(withURL: imageURL, placeholderImage: placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false) { [weak self] (response) in
                if self?.tag == tag {
                    self?.image = response.result.value
                }
            }
        } else {
            image = placeholderImage
        }
    }
    
}
