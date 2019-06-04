//
//  ViewController.swift
//  ARKitTest
//
//  Created by defaultUser on 04/06/2019.
//  Copyright © 2019 Polina Guryeva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  //      didTapOpenCamera(UIButton())
    }
    
    
    @IBAction func didTapOpenCamera(_ sender: Any) {
        let vc = UIStoryboard(name: "Camera", bundle: nil).instantiateViewController(withIdentifier: "cameraVC")
        navigationController?.pushViewController(vc, animated: true)
    }

}

