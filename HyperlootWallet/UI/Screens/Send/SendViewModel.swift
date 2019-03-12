//
//  SendViewModel.swift
//  HyperlootWallet
//
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import Foundation

class SendViewModel {
    
    struct Presentation {
        enum TokenPresentationType {
            case regularToken(presentation: SendTokenDetailsPresentation)
            case tokenItem(presentation: SendTokenItemDetailsPresentation)
        }
        
        let hideRegularTokenDetails: Bool
        let hideTokenItemDetails: Bool
        let tokenPresentationType: TokenPresentationType
    }
    
    struct TransactionInput {
        enum TokenInfo {
            case erc721(tokenId: String)
            case erc20(amount: String)
        }
        
        enum Speed {
            case regular
            case fast
        }
        
        var tokenInfo: TokenInfo?
        var nickname: String?
        var addressTo: String?
        var speed: Speed = .regular
    }
 
    let asset: WalletAsset
    var transactionInput: TransactionInput
    
    required init(asset: WalletAsset) {
        self.asset = asset
        self.transactionInput = TransactionInput(tokenInfo: nil, nickname: nil, addressTo: nil, speed: .regular)
    }
    
    public func send(to: String, amount: String?, completion: @escaping () -> Void) {
        let amountToSend: HyperlootSendAmount
        if asset.token.isERC721() {
            amountToSend = .uniqueToken
        } else {
            amountToSend = .amount(amount ?? "")
        }
        Hyperloot.shared.send(token: asset.token, to: to, amount: amountToSend) { (result) in
            switch result {
            case .success(let transaction):
                print(transaction)
            case .failure(let error):
                print(error)
            }
            
            completion()
        }
    }
    
    private func tokenPresentationInfo() -> (hideRegularTokenDetails: Bool, hideTokenItemDetails: Bool, tokenPresentationType: Presentation.TokenPresentationType) {
        var hideRegularTokenDetails = true
        var hideTokenItemDetails = true
        var tokenPresentationType: Presentation.TokenPresentationType
        
        switch asset.value {
        case .ether:
            fallthrough
        case .erc20:
            hideRegularTokenDetails = false
            tokenPresentationType = .regularToken(presentation: SendTokenDetailsPresentation(tokenSymbol: asset.token.symbol,
                                                                                             amountPlaceholderText: "Amount"))
        case .erc721(tokenId: let tokenId, totalCount: _, attributes: let attributes):
            hideTokenItemDetails = false
            tokenPresentationType = .tokenItem(presentation: SendTokenItemDetailsPresentation(imageURL: attributes?.imageURL,
                                                                                              name: attributes?.name ?? tokenId,
                                                                                              description: attributes?.description))
        }
        return (hideRegularTokenDetails: hideRegularTokenDetails, hideTokenItemDetails: hideTokenItemDetails, tokenPresentationType: tokenPresentationType)
    }
    
    var presentation: Presentation {
        let tokenPresentationInfo = self.tokenPresentationInfo()
        return Presentation(hideRegularTokenDetails: tokenPresentationInfo.hideRegularTokenDetails,
                            hideTokenItemDetails: tokenPresentationInfo.hideTokenItemDetails,
                            tokenPresentationType: tokenPresentationInfo.tokenPresentationType)
    }
}
