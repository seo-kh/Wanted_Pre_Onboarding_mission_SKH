//
//  ViewController.swift
//  Wanted_Pre_Onboarding_mission_SKH
//
//  Created by james seo on 2023/02/28.
//

import UIKit

class ViewController: UIViewController {
    /// dog-api : https://dog.ceo/dog-api/
    private let urlString: String = "https://dog.ceo/api/breeds/image/random"
    private let decoder = JSONDecoder()
    
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLoadButton(_ sender: UIButton) {
        switch sender.tag {
        case self.imageViews.count:
            // 1. URLSession.shared.dataTask
            for index in 0..<sender.tag {
                doubleURLSessionDataTask(index: index)
            }
        default:
            // 1. URLSession.shared.dataTask
            doubleURLSessionDataTask(index: sender.tag)
        }
    }
}

private extension ViewController {
    func doubleURLSessionDataTask(index: Int) {
        // 1. image placeholder
        self.imageViews[index].image = UIImage(systemName: "photo")
        // 2. fetch data
        URLSession.shared.dataTask(with: URL(string: urlString)!) { [weak self] data, _, _ in
            guard let data = data else { return }
            
            let dogData = try? self?.decoder.decode(DogAPI.self, from: data)
            
            guard dogData?.status == Optional("success") else { return }
            
            if let url = dogData?.message {
                URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, _, _ in
                    guard let data = data,
                          let image = UIImage(data: data)
                    else { return }
                    
                    DispatchQueue.main.async {
                        self?.imageViews[index].image = image
                    }
                }
                .resume()
            }
        }
        .resume()
    }
}
