//
//  webView2ViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/26/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class webView2ViewController: UIViewController,UIWebViewDelegate {
   
    @IBOutlet weak var companyname: UILabel!
    
    @IBOutlet weak var fnYear: UILabel!
    var imageView:UIImageView!
    @IBOutlet weak var companyName1: UILabel!
    var pdf123=String()
    var a=0
    var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    @IBOutlet weak var webView2: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        webView2.scrollView.bounces=false
        webView2.scrollView.bouncesZoom=false
        
        
        /*    var width=(self.view.bounds.width/2)-40
         var height=(self.view.bounds.height/2)-40
         activityIndicator.frame=CGRect(x:width, y: height, width: 80, height: 80)
         activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.whiteLarge
         activityIndicator.backgroundColor=UIColor.darkGray
         self.view.addSubview(activityIndicator)
         activityIndicator.startAnimating()
         activityIndicator.hidesWhenStopped=true*/
        /*  pdf123
         =  UserDefaults.standard.object(forKey: "urlForWebView") as! String
         print(pdf123,"bvspRock")
         */
        // pdf123=pdf123.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
        
        /*    l/Users/narayan/Desktop/KhataBahi 2/KhataBahi/webView2ViewController.swift:66:13: Type 'Bool' has no member 'landscapeLeft'et url=NSURL(string:pdf123) as! URL
         
         
         let req=NSURLRequest(url: url as! URL)
         
         
         webView2.loadRequest(req as URLRequest)*/
    }
    
  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
    return (UIApplication.topViewController()?.preferredInterfaceOrientationForPresentation)!
    }
    
    override var shouldAutorotate: Bool {
    

 
        return (UIApplication.topViewController()?.shouldAutorotate)!
    }
    
   override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
    return (UIApplication.topViewController()?.supportedInterfaceOrientations)!
    
    }
   
    /*override func viewWillAppear(_ animated: Bool) {
        /*AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)*/
        if UIDevice.current.orientation == .portrait
        {
            AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        }
        if UIDevice.current.orientation == .landscapeRight
        {
            AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)
            
        }
        if UIDevice.current.orientation == .landscapeLeft
        {
            AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeLeft, andRotateTo: UIInterfaceOrientation.landscapeLeft)
        }
       
       
    }*/
    override func viewDidAppear(_ animated: Bool) {
      
        var fnYear1=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        var dashBoardCompanyName123=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)

        companyName1.text=dashBoardCompanyName123
        fnYear.text="(\(fnYear1))"
        
        pdf123
            =  UserDefaults.standard.object(forKey: "urlForWebView") as! String
       
        pdf123=pdf123.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
//        let url = URL(string: pdf123)
//        var urlRequest = URLRequest(url: url!)
//        urlRequest.cachePolicy = .returnCacheDataElseLoad
//        webView2.loadRequest(urlRequest)
        
        
        
        
     let url=NSURL(string:pdf123) as! URL
        
        
        let req=NSURLRequest(url: url as! URL)
      
        
        
        webView2.loadRequest(req as URLRequest)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DispatchQueue.main.async {
            self.imageView.isHidden=true
        }
    }
    
    @IBOutlet weak var dismiss: UIButton!
    
    @IBAction func dismissView(_ sender: UIButton) {
       /* AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)*/
        dismiss(animated: false, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape == true
        {
            print("land")
        }
        else
        {
            print("potrait")
            
        }
        
    }
   
}

