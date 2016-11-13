//
//  ViewController.swift
//  KKPopupView
//
//  Created by Kenan Karakecili on 11/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var label1: UILabel!
  @IBOutlet weak var label2: UILabel!
  @IBOutlet weak var label3: UILabel!
  @IBOutlet weak var label4: UILabel!

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
  
  func viewButtonDidPress(text1: String, text2: String, text3: String, text4: String) {
    KKPopupView.shared.dismissView()
    label1.text = text1
    label2.text = text2
    label3.text = text3
    label4.text = text4
  }
  
}

