//
//  WelcomeVC.swift
//  YoungTalent
//
//  Created by admin on 2.03.2023.
//

import UIKit

class WelcomeVC: UIViewController{
    //MARK: - Properties
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Handlers
    func setupView(){
        
        // registerLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleRegisterTapped))
        registerLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func handleRegisterTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
