//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Admin1 on 22/8/20.
//  Copyright © 2020 Admin1. All rights reserved.
//

import Foundation

class Emoji: Codable {
    var symbol: String?
    var name: String?
    var description: String?
    var usage: String?
    static let archiveUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("emojis").appendingPathExtension(".plist")
    
    init(symbol: String?, name: String?, description: String?, usage: String?) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    
    static func saveToFile(emojis: [Emoji]){
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        try? encodedEmojis?.write(to: archiveUrl, options: .noFileProtection)
        
    }
    
    static func loadFromFile()-> [Emoji]{
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedData = try? Data(contentsOf: archiveUrl),
            let decodedEmojis = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrievedData){
            return decodedEmojis
        }
        return []
    }
    
    static func loadSampleEmojis()->[Emoji]{
        let emojiTableViewController = EmojiTableViewController()
        emojiTableViewController.agregarEmojis()
        let emojis = emojiTableViewController.emoji
        return emojis
    }
}
