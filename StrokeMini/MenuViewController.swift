//
//  MenuViewController.swift
//  StrokeMini
//
//  Created by Jason Chan on 1/5/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func repeatingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StrokeViewController") as! StrokeViewController
        viewController.style = .repeating
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func consecutiveTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StrokeViewController") as! StrokeViewController
        viewController.style = .consecutive
        
        present(viewController, animated: true, completion: nil)
    }
    
}

