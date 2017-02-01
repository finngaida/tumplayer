//
//  Data.swift
//  TUM Player
//
//  Created by Finn Gaida on 01/02/2017.
//
//

import UIKit

enum E: Error {
    case unwrap(reason: String)
    case cast(reason: String)
}

enum Module {
    case ds
}

struct Model {
    static let baseURL = ""
    
    let name: String
    let date: Date
    let duration: TimeInterval
    let slides: URL
    let recording: URL
    
    init(_ dict: [String:String]) throws {
        guard let nme = dict["name"] else { throw E.unwrap(reason: "no name") }
//        guard let dteS = dict["date"], let dte = DateFormatter().date(from: dteS) else { throw E.unwrap(reason: "no date") }
//        guard let durS = dict["duration"], let dur = TimeInterval(durS) else { throw E.unwrap(reason: "no duration") }
        guard let slsS = dict["slidesURL"], let sls = URL(string: slsS) else { throw E.unwrap(reason: "no slides") }
        guard let recS = dict["recordingURL"], let rec = URL(string: recS) else { throw E.unwrap(reason: "no recording") }
        
        name = nme
        date = Date()
        duration = 0
        slides = sls
        recording = rec
    }
    
    static func url(for module: Module) -> URL? {
        switch module {
        case .ds:
            return Bundle.main.url(forResource: "ds", withExtension: "json")
//            return URL(string: baseURL + "ds.json")
        }
    }
}

class Server: NSObject {

    class func getInfo(for module: Module) throws -> [Model] {
        guard let url = Model.url(for: module) else { throw E.unwrap(reason: "can't unwrap url") }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves]) as? [[String:String]] else { throw E.cast(reason: "couldn't cast json") }
        
        var ret:[Model] = []
        for elem in json {
            do {
                ret.append(try Model(elem))
            } catch let e {
                print("c'mon \(e)")
            }
        }
        return ret
    }
    
}