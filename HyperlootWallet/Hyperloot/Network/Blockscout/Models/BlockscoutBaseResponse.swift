//
//  BlockscoutBaseResponse.swift
//  HyperlootWallet
//
//  Created by valery_vaskabovich on 12/4/18.
//  Copyright © 2018 Hyperloot DAO. All rights reserved.
//

import Foundation
import ObjectMapper

struct BlockscoutBaseResponse: ImmutableMappable {

    let status: Int?
    let message: String?
    
    init(map: Map) throws {
        status = try? map.value("status", using: StringToIntTransformer())
        message = try? map.value("message")
    }
}
