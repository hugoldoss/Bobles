//
//  ViewController.swift
//  Bobles
//
//  Created by Евгений Сергеев on 04.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boblesOne: SmallBobles!
    
    @IBOutlet weak var boblesTwo: SmallBobles!
    
    @IBOutlet weak var boblesThree: SmallBobles!
    
    @IBOutlet weak var boblesFour: SmallBobles!
    
    @IBOutlet weak var boblesFive: SmallBobles!
    
    @IBOutlet weak var boblesSix: SmallBobles!
    
    @IBOutlet weak var boblesSeven: SmallBobles!
    
    var boblesArray: Set<SmallBobles> = []
    
    var largeBoblesArray: Set<UIView> = []
    
    @IBOutlet weak var largeBoblesOne: UIView!
    
    @IBOutlet weak var largeBoblesTwo: UIView!
    
    @IBOutlet weak var largeBoblesThree: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeBoblesOne.layer.cornerRadius = 60
        largeBoblesOne.isHidden = true
        largeBoblesOne.alpha = 0
        largeBoblesTwo.layer.cornerRadius = 60
        largeBoblesTwo.isHidden = true
        largeBoblesTwo.alpha = 0
        largeBoblesThree.layer.cornerRadius = 60
        largeBoblesThree.isHidden = true
        largeBoblesThree.alpha = 0
    }
    
   func appendToArray() {
       if !boblesOne.isHidden {boblesArray.insert(boblesOne)}
       if !boblesTwo.isHidden {boblesArray.insert(boblesTwo)}
       if !boblesThree.isHidden {boblesArray.insert(boblesThree)}
       if !boblesFour.isHidden {boblesArray.insert(boblesFour)}
       if !boblesFive.isHidden {boblesArray.insert(boblesFive)}
       if !boblesSix.isHidden {boblesArray.insert(boblesSix)}
       if !boblesSeven.isHidden {boblesArray.insert(boblesSeven)}
    }
    
    func appendToLargeBoblesArray() {
        largeBoblesArray.insert(largeBoblesOne)
        largeBoblesArray.insert(largeBoblesTwo)
        largeBoblesArray.insert(largeBoblesThree)
    }
   
    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began {
            appendToArray()
            print(boblesArray.count)
        }
         
         let gestureTranslation = gesture.translation(in: view)
          
         guard let gestureView = gesture.view else {
              return
          }
          
         gestureView.center = CGPoint(x: gestureTranslation.x + gestureView.center.x, y: gestureTranslation.y + gestureView.center.y)
         
         gesture.setTranslation(.zero, in: view)
         
         
      
    
        if gesture.state == .changed {
            
            let gestureRestorationIdentifier = gesture.view!.restorationIdentifier!
    
            for bobles in boblesArray {
                
                if gestureRestorationIdentifier != bobles.restorationIdentifier! {
                    for x in Int(bobles.frame.minX)...Int(bobles.frame.maxX) {
                        if x == Int(gesture.view!.frame.origin.x) {
                            for y in Int(bobles.frame.minY)...Int(bobles.frame.maxY) {
                                if y == Int(gesture.view!.frame.origin.y) {
                                    print("true")
                                    appendToLargeBoblesArray()

                                    gesture.view?.isHidden = true
                                    for largeBobles in largeBoblesArray {
                                        if largeBobles.isHidden == true {
                                            largeBobles.center = CGPoint (x: bobles.center.x, y: bobles.center.y)
                                            
                                            
                                            largeBobles.isHidden = false
                                            
                                            UIView.animateKeyframes(withDuration: 3, delay: 0) {
                                                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                                                    bobles.alpha = 0
                                                }
                                                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 3) {
                                                    bobles.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                                }
                                                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                                                    largeBobles.alpha = 1
                                                }
                                                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 3) {
                                                    largeBobles.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                                }
                                                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2) {
                                                    largeBobles.backgroundColor = .systemIndigo
                                                }
                                            } completion: { _ in
                                                bobles.isHidden = true
                                            }
                                            break
                                        }
                                    }
                                    boblesArray.removeAll()
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
            
        if gesture.state == .ended {
            boblesArray.removeAll()
            print(boblesArray.count)
        } else {
            return
        }
    }
    
    
    
    
    
    
    
    
    
}
        

   
    
    

