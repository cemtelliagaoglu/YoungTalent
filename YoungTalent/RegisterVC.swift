//
//  RegisterVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

class RegisterVC: UIViewController{
    //MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - Handlers
    func setupView(){
        nameTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }

    @objc func viewTapped(){
        nameTextField.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func handleBackButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - TextFieldDelegate
extension RegisterVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nextButtonPressed(nextButton)
        return false
    }
}
