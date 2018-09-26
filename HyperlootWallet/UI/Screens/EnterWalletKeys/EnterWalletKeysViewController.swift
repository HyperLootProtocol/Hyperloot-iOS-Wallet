//
//  EnterWalletKeysViewController.swift
//  HyperlootWallet
//
//  Created by Valery Vaskabovich on 9/25/18.
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import UIKit

class EnterWalletKeysViewController: UIViewController {
    
    struct Input {
        let user: UserRegistrationFlow
    }
    
    var input: Input!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintTextLabel: UILabel!
    @IBOutlet weak var walletKeyTypeLabel: UILabel!
    @IBOutlet weak var walletKeyValueTextView: UITextView!
    @IBOutlet weak var actionButton: HyperlootButton!
    
    lazy var viewModel = EnterWalletKeysViewModel(user: self.input.user)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    func updateUI() {
        let presentation = viewModel.presentation
        titleLabel.text = presentation.title
        hintTextLabel.text = presentation.hintText
        walletKeyTypeLabel.text = presentation.walletKeyTypeName
        walletKeyValueTextView.isEditable = presentation.walletKey.isEditable
        walletKeyValueTextView.text = presentation.walletKey.defaultValue
        actionButton.isEnabled = presentation.actionButton.enabled
        actionButton.setTitle(presentation.actionButton.title, for: .normal)
    }
}
