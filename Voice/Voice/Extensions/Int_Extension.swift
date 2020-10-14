//
//  Int_Extension.swift
//  Voice
//
//  Created by Peide Xiao on 10/13/20.
//

import Foundation

extension Int {
    
    var formatted: String {
        
        if self >= 10 {
            return String(self);
        } else {
            return "0\(self)"
        }
    }
    
    
    func convertToTimer() -> String {
        
        let m = self/60;
        let s = self%60;
        
        return m.formatted + ":" + s.formatted
    }
    
    var hour: String {
        return (self/60/60).formatted
    }
    
    var minute: String {
        return ((self - Int(self.hour)! * 3600)/60).formatted
    }
    
    var second: String {
        return ((self - Int(self.hour)! * 3600 - Int(self.minute)! * 60 )/60).formatted
    }
    
}

extension Int {
    
    func convertToDateString()->String {
        let date = self.convertToDate();
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd";
        return formatter.string(from: date);
    }
    
    func convertToDate()-> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
