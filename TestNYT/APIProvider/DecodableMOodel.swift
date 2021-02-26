//
//  DecodableMOodel.swift
//  TestNYT
//
//  Created by Vlad on 26.02.2021.
//

import Foundation

struct Post : Decodable {
    let subsection : String?
    let title : String?
    let url : String?
}

struct Info : Decodable {
    let status : String?
    let num_results : Int?
    let results : [Post]
}
