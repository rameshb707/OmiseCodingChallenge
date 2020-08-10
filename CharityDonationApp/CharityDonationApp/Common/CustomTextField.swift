//
//  CustomTextFiels.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 10/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//
import UIKit
 
public protocol TextDidChangeDelegate: NSObjectProtocol {
    func textFieldDidChange(textField: CustomTextField, sTextFormat: String, sText: String)
}
 
/// Custom Text field to handle various requirements
public class CustomTextField: UITextField {
    
    // MARK:- Properties
    public var replacementChar: Character = "#"
    public var secureTextReplacementChar: Character = "\u{25cf}"
    public var formattingPattern: String = ""
    public var maxLength = 0
    public weak var delegateCimbTextField: TextDidChangeDelegate?
    private let present = CustomTextFieldPresenter()
    
    // MARK:- Initializers
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpTextField()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpTextField()
    }
    

    public func setUpTextField() {
        self.borderStyle = .none
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 0.2
        self.registerForNotifications()
    }
    
    // MARK:- Override functions
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setUpTextField()
        
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 22, bottom: 8, right: 22 + self.increaseRightPadding()))
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 22, bottom: 8, right: 22 + self.increaseRightPadding()))
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 22, bottom: 8, right: 22 + self.increaseRightPadding()))
    }
    
    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.clearButtonRect(forBounds: bounds)
        return bounds.offsetBy(dx: -8.0, dy: 0.0)
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(resignFirstResponder):
            return true
        default:
            return false
        }
    }
    
    override public var text: String! {
        set {
            super.text = newValue
            self.textDidChange()
        }
        get {
            if self.formattingPattern.count == 0 {
                return super.text
            } else {
                self.textDidChange()
                return super.text
            }
        }
    }
    
    private func increaseRightPadding() -> CGFloat {
        var increaseRightPadding: CGFloat = 0
        if (self.clearButtonMode != .never) {
            increaseRightPadding = 8
        }
        return increaseRightPadding
    }
    
    /**
     Sets the textfield to number format

     - Parameters:
        - formattingPattern: the patter in which the text has to be entered
        - replacementChar:the string which has to replaced in presenter
     */
    public func setNumberFormatting(formattingPattern: String, replacementChar: Character = "#") {
        self.formattingPattern = formattingPattern
        self.replacementChar = replacementChar
    }
    
    
    func getText(bWithOutFormat: Bool = true) -> String {
        return bWithOutFormat ? self.present.textWithoutFormat : self.present.textFormat
    }
    
    /// Local notification to observe the changes of the text entered in the field
    fileprivate func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.textDidChange),
            name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
            object: self
        )
    }
    
    @objc public func textDidChange() {
        var sText: String { return super.text ?? "" }
        if let sTextFormat = self.present.insertTextFormat(
            sText: sText,
            sFormattingPattern: self.formattingPattern,
            sReplacementChar: self.replacementChar
            ) {
            super.text = sTextFormat
        }
        self.delegateCimbTextField?.textFieldDidChange(textField: self, sTextFormat: self.present.textFormat, sText: self.present.textWithoutFormat)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
 
extension TextDidChangeDelegate {
    func textFieldDidChange(textField: CustomTextField, sTextFormat: String, sText: String) {}
}
 

