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
import SDWebImage

class ViewController: UIViewController {

    //IB Outlets
    @IBOutlet weak var pokemonNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    //Base URL for request
    let pokemonAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    let imageAPIBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    
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
        
        //The Alamofire thread that gets the info of the pokemon via the PokeAPI
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //To print all json, use String(describing: json)
                //Displays the name and ID of the pokemon
                self.descriptionTextView.text = "Name: \(json["name"])\nID: \(json["id"])"
                //Uses the base URL + the pokemons ID# + .png to get and display the default sprite
                self.pokemonImageView.sd_setImage(with: URL(string: self.imageAPIBaseURL + "\(json["id"])" + ".png"), completed: nil)
            case.failure(let error):
                //Displays an error if it fails
                self.descriptionTextView.text = "Pokemon not found!"
                print(error.localizedDescription)
            }
        }
    }
    

}

