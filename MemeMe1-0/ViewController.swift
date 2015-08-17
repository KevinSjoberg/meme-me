//
//  ViewController.swift
//  MemeMe1-0
//
//  Created by Kevin Sjöberg on 17/08/15.
//  Copyright (c) 2015 Kevin Sjöberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var albumButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!

  var topMemeEditor: MemeTextEditor!
  var bottomMemeEditor: MemeTextEditor!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Enable camera button only if a camera exists
    cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)

    // Set text field delegates
    topMemeEditor = MemeTextEditor(defaultText: topTextField.text)
    topTextField.delegate = topMemeEditor

    bottomMemeEditor = MemeTextEditor(defaultText: bottomTextField.text)
    bottomTextField.delegate = bottomMemeEditor

    // Set meme attributes for text fields
    setMemeAttributes(on: topTextField)
    setMemeAttributes(on: bottomTextField)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  func keyboardWillShow(notification: NSNotification) {
    self.view.frame.origin.y -= getKeyboardHeight(notification)
    println(self.view.frame.origin.y)
  }

  func keyboardWillHide(notification: NSNotification) {
    self.view.frame.origin.y += getKeyboardHeight(notification)
    println(self.view.frame.origin.y)
  }

  private func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo!
    let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()

    return keyboardSize.height
  }

  private func setMemeAttributes(on textField: UITextField!) {
    var textAttributes = textField.defaultTextAttributes

    textAttributes[NSStrokeWidthAttributeName] = -3.0
    textAttributes[NSStrokeColorAttributeName] = UIColor.blackColor()

    textField.defaultTextAttributes = textAttributes
  }


  private func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }

  private func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }

  @IBAction func pickImage(sender: UIBarButtonItem) {
    let imagePicker = UIImagePickerController()

    imagePicker.delegate = self
    imagePicker.sourceType = sender.tag == 0 ? .Camera : .PhotoLibrary

    presentViewController(imagePicker, animated: true, completion: nil)
  }

  // MARK: UIImagePickerControllerDelegate

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    imageView.image = image
    dismissViewControllerAnimated(true, completion: nil)
  }
}

