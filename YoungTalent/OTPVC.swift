//
//  OTPVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

class OTPVC: UIViewController{
    //MARK: - Properties
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextFields()
    }
    
    //MARK: - Handlers
    func setupTextFields(){
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        textField1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupView(){
        // keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        textField1.endEditing(true)
        textField2.endEditing(true)
        textField3.endEditing(true)
        textField4.endEditing(true)
    }
    @objc func textDidChange(_ textField: UITextField){
        
        if textField.text!.count == 1{
            switch textField{
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                textField4.resignFirstResponder()
            default:
                break
            }
        }else{
            switch textField{
            case textField4:
                textField3.becomeFirstResponder()
            case textField3:
                textField2.becomeFirstResponder()
            case textField2:
                textField1.becomeFirstResponder()
            case textField1:
                textField1.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    @IBAction func handleBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleNextButtonTapped(_ sender: UIButton) {
        guard textField1.hasText,
              textField2.hasText,
              textField3.hasText,
              textField4.hasText else{ return }
        
        let otpCode = "\(textField1.text!)\(textField2.text!)\(textField3.text!)\(textField4.text!)"
        print("Next Button Tapped... OTP Code: \(otpCode)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

//MARK: - TextFieldDelegate
extension OTPVC: UITextFieldDelegate{
    
    
}
