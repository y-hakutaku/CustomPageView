//
//  ViewController.swift
//  CustomPageView
//
//  Created by Hakutaku on 2018/09/24.
//  Copyright © 2018年 Hakutaku. All rights reserved.
//

import UIKit

let kMenuItemWidth: CGFloat = 90.0
let kMenuItemHeight: CGFloat = 40.0
let kSeparatorHeight: CGFloat = 2.0
let kMenuBarHeight: CGFloat = 1.0

class PageMenuViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var menuBar: UIView? = nil
    var menuBarHeight: CGFloat = kMenuBarHeight
    var customPageMenu = [CustomPageMenuItem]()
    
    var currentIndex = 0 {
        didSet {
            moveMenuBar(at: currentIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        self.setUpMenuItem()
        self.setUpMenuBar()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpMenuItem() {
        var x: CGFloat = 0.0
        let y: CGFloat = 0.0
        let w: CGFloat = kMenuItemWidth
        let h: CGFloat = kMenuItemHeight - y
        
        let count: Int = PageItem.titles.count
        for index in 0 ..< count {
            let frame: CGRect = CGRect(x: x, y: y, width: w, height: h)
            x += w
            let pageMenu = CustomPageMenuItem(frame: frame, title: PageItem.titles[index])
            self.scrollView.addSubview(pageMenu)
            self.customPageMenu.append(pageMenu)
        }
        
        let  width: CGFloat = self.scrollView!.bounds.size.width
        let height: CGFloat = self.scrollView!.bounds.size.height
        self.scrollView?.contentSize = CGSize(width: x, height: height)
        
        var frame: CGRect = self.scrollView!.frame
        if (width > x) { 
            frame.origin.x = floor((width - x) * 0.5)
            frame.size.width = x
        }
        else {
            frame.origin.x = 0.0
            frame.size.width = width
        }
        self.scrollView?.frame = frame
    }

    func setUpMenuBar() {
        let x: CGFloat = 0.0
        let y: CGFloat = self.scrollView!.frame.size.height - self.menuBarHeight
        let w: CGFloat = kMenuItemWidth
        let h: CGFloat = self.menuBarHeight
        
        let color: UIColor = .red
        
        let menuBar: UIView
        menuBar = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        menuBar.backgroundColor = color
        self.scrollView?.addSubview(menuBar)
        self.menuBar = menuBar
    }
    
    func moveMenuBar(at index: Int) {
        self.willMoveMenuBar(at: index)
        
        let w: CGFloat = kMenuItemWidth
        let x: CGFloat = w * CGFloat(index)
        
        if var frame: CGRect = self.menuBar?.frame {
            frame.origin.x = x
            self.menuBar?.frame = frame
        }
    }
    
    func willMoveMenuBar(at index: Int) {
        let w: CGFloat = kMenuItemWidth
        var x: CGFloat = w * CGFloat(index)
        let y: CGFloat = 0.0
        
        let  width: CGFloat = self.scrollView!.frame.size.width
        // 洗濯中のタブを中央にする処理
        let size: CGSize = self.scrollView!.contentSize
        let leftX: CGFloat = (width - w) * 0.5 // 画面幅の半分からタブ幅の半分を引く
        let tabN: CGFloat = ceil(width / w) // 画面内に見えるタブの数
        let rightX: CGFloat = size.width - floor((tabN * 0.5 + 0.5) * w)
        
        if x <  leftX {
            x  = 0.0
        } else if x > rightX {
            x  = size.width - width
        } else {
            x -= leftX
        }
        
        self.scrollView?.setContentOffset(CGPoint(x: x, y: y), animated: true)
    }
}

