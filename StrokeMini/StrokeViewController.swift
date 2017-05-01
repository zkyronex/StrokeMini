//
//  StrokeViewController.swift
//  StrokeMini
//
//  Created by Jason Chan on 1/5/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

extension StrokeViewController {
    
    enum Style {
        case repeating, consecutive
    }
}

private let svgs = ["strokeFirst", "strokeSecond"]

class StrokeViewController: UIViewController {

    var style: Style = .repeating
    
    var index: Int = 0
    
    var reps: Int = 0 { didSet {
        updateReps()
        }
    }
    
    var timer: Timer?
    
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var repsLabel: UILabel!
    @IBOutlet var drawView: TouchDrawView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareSVG()
        updateReps()
        resetTimer()
    }
    
    func resetTimer() {
        let time: TimeInterval = index == 0 ? 8 : 5
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: time, repeats: true, block: { [weak self] _ in
            self?.prepareSVG()
        })
    }

    func prepareSVG() {
        guard let path = Bundle.main.path(forResource: svgs[index], ofType: "svg") else { return }
            
        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
    }

    
    // MARK: - Actions
    
    func updateReps() {
        repsLabel.text = "\(reps)/10 Reps"
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        if style == .repeating {
            reps += 1
            
            if reps == 10 {
                if index == 0 {
                    index = 1
                    reps = 0
                } else {
                    completePratise()
                }
            }
        }
        else {
            if index == 1 {
                reps += 1
                index = 0
            } else {
                index = 1
            }
            
            if reps == 10 {
                completePratise()
            }
        }
        
        drawView.clearDrawing()
        prepareSVG()
        resetTimer()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func completePratise() {
        let controller = UIAlertController(title: "Well Done", message: "You have completed this practise", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(controller, animated: true, completion: nil)
    }
}
