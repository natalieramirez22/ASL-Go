//
//  LearnViewController.swift
//  ASL
//
//  Created by Gauri Pala on 2/20/21.
//

import Foundation
import UIKit

class LearnViewController:UIViewController{
    
    
    @IBOutlet weak var starImg: UIButton!
    @IBOutlet weak var card: UIButton!
    var correct: Int = 0
    var wrong: Int = 0
    var isOpen = true
    var currentIndex:Int = 0
    let alphabet:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    let asl:[UIImage] = [
        UIImage(named: "a.png")!, UIImage(named: "b.png")!, UIImage(named: "c.png")!, UIImage(named: "d.png")!, UIImage(named: "e.png")!, UIImage(named: "f.png")!, UIImage(named: "g.png")!, UIImage(named: "h.png")!,UIImage(named: "i.png")!,UIImage(named: "j.png")!,UIImage(named: "k.png")!,UIImage(named: "l.png")!,UIImage(named: "m.png")!,UIImage(named: "n.png")!,UIImage(named: "o.png")!,UIImage(named: "p.png")!,UIImage(named: "q.png")!,UIImage(named: "r.png")!,UIImage(named: "s.png")!,UIImage(named: "t.png")!,UIImage(named: "u.png")!,UIImage(named: "v.png")!,UIImage(named: "w.png")!,UIImage(named: "x.png")!,UIImage(named: "y.png")!,UIImage(named: "z.png")!,
        
    
    ]
    
    var starred:[String] = []
   
    override func viewDidLoad() {
        card.setTitle(alphabet[currentIndex], for: .normal)
        card.imageView?.contentMode = .scaleAspectFit
        card.layer.cornerRadius = 25
        starImg.setImage(UIImage(systemName: "star"), for: .normal)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "finished"){
            let popUpVar = segue.destination as! FinishedViewController
            popUpVar.starred = starred
            popUpVar.c = correct
            popUpVar.w = wrong
        }
    }
    
    @IBAction func back(_ sender: Any) {
        if(currentIndex != 0){
            currentIndex-=1
            card.setImage(nil, for: .normal)
            card.setTitle(alphabet[currentIndex], for: .normal)
            isOpen = true
        }
    }
    
    
    @IBAction func next(_ sender: Any) {
        if(currentIndex != 25){
            currentIndex+=1
            card.setImage(nil, for: .normal)
            card.setTitle(alphabet[currentIndex], for: .normal)
            isOpen = true
            starImg.setImage(UIImage(systemName: "star"), for: .normal)
        }
       
    }
    
    @IBAction func cardTap(_ sender: Any) {
        if isOpen{
            isOpen = false
            card.setImage(asl[currentIndex], for: .normal)
            card.imageView?.contentMode = .scaleAspectFit
            card.setTitle(nil, for: .normal)
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        else{
            isOpen = true
            card.setImage(nil, for: .normal)
            card.setTitle(alphabet[currentIndex], for: .normal)
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            if(currentIndex == 25){
                currentIndex = 0
                card.setTitle(alphabet[currentIndex], for: .normal)
                performSegue(withIdentifier: "finished", sender: self)
                starred = []
            }
        }
        
    }
   
    @IBAction func star(_ sender: Any) {
        starred.append(alphabet[currentIndex])
        starImg.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    
    
    @IBAction func gotRight(_ sender: UIButton) {
        correct += 1
    }
    
    @IBAction func gotWrong(_ sender: UIButton) {
        wrong += 1
    }
    
    
}
