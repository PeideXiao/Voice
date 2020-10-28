//
//  Dictation.swift
//  Voice
//
//  Created by Peide Xiao on 10/1/20.
//

import Foundation

struct Word: Codable {
    var text: String
    var isBlank: Bool
}


struct Dictation: Codable {
    var words: [Word]
    
}


struct FillingBlank: Codable {
    var words: [Word]
}


struct DictionaryWord: Codable {
    var id: Int
    var text: String
    var CEFRLevel: String
    var CEFRLevelTag: String
    var definitions: [Definition]
}

/*
 
            "pronunciationUk": "\u02c8st\u00e6g\u0259(r)",
             "pronunciationUs": "\u02c8st\u00e6\u0261\u025a",
             "pronunciationKk": "\u02cbst\u00e6g\u025a",
             "wordPlural": null,
             "wordPast": "staggered",
             "wordDone": "staggered",
             "wordIng": "staggering",
             "wordThird": "staggers",
             "meaningId": 122870,
             "pronunciationIpa": "\u02c8st\u00e6g\u0259r",
             "pos": "v.",
             "posFullName": "verb",
             "englishExample": "You will stagger her with your new look",
             "englishDefinition": "To greatly surprise someone",
             "chineseTraditionalDefinition": "\u8e63\u8dda \uff1b \u8e8a\u8e87 \uff1b \u4f7f\u5403\u9a5a \uff1b \u4f7f\u5f7c\u6b64\u4ea4\u932f \uff1b \u4f7f\u5f7c\u6b64\u4e0d\u76f8\u540c \uff1b \u6688\u5012\u75c7 \uff1b \u4ea4\u932f \uff1b \u932f\u958b \uff1b \u8e4c \uff1b \u8e09",
             "chineseSimplifiedDefinition": "\u8e52\u8dda : \u8e0c\u8e87 : \u4f7f\u5403\u60ca : \u4f7f\u5f7c\u6b64\u4ea4\u9519 : \u4f7f\u5f7c\u6b64\u4e0d\u76f8\u540c : \u6655\u5012\u75c7 : \u4ea4\u9519 : \u9519\u5f00 : \u8dc4 : \u8e09",
             "japaneseDefinition": "\u9a5a\u6115\u3055\u305b\u308b",
             "vietnameseDefinition": "l\u00e0m b\u1ed1i r\u1ed1i",
             "pronunciationUkMp3": "https:\/\/res.iciba.com\/resource\/amp3\/oxford\/0\/e6\/a3\/e6a309efa05b4104c8ebeb8af18657c0.mp3",
             "pronunciationUsMp3": "https:\/\/res.iciba.com\/resource\/amp3\/1\/0\/49\/bd\/49bd9f0a008d69d7c03af7ff0f05bb2d.mp3",
             "pronunciationTtsMp3": "https:\/\/res-tts.iciba.com\/4\/9\/b\/49bd9f0a008d69d7c03af7ff0f05bb2d.mp3"
 
 */

struct Definition: Codable {
    var pronunciationUk: String
    var pronunciationUs: String
    var pronunciationKk: String
    var wordPast: String?
    var wordDone: String?
    var wordIng: String?
    var wordThird: String?
    var meaningId: Int
    var pronunciationIpa: String
    var pos: String
    var posFullName: String
    var englishExample: String
    var englishDefinition: String
    var chineseTraditionalDefinition: String
    var chineseSimplifiedDefinition: String
    var japaneseDefinition: String
    var vietnameseDefinition: String
    var pronunciationUkMp3: String
    var pronunciationUsMp3: String
    var pronunciationTtsMp3:String
    
}
