//
//  ViewToShow.swift
//  KKPopupView
//
//  Created by Kenan Karakecili on 11/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

protocol ViewDelegate {
  func viewButtonDidPress(text1: String,
                          text2: String,
                          text3: String,
                          text4: String)
}

class ViewToShow: UIView {
  
  @IBOutlet weak var field1: UITextField!
  @IBOutlet weak var field2: UITextField!
  @IBOutlet weak var field3: UITextField!
  @IBOutlet weak var field4: UITextField!
  @IBOutlet weak var okButton: UIButton!
  
  private let toolbar = UIToolbar()
  var delegate: ViewDelegate?
  
  class func instanceFromNib() -> ViewToShow {
    return UINib(nibName: "ViewToShow", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ViewToShow
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    toolbar.barStyle = UIBarStyle.default
    toolbar.tintColor = UIColor.blue
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toolbarDoneButtonAction))
    let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    toolbar.setItems([space, doneButton], animated: false)
    field1.inputAccessoryView = toolbar
    field2.inputAccessoryView = toolbar
    field3.inputAccessoryView = toolbar
    field4.inputAccessoryView = toolbar
  }
  
  
  @objc private func toolbarDoneButtonAction() {
    endEditing(true)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    endEditing(true)
  }
  
  @IBAction func okButtonAction(_ sender: UIButton) {
    endEditing(true)
    delegate?.viewButtonDidPress(text1: field4.text!,
                                 text2: field2.text!,
                                 text3: field3.text!,
                                 text4: field4.text!)
  }
  
}
