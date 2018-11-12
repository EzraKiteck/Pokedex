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
    let pokemonAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    
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
        
        //Replaces any spaces with plus signs for URL usage
        let pokemonNameURL = pokemonName.replacingOccurrences(of: " ", with: "+")
        
        //Building our complete request URL with pokemon
        let requestURL = pokemonAPIBaseURL + pokemonNameURL
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //To print all json, use String(describing: json)
                self.descriptionTextView.text = "Name: \(json["name"])\nID: \(json["id"])"
            case.failure(let error):
                self.descriptionTextView.text = "Invalid selection enetered or an error occured.  Please try again."
                print(error.localizedDescription)
            }
        }
    }
    

}

