//
//  CaptionLine.swift
//  Voice
//
//  Created by Peide Xiao on 10/1/20.
//

import Foundation

struct CaptionLine: Decodable {
    var startAt: Float;
    var duration: Float;
    var originalText: OriginalText;
    var editor: Editor?;
    var dictation: Dictation?;
    var fillingBlank: FillingBlank?;
    
}


struct OriginalText: Decodable {
    //    "id": 25881703,
    //    "captionId": 122324,
    //    "text": "From sailors who were turned into pigs, nymphs that sprouted into trees, and a gaze that converted the beholder to stone, Greek mythology brims with shape-shifters."
    
    var id: Int;
    var captionId: Int;
    var text: String;
}


struct Editor: Decodable {
    var sentence: String;
    var items: [EditItem];
}


struct EditItem: Decodable {
    
//    "text": "gaze",
//    "descriptions": [],
//    "examples": [{
//    "originalText": "He has been gazing out the window for many hours. I wonder what he is looking at. ",
//    "translatedText": ""
//    }]
    
    var text: String;
    var examples: [EditExample];
}


struct EditExample: Decodable {
    var originalText: String
}
