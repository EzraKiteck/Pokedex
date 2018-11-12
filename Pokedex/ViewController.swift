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
    
    var pokemonName = ""
    
    //Base URL for request
    let pokemonAPIBaseURL = "http://pokeapi.co/api/v2/item/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        //Takes Keyboard away
        pokemonNameTextField.resignFirstResponder()
        
        //Checks against the Pokemon name being nil
        if pokemonNameTextField.text != nil || Int(pokemonNameTextField.text!) != nil {
            pokemonName = pokemonNameTextField.text!
        }  else {
            print("Please fill all text fields.")
            return
        }
        
        //Clears text field
        pokemonNameTextField.text = ""
        
        print(pokemonName)
    }
    

}

