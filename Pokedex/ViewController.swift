//
//  ViewController.swift
//  Pokedex
//
//  Created by Ezra Kiteck on 11/12/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    //IB Outlets
    @IBOutlet weak var pokemonNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //Base URL for request
    let pokemonAPIBaseURL = "http://pokeapi.co/api/v2/pokemon/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        //Takes Keyboard away
        pokemonNameTextField.resignFirstResponder()
        
        //Checks against the Pokemon name being nil
        guard let pokemonName = pokemonNameTextField.text else {
                return
        }
        
        //Clears text field
        pokemonNameTextField.text = ""
        
        print(pokemonName)
        
        //Building our complete request URL with pokemon
        let requestURL = pokemonAPIBaseURL + pokemonName
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Success")
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}

