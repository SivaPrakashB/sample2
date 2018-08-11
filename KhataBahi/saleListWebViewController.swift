//
//  saleListWebViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/24/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class saleListWebViewController: UIViewController,UIWebViewDelegate {
var dashBoardElementValueForFn=String()
var dashBoardCompanyName1=String()
var db_name=String()
var imageView1:UIImageView=UIImageView()
    
var serverurl=String()
    var pid=String()
    
    
    @IBOutlet weak var webview1: UIWebView!
    @IBOutlet weak var fnyear: UILabel!
    @IBOutlet weak var companyName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        //imageView1 = UIImageView(image:jeremyGif)
        
        
        imageView1=UIImageView(image:jeremyGif)
        
        
        imageView1.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView1)
        
        
        
        print.clipsToBounds=true
        print.layer.cornerRadius=5
        print.layer.borderWidth=1
        print.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        download.clipsToBounds=true
        download.layer.cornerRadius=5
        download.layer.borderWidth=1
        download.layer.borderColor=UIColor.lightGray.cgColor
        
        
        share.clipsToBounds=true
        share.layer.cornerRadius=5
        share.layer.borderWidth=5
        share.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        webview1.scrollView.bouncesZoom=false
        webview1.scrollView.bounces=false
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        dashBoardCompanyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        fnyear.text="(\(dashBoardElementValueForFn))"
        companyName.text=dashBoardCompanyName1
        // Do any additional setup after loading the view.
        
        
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        serverurl=UserDefaults.standard.object(forKey: "server_url") as! String
        
        
        
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        pid=UserDefaults.standard.object(forKey: "pid") as! String
        var url=serverurl+"Process/SalesInvoice?"+"PID=\(pid)&DB=\(db_name)&CompanyName=\(dashBoardCompanyName1)&FnYear=\(dashBoardElementValueForFn)" as! String
      
        url=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        let url1=NSURL(string:url) as! URL
        
        
        let req=NSURLRequest(url: url1 as! URL)
        
        
        webview1.loadRequest(req as URLRequest)
        
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBOutlet weak var print: UIButton!
    
    
    @IBOutlet weak var download: UIButton!
    

    @IBOutlet weak var share: UIButton!
    
    
    
    @IBAction func shareAction(_ sender: UIButton) {
        
    let bounds = webview1.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.webview1.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let shareItems:Array = [img!]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DispatchQueue.main.async {
            self.imageView1.isHidden=true
        }
    }
}
