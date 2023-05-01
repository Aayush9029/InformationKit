//
//  File.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import Foundation

struct InformationModel {
    let title: String
    let description: String
    let image: URL
    let url: URL
    let type: String
}

enum InformationType {
    case news, update
}
