//
//  LoginVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

class LoginVC: UIViewController{
    
    //MARK: - Properties
    
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Handlers
    func setupView(){
        phoneNumberTextField.delegate = self
        
        // hideKeyboard
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTap)
        
        // setup termsAndConditionLabel
        let attributedText = NSMutableAttributedString(string: "By click continue you are agree with\nour",
                                                attributes: [
                                                    .foregroundColor: UIColor(named: "Blue-Light")!,
                                                    .font: UIFont(name: "Montserrat-Regular", size: 10)!
                                                ])
        attributedText.append(NSAttributedString(string: " Terms and Condition",
                                                 attributes: [
                                                    .foregroundColor: UIColor(named: "Purple-Gradient")!,
                                                    .font: UIFont(name: "Montserrat-Bold", size: 10)!
                                                 ]))
        termsAndConditionLabel.attributedText = attributedText
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(handleTermsAndConditionTapped))
        labelTap.numberOfTapsRequired = 1
        termsAndConditionLabel.addGestureRecognizer(labelTap)
        
    }
    
    @objc func handleTermsAndConditionTapped(){
        print("Terms And Condition Tapped")
    }
    
    @objc func dismissKeyboard(){
        phoneNumberTextField.resignFirstResponder()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "OTPVC")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func handleBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - TextFieldDelegate
extension LoginVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        return false
    }
}

