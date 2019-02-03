//
//  HyperlootERC20Token.swift
//  HyperlootWallet
//
//  Created by Valery Vaskabovich on 10/1/18.
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import Foundation
import TrustCore

struct HyperlootToken {
    
    struct Constants {
        static let noTokenId = "noTokenId"
    }
        
    struct Attributes: Codable {
        let description: String
        let name: String
        let imageURL: String
    }
    
    enum TokenType {
        case ether(amount: String)
        case erc20(amount: String)
        case erc721(tokenId: String, totalCount: Int, attributes: Attributes)
    }
    
    let contractAddress: String
    let name: String
    let symbol: String
    let decimals: Int
    let totalSupply: String
    let type: TokenType
    let blockchain: Blockchain
    
    static func ether(amount: String, blockchain: Blockchain) -> HyperlootToken {
        return HyperlootToken(contractAddress: TokenConstants.Ethereum.ethereumContract,
                              name: "Ethereum",
                              symbol: TokenConstants.Ethereum.ethereumSymbol,
                              decimals: TokenConstants.Ethereum.ethereumDecimals,
                              totalSupply: "0",
                              type: .ether(amount: amount),
                              blockchain: blockchain)
    }
    
    static func hlt(amount: String, blockchain: Blockchain) -> HyperlootToken {
        // TODO: fill the information
        return HyperlootToken(contractAddress: "0x0",
                              name: "Hyperloot",
                              symbol: "HLT",
                              decimals: 18,
                              totalSupply: "0",
                              type: .erc20(amount: amount),
                              blockchain: blockchain)
    }
}
