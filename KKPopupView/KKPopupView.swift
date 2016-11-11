//
//  KKPopupView().swift
//
//  Created by Kenan Karakecili on 15/06/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class KKPopupView {
  
  static let shared = KKPopupView()
  private var hasMoved = false
  private var keyboardHeight: CGFloat = 0.0
  private init() {}
  
  func showView(view: UIView) {
    guard let window = UIApplication.sharedApplication().keyWindow else { return }
    let frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame))
    let curtainView = UIView(frame: frame)
    curtainView.backgroundColor = UIColor.blackColor()
    curtainView.alpha = 0.0
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
    curtainView.addGestureRecognizer(tapGesture)
    curtainView.tag = 19121988
    window.addSubview(curtainView)
    view.center = window.center
    view.alpha = 0.0
    view.tag = 19881219
    window.addSubview(view)
    window.bringSubviewToFront(curtainView)
    window.bringSubviewToFront(view)
    UIView.animateWithDuration(0.2) {
      curtainView.alpha = 0.3
      view.alpha = 1.0
    }
    hasMoved = false
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(fieldDidBeginEditing), name: UITextFieldTextDidBeginEditingNotification, object: nil)
  }
  
  @objc func dismissView() {
    guard let window = UIApplication.sharedApplication().keyWindow else { return }
    let curtainView = window.viewWithTag(19121988)
    let view = window.viewWithTag(19881219)
    guard let myCurtainView = curtainView else { return }
    guard let myView = view else { return }
    NSNotificationCenter.defaultCenter().removeObserver(self)
    UIView.animateWithDuration(0.1, animations: {
      myCurtainView.alpha = 0.0
      myView.alpha = 0.0
      }) { (finished) in
        myCurtainView.removeFromSuperview()
        myView.removeFromSuperview()
    }
  }
  
  @objc private func keyboardWillShow(notification: NSNotification) {
    if let keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size.height {
      keyboardHeight = keyboard
    }
    moveView()
  }
  
  @objc private func fieldDidBeginEditing() {
    moveView()
  }
  
  private func moveView() {
    guard let window = UIApplication.sharedApplication().keyWindow else { return }
    let view = window.viewWithTag(19881219)
    guard let myView = view else { return }
    let screenHeight = CGRectGetHeight(window.bounds)
    let viewY = (screenHeight - CGRectGetHeight(myView.bounds)) / 2
    var activeFieldExactY: CGFloat = 0.0
    var fieldHeight: CGFloat = 0.0
    for subview in myView.subviews {
      if subview.isKindOfClass(UITextField) || subview.isKindOfClass(UITextView) {
        if subview.isFirstResponder() {
          activeFieldExactY = subview.frame.origin.y + viewY
          fieldHeight = subview.bounds.size.height
        }
      }
    }
    let availableView = screenHeight - keyboardHeight
    if hasMoved { return }
    if activeFieldExactY + fieldHeight + 8 > availableView {
      hasMoved = true
      let diff = activeFieldExactY + fieldHeight + 8 - availableView
      UIView.animateWithDuration(0.2) {
        myView.frame.origin.y -= abs(diff)
      }
    }
  }
  
  @objc private func keyboardWillHide() {
    guard let window = UIApplication.sharedApplication().keyWindow else { return }
    let view = window.viewWithTag(19881219)
    guard let myView = view else { return }
    myView.center = window.center
    hasMoved = false
  }
  
}
