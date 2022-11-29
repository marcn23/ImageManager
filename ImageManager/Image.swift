//
//  Image.swift
//  ImageManager
//
//  Created by Marc Navarro on 29/11/22.
//

import Foundation

public struct Image{
    let ttl: String
    let desc: String
    let keyw: String
    let auth: String
    let creat: String
    let dateC: String
    let dateS: String
    let filen: String
    let id: String
    let portrait: Bool
    
    init(response: APIImage){
        ttl = response.ttl
        desc = response.desc
        keyw = response.keyw
        auth = response.auth
        creat = response.creat
        dateC = response.dateC
        dateS = response.dateS
        filen = response.filen
        id = response.id
        portrait = response.portrait
    }
}
