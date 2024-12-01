//
//  Gallery.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 11/29/24.
//
import Foundation

struct Gallery: Codable {
    let name: String
    let coordinates: [Double]
    let connections: [String: Double]?
    let offsets: [Int]
}

struct PathResponse: Codable {
    let path: [String]
}
