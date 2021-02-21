//
//  FinishedViewController.swift
//  ASL
//
//  Created by Gauri Pala on 2/21/21.
//

import Foundation
import UIKit

class FinishedViewController:UIViewController{
    
    var learnView = LearnViewController.init()
    var starred:[String] = []
    var concatString:String = ""
    
    @IBOutlet weak var starredLetters: UILabel!
    
    @IBAction func restart(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(starred.count > 0){
            for index in 0...starred.count-1{
                concatString += starred[index]+" "
            }
        }
        
        
        starredLetters.text = concatString
    }
}
