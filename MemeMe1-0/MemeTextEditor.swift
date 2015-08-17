//
//  MemeTextEditor.swift
//  MemeMe1-0
//
//  Created by Kevin Sjöberg on 17/08/15.
//  Copyright (c) 2015 Kevin Sjöberg. All rights reserved.
//

import Foundation
import UIKit

class MemeTextEditor: NSObject, UITextFieldDelegate {
  let defaultText: String

  init(defaultText: String) {
    self.defaultText = defaultText
  }

  // MARK: UITextFieldDelegate

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidBeginEditing(textField: UITextField) {
    if defaultText == textField.text {
      textField.text = ""
    }
  }

  func textFieldDidEndEditing(textField: UITextField) {
    if textField.text == "" {
      textField.text = defaultText
    }
  }
}