//
//  CustomTextFieldPresenter.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 10/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

/// Used to fromat the text entered in the textfield
class CustomTextFieldPresenter {
    
    // MARK:- Public properties
    public var secureTextReplacementChar: Character = "\u{25cf}"
    public var textFormat = ""
    public var textWithoutFormat : String {
        return self.textFormat.keepOnlyDigits()
    }
    
    /**
     Represents the textfield input text format in custom way based on bussiness requirments

     - Parameters:
        - sText: entered string
        - sFormattingPattern:the pattern to be formatted
        - sReplacementChar: replacing # with the entered character
     
     - Returns: String as result with the format required
     */
    func insertTextFormat(sText: String, sFormattingPattern: String = "", sReplacementChar: Character = "#") -> String? {
        var sTextTemp: String? = nil
        let currentTextForFormatting: String
        let iMaxLength = sFormattingPattern.count
        
        if sText.count > self.textFormat.count {
            currentTextForFormatting = self.textFormat + sText[sText.index(sText.startIndex, offsetBy: self.textFormat.count)...]
        } else if sText.count == 0 {
            self.textFormat = ""
            currentTextForFormatting = ""
        } else {
            currentTextForFormatting = String(self.textFormat[..<self.textFormat.index(self.textFormat.startIndex, offsetBy: sText.count)])
        }
        
        if currentTextForFormatting.count > 0 && sFormattingPattern.count > 0 {
            let tempString = currentTextForFormatting.keepOnlyDigits()
            var finalText = ""
            var finalSecureText = ""
            
            var stop = false
            
            var formatterIndex = sFormattingPattern.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                let formattingPatternRange = formatterIndex ..< sFormattingPattern.index(formatterIndex, offsetBy: 1)
                if sFormattingPattern[formattingPatternRange] != String(sReplacementChar) {
                    
                    finalText = finalText + sFormattingPattern[formattingPatternRange]
                    finalSecureText = finalSecureText + sFormattingPattern[formattingPatternRange]
                    
                } else if tempString.count > 0 {
                    
                    let pureStringRange = tempIndex ..< tempString.index(tempIndex, offsetBy: 1)
                    
                    finalText = finalText + tempString[pureStringRange]
                    
                    // we want the last number to be visible
                    if tempString.index(tempIndex, offsetBy: 1) == tempString.endIndex {
                        finalSecureText = finalSecureText + tempString[pureStringRange]
                    } else {
                        finalSecureText = finalSecureText + String(self.secureTextReplacementChar)
                    }
                    
                    tempIndex = tempString.index(after: tempIndex)
                }
                
                formatterIndex = sFormattingPattern.index(after: formatterIndex)
                
                if formatterIndex >= sFormattingPattern.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
            }
            
            self.textFormat = finalText
            
            let newText = finalText
            if newText != sText {
                sTextTemp = finalText
            }
        } else {
            self.textFormat = sText
        }
        
        if iMaxLength > 0 {
            if sText.count > iMaxLength {
                sTextTemp = String(sText[..<sText.index(sText.startIndex, offsetBy: iMaxLength)])
                self.textFormat = String(self.textFormat[..<self.textFormat.index(self.textFormat.startIndex, offsetBy: iMaxLength)])
            }
        }
        return sTextTemp
    }
}
