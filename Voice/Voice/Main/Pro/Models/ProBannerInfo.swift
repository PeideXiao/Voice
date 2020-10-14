//
//  ProBannerInfo.swift
//  Voice
//
//  Created by Peide Xiao on 10/14/20.
//

import Foundation

struct ProBannerInfo {
    var title: String
    var content: String
    var comparisonTableShow: Bool
}


let bannerArr:[ProBannerInfo] = [
    ProBannerInfo(title: "Unlimited access to our videos", content: "Enjoy our specially curated video lessons and learning feature freely! Learn form all your favorite topics and videos!", comparisonTableShow: false),
    ProBannerInfo(title: "AI Pronuncition Analysis", content: "The AI Pronumciation Analysis feature can provide you with personalized pronuciation tips to help you practice English speaking by yourself!", comparisonTableShow: false),
    ProBannerInfo(title: "Keep track of your progress throgh your learning history", content: "The app can help you keep track of your star pointes and when you studied! Come back every day to review your study stats!", comparisonTableShow: false),
    ProBannerInfo(title: "Free Basic Features vs. Pro Advanced Features", content: "Want to know more about Pro has to offer ?", comparisonTableShow: true)
];
