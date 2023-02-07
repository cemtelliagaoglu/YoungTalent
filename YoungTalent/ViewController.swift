//
//  ViewController.swift
//  YoungTalent
//
//  Created by admin on 7.02.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myURL = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
        print(myURL)
    }


}

