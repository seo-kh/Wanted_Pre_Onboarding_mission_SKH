//
//  ViewController.swift
//  Wanted_Pre_Onboarding_mission_SKH
//
//  Created by james seo on 2023/02/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageViews: [UIImageView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLoadButton(_ sender: UIButton) {
        print(sender.tag, "th button clicked!")
    }
    
}

