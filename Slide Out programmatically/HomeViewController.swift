//
//  ViewController.swift
//  Slide Out programmatically
//
//  Created by Mohsen Abdollahi on 7/19/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate var menuWidth : CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupMeunController()
        view.backgroundColor = .yellow
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        //print(translation)
        
        if gesture.state == .changed {
            var x = translation.x
            
            if isMenuOpend {
                x += menuWidth
            }
            
            x = min(menuWidth , x )
            x = max(0 , x )
            menuViewController.view.transform = CGAffineTransform(translationX: x, y: 0)
            navigationController?.view.transform = CGAffineTransform(translationX: x, y: 0)
            
        } else if gesture.state == .ended {
            
            if isMenuOpend {
                if abs(translation.x) > menuWidth / 2 {
                    handleHide()
                } else {
                    handleOpen()
                }
            } else {
                if translation.x < menuWidth / 2 {
                    handleHide()
                } else {
                    handleOpen()
                }
            }
        }
    }
    
    fileprivate func setupMeunController(){
        //initial Position
        menuViewController.view.frame = CGRect(x: -menuWidth , y: 0, width: menuWidth , height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
    }
    
    fileprivate func  setupNavigationItems(){
        navigationItem.title = "Slide Out Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleOpen))
    }
    
    let menuViewController = MenuViewController()
    fileprivate var isMenuOpend = false
    
    @objc func handleOpen(){
        isMenuOpend = true
        UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut
            , animations: {
                //Final position to animate menuViewController
                self.menuViewController.view.transform = CGAffineTransform(translationX: 300, y: 0)
                self.navigationController?.view.transform = CGAffineTransform(translationX: 300, y: 0)
                
        }, completion: nil)
    }
    
    @objc func handleHide(){
        isMenuOpend = false
        UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut
            , animations: {
                //Final position to animate menuViewController
                self.menuViewController.view.transform = .identity
                self.navigationController?.view.transform = .identity
        }, completion: nil)
    }
}



