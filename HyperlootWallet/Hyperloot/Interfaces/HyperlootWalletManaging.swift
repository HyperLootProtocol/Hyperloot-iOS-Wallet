//
//  HyperlootWalletManaging.swift
//  HyperlootWallet
//
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import Foundation

protocol HyperlootWalletManaging {
    
    func currentWallet() -> HyperlootWallet?
    
    func canRegister(email: String, completion: @escaping (Bool) -> Void)
    func login(email: String, password: String, completion: @escaping (HyperlootUser?, Error?) -> Void)
    func signup(email: String, password: String, nickname: String, walletAddress: String, completion: @escaping (_ user: HyperlootUser?, _ error: Error?) -> Void)
    func createWallet(password: String, completion: @escaping (_ address: String?, _ mnemonicPhraseWords: [String]?, _ error: Error?) -> Void)
    func importWallet()
}
