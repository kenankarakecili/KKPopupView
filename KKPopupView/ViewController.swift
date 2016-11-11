//
//  ViewController.swift
//  KKPopupView
//
//  Created by Kenan Karakecili on 11/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let viewToShow = ViewToShow.instanceFromNib()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewToShow.delegate = self
  }
  
  @IBAction func showView(_ sender: UIButton) {
    KKPopupView.shared.showView(view: viewToShow)
  }

}

extension ViewController: ViewDelegate {
  
  func viewButtonDidPress(text: String) {
    KKPopupView.shared.dismissView()
  }
  
}

