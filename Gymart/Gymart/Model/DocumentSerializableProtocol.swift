//
//  DocumentSerializableProtocol.swift
//  Gymart
//
//  Created by William on 03/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

public protocol DocumentSerializableProtocol {
    init?(dictionary: [String: Any])
}
