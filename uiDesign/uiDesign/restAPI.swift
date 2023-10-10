//
//  restAPI.swift
//  uiDesign
//
//  Created by Imcrinox Mac on 01/06/23.
//

import Foundation

struct restAPI: Codable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
    let id: Int
}
