//
//  ViewController3.swift
//  CalculatorTutorial
//
//  Created by Tashin Ahamed on 12/24/22.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewController3: UIViewController
{

    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.text = ""
        passwordField.text = ""
        FirebaseApp.configure()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mail(_ sender: Any) {
    }
    
    @IBAction func pass(_ sender: Any) {
    }
    
    @IBAction func loginbtn(_ sender: Any) {
        login()
    }
    @IBAction func registerbtn(_ sender: Any) {
        register()
    }

    func login()
    {
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                        
                        if error != nil {
                            // Couldn't sign in
//                            self.errorLabel.text = error!.localizedDescription
//                            self.errorLabel.alpha = 1
                        }
                        else {
                            
                            let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController)!
                            self.navigationController?.pushViewController(vc, animated: true)
//                            let homeViewController = self.storyboard?.instantiateViewController(identifier: ViewController) as? ViewController
//
//                            self.view.window?.rootViewController = homeViewController
//                            self.view.window?.makeKeyAndVisible()
                        }
                    }
        
//        Auth.auth().signIn(withEmail: email, password: password){
//            result , error in if error != nil{
//                print(error!.localizedDescription)
//            }
//        }
    }

    func register()
    {
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().createUser(withEmail: email, password: password){
            result , error in if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
