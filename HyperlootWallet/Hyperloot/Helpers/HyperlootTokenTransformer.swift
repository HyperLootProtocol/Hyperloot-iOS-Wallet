//
//  HyperlootTokenTransformer.swift
//  HyperlootWallet
//
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import Foundation
import BigInt

class HyperlootTokenTransformer {
        
    static func token(from contractable: TokenContractable, balance: String, blockchain: Blockchain) -> HyperlootToken? {
        guard let type = contractable.type else { return nil }
        
        var tokenType: HyperlootToken.TokenType? = nil
        
        switch type {
        case TokenContractableConstants.tokenERC20Type:
            if let amount = BigInt(balance) {
                let amountString = EtherNumberFormatter.full.string(from: amount, decimals: contractable.decimals ?? 0)
                tokenType = .erc20(amount: amountString)
            }
        case TokenContractableConstants.tokenERC721Type:
            tokenType = .erc721(tokenId: HyperlootToken.Constants.noTokenId, totalCount: Int(balance) ?? 0, attributes: nil)
        default:
            break
        }
        
        guard let hyperlootTokenType = tokenType else { return nil }
        
        return HyperlootToken(contractAddress: contractable.contractAddress ?? "",
                              name: contractable.name ?? "",
                              symbol: contractable.symbol ?? "",
                              decimals: contractable.decimals ?? 0,
                              totalSupply: contractable.totalSupply ?? "",
                              type: hyperlootTokenType,
                              blockchain: blockchain,
                              tokenImageURL: contractable.imageURL,
                              description: contractable.description,
                              shortDescription: contractable.shortDescription,
                              externalLink: contractable.externalLink)
    }
    
    static func token(from token: HyperlootToken, balance: String, blockchain: Blockchain) -> HyperlootToken {
        let type: HyperlootToken.TokenType
        switch token.type {
        case .ether(amount: let prevAmount):
            fallthrough
        case .erc20(amount: let prevAmount):
            if let amount = BigInt(balance) {
                let amountString = EtherNumberFormatter.full.string(from: amount, decimals: token.decimals)
                type = .erc20(amount: amountString)
            } else {
                type = .erc20(amount: prevAmount)
            }
        case .erc721(tokenId: let tokenId, totalCount: _, attributes: let attributes):
            type = .erc721(tokenId: tokenId, totalCount: Int(balance) ?? 0, attributes: attributes)
        }
        
        return HyperlootToken(contractAddress: token.contractAddress,
                              name: token.name,
                              symbol: token.symbol,
                              decimals: token.decimals,
                              totalSupply: token.totalSupply,
                              type: type,
                              blockchain: blockchain,
                              tokenImageURL: token.tokenImageURL,
                              description: token.description,
                              shortDescription: token.shortDescription,
                              externalLink: token.externalLink)
    }
    
    static func tokenizedItem(from token: HyperlootToken, tokenId: String, attributes: HyperlootToken.Attributes?) -> HyperlootToken? {
        guard token.isERC721(),
            case .erc721(tokenId: _, totalCount: let totalCount, attributes: _) = token.type else {
            return nil
        }
        
        return HyperlootToken(contractAddress: token.contractAddress,
                              name: token.name,
                              symbol: token.symbol,
                              decimals: token.decimals,
                              totalSupply: token.totalSupply,
                              type: .erc721(tokenId: tokenId, totalCount: totalCount, attributes: attributes),
                              blockchain: token.blockchain,
                              tokenImageURL: token.tokenImageURL,
                              description: token.description,
                              shortDescription: token.shortDescription,
                              externalLink: token.externalLink)
    }
}
