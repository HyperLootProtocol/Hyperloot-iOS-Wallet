//
//  RegistrationErrorView.swift
//  HyperlootWallet
//
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import UIKit

class RegistrationErrorView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    public var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
    }
    
    public func setVisible(_ value: Bool, animated: Bool) {
        let shouldBeHidden = !value
        guard shouldBeHidden != self.isHidden else {
            return
        }
        
        struct Alpha {
            let initial: CGFloat
            let final: CGFloat
        }
        
        let alpha = Alpha(initial: (value) ? 0.0 : 1.0, final: (value) ? 1.0 : 0.0)
        
        if animated == false {
            self.isHidden = !value
            self.alpha = alpha.final
        } else {
            self.alpha = alpha.initial
            self.isHidden = false
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.alpha = alpha.final
            }) { [weak self] (_) in
                self?.isHidden = !value
            }
        }
    }
}
