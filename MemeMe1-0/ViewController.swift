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
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!

  let memeTextFieldDelegate = MemeTextFieldDelegate()
  var memeTextFieldKeyboardManager: MemeTextFieldKeyboardManager!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Enable our keyboard manager
    memeTextFieldKeyboardManager = MemeTextFieldKeyboardManager(view: view, textFields: [bottomTextField])

    // Set text field delegates
    topTextField.delegate = memeTextFieldDelegate
    bottomTextField.delegate = memeTextFieldDelegate

    // Set meme attributes for text fields
    setStrokeAttributes(on: topTextField)
    setStrokeAttributes(on: bottomTextField)

    // Enable camera button only if a camera exists
    cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    memeTextFieldKeyboardManager.start()
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    memeTextFieldKeyboardManager.stop()
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  @IBAction func pickImage(sender: UIBarButtonItem) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = sender.tag == 0 ? .Camera : .PhotoLibrary

    presentViewController(imagePicker, animated: true, completion: nil)
  }

  @IBAction func shareImage(sender: UIBarButtonItem) {
    let activityView = UIActivityViewController(activityItems: [], applicationActivities: [])
    presentViewController(activityView, animated: true, completion: nil)
  }

  private func setStrokeAttributes(on textField: UITextField!) {
    var textAttributes = textField.defaultTextAttributes

    textAttributes[NSStrokeWidthAttributeName] = -3.0
    textAttributes[NSStrokeColorAttributeName] = UIColor.blackColor()

    textField.defaultTextAttributes = textAttributes
  }

  // MARK: UIImagePickerControllerDelegate

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    imageView.image = image
    shareButton.enabled = true
    dismissViewControllerAnimated(true, completion: nil)
  }
}

