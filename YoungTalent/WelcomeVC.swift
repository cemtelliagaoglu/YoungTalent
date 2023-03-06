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
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
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
        guard let isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else{ return }
        darkModeSwitch.isOn = isDarkMode
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
    
    
    @IBAction func darkModeSwitched(_ sender: UISwitch) {
        // save the change to UserDefaults
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkMode")
        // update current mode for all pages
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark: .light
        }
    }
}
