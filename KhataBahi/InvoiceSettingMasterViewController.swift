//
//  InvoiceSettingMasterViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/30/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class InvoiceSettingMasterViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate {
    var selection=0
    var TraType=String()
    var check1=String()
    var check2=String()
    var check3=String()
    var check4=String()
    var check5=String()
    var check6=String()
    var check7=String()
    var check8=String()
    var check9=String()
    var check10=String()
    var check11=String()
    var check12=String()
    var check13=String()
    var check14=String()
    var check15=String()
    var imageView:UIImageView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tableviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView123.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=tableviewList[indexPath.row]
        return cell!
    }
    
    @IBOutlet weak var selcttype: UIButton!
    
    
    @IBAction func selectType1(_ sender: UIButton) {
        tableView123.isHidden=false
        tableView123.delegate=self
        tableView123.dataSource=self
        
    }
    @IBOutlet weak var autoInVoiceNoIsHidden: UIButton!
    @IBOutlet weak var calculateOnRateIsHidden: UIButton!
    @IBOutlet weak var calculateOnMrpIsHidden: UIButton!
    @IBOutlet weak var puchaseInvoiceTex: UITextField!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        
        
        puchaseInvoiceTex.text=tableviewList[indexPath.row]
        if puchaseInvoiceTex.text == "Purchase"
        {
            sameVoucherCheckImage.isHidden=true
            subscriptionUptoImage.isHidden=true
            subscriptionUptoIsHidden.isHidden=true
            sameVoucherCreditIsHidden.isHidden=true
            autoInvoiceImage.isHidden=false
            autoInVoiceNoIsHidden.isHidden=false
            calculateOnRateImage.isHidden=false
            calculateOnRateIsHidden.isHidden=false
            calculateOnMrpIsHidden.isHidden=false
            calculateonMRPimage.isHidden=false
        }
        else
        {sameVoucherCheckImage.isHidden=false
            subscriptionUptoImage.isHidden=false
            subscriptionUptoIsHidden.isHidden=false
            sameVoucherCreditIsHidden.isHidden=false
            
            
            
            
            autoInvoiceImage.isHidden=true
            autoInVoiceNoIsHidden.isHidden=true
            calculateOnRateImage.isHidden=true
            calculateOnRateIsHidden.isHidden=true
            calculateOnMrpIsHidden.isHidden=true
            calculateonMRPimage.isHidden=true
        }
        tableView123.isHidden=true
        TraType=puchaseInvoiceTex.text!
        getInvoiceSettings()
    }
    
    var showInvoiceChecked=false
    @IBOutlet weak var showInVoiceImage: UIImageView!
    @IBAction func ShowInVoiceAction(_ sender: UIButton) {
        if showInvoiceChecked == false
        {
            showInvoiceChecked=true
            showInVoiceImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showInvoiceChecked=false
            showInVoiceImage.image=UIImage(named: "Iunchecked")
        }
    }
    
    var showHSNChecked=false
    @IBOutlet weak var showHSNImage: UIImageView!
    @IBAction func showHSNAction(_ sender: UIButton) {
        
        if showHSNChecked == false
        {
            showHSNChecked=true
            showHSNImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showHSNChecked=false
            showHSNImage.image=UIImage(named: "Iunchecked")
        }
    }
    var showUOMChecked=false
    @IBOutlet weak var showUomImage: UIImageView!
    
    @IBAction func showUomInvoiceAction(_ sender: UIButton) {
        if showUOMChecked == false
        {
            showUOMChecked=true
            showUomImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showUOMChecked=false
            showUomImage.image=UIImage(named: "Iunchecked")
        }
    }
    var shoelessDiscountChecked=false
    @IBOutlet weak var showLessDiscountImage: UIImageView!
    
    @IBAction func showLessDiscountInVoiceAction(_ sender: UIButton) {
        if shoelessDiscountChecked == false
        {
            shoelessDiscountChecked=true
            showLessDiscountImage.image=UIImage(named: "IChecked")
        }
        else
        {
            shoelessDiscountChecked=false
            showLessDiscountImage.image=UIImage(named: "Iunchecked")
        }
    }
    var showTaxableChecke=false
    @IBOutlet weak var showTaxableImage: UIImageView!
    
    
    @IBAction func showTaxableValuew(_ sender: UIButton) {
        if showTaxableChecke == false
        {
            showTaxableChecke=true
            showTaxableImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showTaxableChecke=false
            showTaxableImage.image=UIImage(named: "Iunchecked")
        }
    }
    var showItemDescriptionChecked=false
    @IBOutlet weak var showItemDescriptionImage: UIImageView!
    
    @IBAction func showItemDescriptionInvoice(_ sender: UIButton) {
        if showItemDescriptionChecked == false
        {
            showItemDescriptionChecked=true
            showItemDescriptionImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showItemDescriptionChecked=false
            showItemDescriptionImage.image=UIImage(named: "Iunchecked")
        }
    }
    
    var roundOffChecked=false
    
    @IBOutlet weak var roundOffAdjustmentImage: UIImageView!
    
    @IBAction func roundOffAdjustmentAction(_ sender: UIButton) {
        if roundOffChecked == false
        {
            roundOffChecked=true
            roundOffAdjustmentImage.image=UIImage(named: "IChecked")
        }
        else
        {
            roundOffChecked=false
            roundOffAdjustmentImage.image=UIImage(named: "Iunchecked")
        }
    }
    
    var showCGSChecked=false
    @IBOutlet weak var showCGSTImage: UIImageView!
    
    @IBAction func showCGSTAction(_ sender: UIButton) {
        if showCGSChecked == false
        {
            showCGSChecked=true
            showCGSTImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showCGSChecked=false
            showCGSTImage.image=UIImage(named: "Iunchecked")
        }
    }
    
 
    
    var showSGSTChecked=false
    
    @IBOutlet weak var showSGSTImage: UIImageView!
    
    
    @IBAction func showSGSTAction(_ sender: UIButton) {
        if showSGSTChecked == false
        {
            showSGSTChecked=true
            showSGSTImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showSGSTChecked=false
            showSGSTImage.image=UIImage(named: "Iunchecked")
        }
    }
    var showIGSTChecked=false
    
    @IBOutlet weak var showIGSTImage: UIImageView!
    
    
    @IBAction func showIGSTACtion(_ sender: UIButton) {
        if showIGSTChecked == false
        {
            showIGSTChecked=true
            showIGSTImage.image=UIImage(named: "IChecked")
        }
        else
        {
            showIGSTChecked=false
            showIGSTImage.image=UIImage(named: "Iunchecked")
        }
    }
    var autoInvoiceChecked=false
    @IBOutlet weak var autoInvoiceImage: UIImageView!
    
    @IBAction func autoInvoiceNo(_ sender: UIButton) {
        if autoInvoiceChecked == false
        {
            autoInvoiceChecked=true
            autoInvoiceImage.image=UIImage(named: "IChecked")
        }
        else
        {
            autoInvoiceChecked=false
            autoInvoiceImage.image=UIImage(named: "Iunchecked")
        }
    }
    
    var subscriptionUptoCheck=false
    
    @IBOutlet weak var subscriptionUptoImage: UIImageView!
    @IBAction func SubscriptionUpto(_ sender: UIButton) {
        if subscriptionUptoCheck == false
        {
            subscriptionUptoCheck=true
            subscriptionUptoImage.image=UIImage(named: "IChecked")
        }
        else
        {
            subscriptionUptoCheck=false
            subscriptionUptoImage.image=UIImage(named: "Iunchecked")
        }
    }
    var sameVoucherSeriesCheck=false
    
    @IBOutlet weak var sameVoucherCreditIsHidden: UIButton!
    @IBOutlet weak var subscriptionUptoIsHidden: UIButton!
    @IBOutlet weak var sameVoucherCheckImage: UIImageView!
    
    @IBAction func sameVoucherSeries(_ sender: UIButton) {
        if sameVoucherSeriesCheck == false
        {
            sameVoucherSeriesCheck=true
            sameVoucherCheckImage.image=UIImage(named: "IChecked")
        }
        else
        {
            sameVoucherSeriesCheck=false
            sameVoucherCheckImage.image=UIImage(named: "Iunchecked")
        }
    }
    var calculateOnMrpChecked=false
    @IBOutlet weak var calculateonMRPimage: UIImageView!
    @IBAction func calculateMRpAction(_ sender: UIButton) {
        if calculateOnMrpChecked == false
        {
            calculateOnMrpChecked=true
            calculateonMRPimage.image=UIImage(named: "IChecked")
            calculateOnRateImage.image=UIImage(named: "Iunchecked")
        }
        else
        {
            calculateOnMrpChecked=false
            calculateonMRPimage.image=UIImage(named: "Iunchecked")
            calculateOnRateImage.image=UIImage(named: "IChecked")
        }
    }
    var calculateOnRateChecked=false
    @IBOutlet weak var calculateOnRateImage: UIImageView!
    
    @IBAction func calculateonRateAction(_ sender: UIButton) {
        if calculateOnMrpChecked == true
        {
            calculateOnMrpChecked=false
            calculateonMRPimage.image=UIImage(named: "Iunchecked")
            calculateOnRateImage.image=UIImage(named: "IChecked")
        }
        else
        {
            calculateOnMrpChecked=true
           
            
            calculateonMRPimage.image=UIImage(named: "IChecked")
            calculateOnRateImage.image=UIImage(named: "Iunchecked")
        }
    }
    
    var shareTotalQuantityChecked=false
    
    @IBOutlet weak var sharetotalQuantityImage: UIImageView!
    
    @IBAction func shareTotalQuantityAction(_ sender: UIButton) {
        if shareTotalQuantityChecked == false
        {
            shareTotalQuantityChecked=true
            sharetotalQuantityImage.image=UIImage(named: "IChecked")
        }
        else
        {
            shareTotalQuantityChecked=false
            sharetotalQuantityImage.image=UIImage(named: "Iunchecked")
        }
    }
    
    
    
    
    
    var dashBoardElementValueForFn=String()
    var companyNameText=String()
    var tableviewList=["Purchase","Sale"]
    var serverUrl=String()
    var db_name=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
       sameVoucherCheckImage.isHidden=true
        subscriptionUptoImage.isHidden=true
        subscriptionUptoIsHidden.isHidden=true
        sameVoucherCreditIsHidden.isHidden=true
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        fnyear1234.text="(\(dashBoardElementValueForFn))"
        /////barChartSetup
         db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        companyNameText=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        companyName1234.text=companyNameText
        tableView123.isHidden=true
        tableView123.separatorStyle = .none
        tableView123.delegate=self
        tableView123.dataSource=self
        // Do any additional setup after loading the view.
        
        a.clipsToBounds=true
        a.layer.cornerRadius=8
        
        b.clipsToBounds=true
        b.layer.cornerRadius=8
        
        c.clipsToBounds=true
        c.layer.cornerRadius=8
        
        d.clipsToBounds=true
        d.layer.cornerRadius=8
        
        e.clipsToBounds=true
        e.layer.cornerRadius=8
        
        f.clipsToBounds=true
        f.layer.cornerRadius=8
        
        g.clipsToBounds=true
        g.layer.cornerRadius=8
        h.clipsToBounds=true
        h.layer.cornerRadius=8
        
        i.clipsToBounds=true
        i.layer.cornerRadius=8
        
        
        j.clipsToBounds=true
        j.layer.cornerRadius=8
        
        
        k.clipsToBounds=true
        k.layer.cornerRadius=8
        
        l.clipsToBounds=true
        l.layer.cornerRadius=8
        
        m.clipsToBounds=true
        m.layer.cornerRadius=8
        
        n.clipsToBounds=true
        n.layer.cornerRadius=8
        
        aa.clipsToBounds=true
        aa.layer.cornerRadius=8
        aa.layer.borderWidth=0.5
        aa.layer.borderColor=UIColor.lightGray.cgColor
        
        
        bb.clipsToBounds=true
        bb.layer.cornerRadius=8
        bb.layer.borderWidth=0.5
        bb.layer.borderColor=UIColor.lightGray.cgColor
        
        cc.clipsToBounds=true
        cc.layer.cornerRadius=8
        cc.layer.borderWidth=0.5
        cc.layer.borderColor=UIColor.lightGray.cgColor
        
        dd.clipsToBounds=true
        dd.layer.cornerRadius=8
        dd.layer.borderWidth=0.5
        dd.layer.borderColor=UIColor.lightGray.cgColor
        
        ee.clipsToBounds=true
        ee.layer.cornerRadius=8
        ee.layer.borderWidth=0.5
        ee.layer.borderColor=UIColor.lightGray.cgColor
        
        ff.clipsToBounds=true
        ff.layer.cornerRadius=8
        ff.layer.borderWidth=0.5
        ff.layer.borderColor=UIColor.lightGray.cgColor
        
        gg.clipsToBounds=true
        gg.layer.cornerRadius=8
        gg.layer.borderWidth=0.5
        gg.layer.borderColor=UIColor.lightGray.cgColor
        
        hh.clipsToBounds=true
        hh.layer.cornerRadius=8
        hh.layer.borderWidth=0.5
        hh.layer.borderColor=UIColor.lightGray.cgColor
        
        
        ii.clipsToBounds=true
        ii.layer.cornerRadius=8
        ii.layer.borderWidth=0.5
        ii.layer.borderColor=UIColor.lightGray.cgColor
        
        jj.clipsToBounds=true
        jj.layer.cornerRadius=8
        jj.layer.borderWidth=0.5
        jj.layer.borderColor=UIColor.lightGray.cgColor
        
        kk.clipsToBounds=true
        kk.layer.cornerRadius=8
        kk.layer.borderWidth=0.5
        kk.layer.borderColor=UIColor.lightGray.cgColor
        
        
        ll.clipsToBounds=true
        ll.layer.cornerRadius=8
        ll.layer.borderWidth=0.5
        ll.layer.borderColor=UIColor.lightGray.cgColor
        mm.clipsToBounds=true
        mm.layer.cornerRadius=8
        mm.layer.borderWidth=0.5
        mm.layer.borderColor=UIColor.lightGray.cgColor
        nn.clipsToBounds=true
        nn.layer.cornerRadius=8
        nn.layer.borderWidth=0.5
        nn.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        
        oo.clipsToBounds=true
        oo.layer.cornerRadius=8
        
        oo.layer.borderWidth=0.5
        oo.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        
        
        TraType="Purchase"
        getInvoiceSettings()
    }

    @IBOutlet weak var n: UIButton!
    @IBOutlet weak var m: UIButton!
    @IBOutlet weak var l: UIButton!
    @IBOutlet weak var k: UIButton!
    @IBOutlet weak var j: UIButton!
    @IBOutlet weak var i: UIButton!
    @IBOutlet weak var h: UIButton!
    @IBOutlet weak var g: UIButton!
    
    @IBOutlet weak var f: UIButton!
    @IBOutlet weak var a: UIButton!
    
    @IBOutlet weak var b: UIButton!
    
    @IBOutlet weak var e: UIButton!
    
    @IBOutlet weak var d: UIButton!
    @IBOutlet weak var c: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var oo: UIView!
    @IBOutlet weak var nn: UIView!
    @IBOutlet weak var mm: UIView!
    @IBOutlet weak var ll: UIView!
    
    @IBOutlet weak var kk: UIView!
    @IBOutlet weak var jj: UIView!
    @IBOutlet weak var ii: UIView!
    @IBOutlet weak var hh: UIView!
    @IBOutlet weak var gg: UIView!
    @IBOutlet weak var ff: UIView!
    
    @IBOutlet weak var ee: UIView!
    @IBOutlet weak var aa: UIView!
    
    @IBOutlet weak var bb: UIView!
    
    @IBOutlet weak var cc: UIView!
    
    @IBOutlet weak var dd: UIView!
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBOutlet weak var tableView123: UITableView!
    
    @IBOutlet weak var companyName1234: UILabel!
    
    @IBOutlet weak var fnyear1234: UILabel!
  func saveInvoiceSettngs(){
    print(puchaseInvoiceTex.text)
    if puchaseInvoiceTex.text! == " Purchase"
    {TraType="Purchase"
        check12="0"
        check13="0"
    if showInvoiceChecked ==  true
    {
        check1="1"
        }
        else
    {
        check1="0"
        }
        if showHSNChecked ==  true
        {
            check2="1"
        }
        else
        {
            check2="0"
        }
        if showUOMChecked ==  true
        {
            check3="1"
        }
        else
        {
            check3="0"
        }
        if shoelessDiscountChecked ==  true
        {
            check4="1"
        }
        else
        {
            check4="0"
        }
        if showTaxableChecke ==  true
        {
            check5="1"
        }
        else
        {
            check5="0"
        }
        if showItemDescriptionChecked ==  true
        {
            check6="1"
        }
        else
        {
            check6="0"
        }
        if roundOffChecked ==  true
        {
            check7="1"
        }
        else
        {
            check7="0"
        }
        if showCGSChecked ==  true
        {
            check8="1"
        }
        else
        {
            check8="0"
        }
        if showSGSTChecked ==  true
        {
            check9="1"
        }
        else
        {
            check9="0"
        }
        if showIGSTChecked ==  true
        {
            check10="1"
        }
        else
        {
            check10="0"
        }
        if autoInvoiceChecked ==  true
        {
            check11="1"
        }
        else
        {
            check11="0"
        }
        if calculateOnMrpChecked ==  true
        {
            check14="1"
        }
        else
        {
            check14="0"
        }
        if shareTotalQuantityChecked ==  true
        {
            check15="1"
        }
        else
        {
            check15="0"
        }
    }
   
    if puchaseInvoiceTex.text! == "Sale"
    {TraType="Sale"
        check11="0"
        check14="0"
        if showInvoiceChecked ==  true
        {
            check1="1"
        }
        else
        {
            check1="0"
        }
        if showHSNChecked ==  true
        {
            check2="1"
        }
        else
        {
            check2="0"
        }
        if showUOMChecked ==  true
        {
            check3="1"
        }
        else
        {
            check3="0"
        }
        if shoelessDiscountChecked ==  true
        {
            check4="1"
        }
        else
        {
            check4="0"
        }
        if showTaxableChecke ==  true
        {
            check5="1"
        }
        else
        {
            check5="0"
        }
        if showItemDescriptionChecked ==  true
        {
            check6="1"
        }
        else
        {
            check6="0"
        }
        if roundOffChecked ==  true
        {
            check7="1"
        }
        else
        {
            check7="0"
        }
        if showCGSChecked ==  true
        {
            check8="1"
        }
        else
        {
            check8="0"
        }
        if showSGSTChecked ==  true
        {
            check9="1"
        }
        else
        {
            check9="0"
        }
        if showIGSTChecked ==  true
        {
            check10="1"
        }
        else
        {
            check10="0"
        }
        if subscriptionUptoCheck ==  true
        {
            check12="1"
        }
        else
        {
            check12="0"
        }
        if sameVoucherSeriesCheck ==  true
        {
            check13="1"
        }
        else
        {
            check13="0"
        }
        if shareTotalQuantityChecked ==  true
        {
            check15="1"
        }
        else
        {
            check15="0"
        }
    }
    
    
    
    var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SaveInvoiceSettings xmlns=\"http://tempuri.org/\"><chk1>\(check1)</chk1><chk2>\(check2)</chk2><chk3>\(check3)</chk3><chk4>\(check4)</chk4><chk5>\(check5)</chk5><chk6>\(check6)</chk6><chk7>\(check7)</chk7><chk8>\(check8)</chk8><chk9>\(check9)</chk9><chk10>\(check10)</chk10><chk11>\(check11)</chk11><chk12>\(check12)</chk12><chk13>\(check13)</chk13><chk14>\(check14)</chk14><chk15>\(check15)</chk15><type>\(TraType)</type><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></SaveInvoiceSettings></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/SaveInvoiceSettings", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if response != nil
            {
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                
                let XMLparser = XMLParser(data: data!)
                XMLparser.delegate = self
                XMLparser.parse()
                //XMLparser.shouldResolveExternalEntities = true
                if error != nil
                {
                    print("Error: " + error!.localizedDescription)
                    
                }
            }
        })
        task.resume()
    }
    
 
    
    
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetInvoiceSettingsResult" {
            elementValue = String()
            selection=0
            print(elementValue)
        }
        if elementName == "SaveInvoiceSettingsResult" {
            elementValue = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection == 0 {
            elementValue! = string
             print(elementValue)
            var statusList=elementValue?.components(separatedBy: "^")
            if statusList!.count==15 && TraType == "Purchase" && elementValue! != "^^^^^^^^^^^^^^"
            {DispatchQueue.main.async {
                self.imageView.isHidden=true            }
                
                
            
                DispatchQueue.main.async {
                    
                
                if statusList![0]=="0"
            {
                self.showInVoiceImage.image=UIImage(named: "Iunchecked")
                self.showInvoiceChecked=false
            }
            else
            {
                 self.showInVoiceImage.image=UIImage(named: "IChecked")
                self.showInvoiceChecked=true
                }
                if statusList![1]=="0"
                {
                    self.showHSNImage.image=UIImage(named: "Iunchecked")
                    self.showHSNChecked=false
                }
                else
                {
                    self.showHSNImage.image=UIImage(named: "IChecked")
                    self.showHSNChecked=true
                }
                if statusList![2]=="0"
                {
                    self.showUomImage.image=UIImage(named: "Iunchecked")
                    self.showUOMChecked=false
                }
                else
                {
                    self.showUomImage.image=UIImage(named: "IChecked")
                    self.showUOMChecked=true
                }
                if statusList![3]=="0"
                {
                    self.showLessDiscountImage.image=UIImage(named: "Iunchecked")
                    self.shoelessDiscountChecked=false
                }
                else
                {
                    self.showLessDiscountImage.image=UIImage(named: "IChecked")
                    
                    self.shoelessDiscountChecked=true
                }
                if statusList![4]=="0"
                {
                    self.showTaxableImage.image=UIImage(named: "Iunchecked")
                    self.showTaxableChecke=false
                }
                else
                {
                    self.showTaxableImage.image=UIImage(named: "IChecked")
                    self.showTaxableChecke=true
                    }
                if statusList![5]=="0"
                {
                    self.showItemDescriptionImage.image=UIImage(named: "Iunchecked")
                    self.showItemDescriptionChecked=false
                }
                else
                {
                    self.showItemDescriptionImage.image=UIImage(named: "IChecked")
                    self.showItemDescriptionChecked=true
                }
                    
                    
                if statusList![6]=="0"
                {
                    self.roundOffAdjustmentImage.image=UIImage(named: "Iunchecked")
                    self.roundOffChecked=false
                }
                else
                {
                    self.roundOffAdjustmentImage.image=UIImage(named: "IChecked")
                    self.roundOffChecked=true
                }
                if statusList![7]=="0"
                {
                    self.showCGSTImage.image=UIImage(named: "Iunchecked")
                    self.showCGSChecked=false
                }
                else
                {
                    self.showCGSTImage.image=UIImage(named: "IChecked")
                    self.showCGSChecked=true
                }
                if statusList![8]=="0"
                {
                    self.showSGSTImage.image=UIImage(named: "Iunchecked")
                    self.showSGSTChecked=false
                }
                else
                {
                    self.showSGSTImage.image=UIImage(named: "IChecked")
                    self.showSGSTChecked=true
                }
                if statusList![9]=="0"
                {
                    self.showIGSTImage.image=UIImage(named: "Iunchecked")
                    self.showIGSTChecked=false
                }
                else
                {
                    self.showIGSTImage.image=UIImage(named: "IChecked")
                    self.showIGSTChecked=true
                }
                if statusList![10]=="0"
                {
                    self.autoInvoiceImage.image=UIImage(named: "Iunchecked")
                    self.autoInvoiceChecked=false
                }
                else
                {
                    self.autoInvoiceImage.image=UIImage(named: "IChecked")
                    self.autoInvoiceChecked=true
                }
                if statusList![13]=="0"
                {
                    self.calculateonMRPimage.image=UIImage(named: "Iunchecked")
                    self.calculateOnRateImage.image=UIImage(named: "IChecked")
                    self.calculateOnMrpChecked=false
                    
                }
                else
                {self.calculateOnRateImage.image=UIImage(named: "Iunchecked")
                    self.calculateonMRPimage.image=UIImage(named: "IChecked")
                    self.calculateOnMrpChecked=true
                    
                }
               
                if statusList![14]=="0"
                {
                    self.sharetotalQuantityImage.image=UIImage(named: "Iunchecked")
                    self.shareTotalQuantityChecked=false
                }
                else
                {
                    self.sharetotalQuantityImage.image=UIImage(named: "IChecked")
                    self.shareTotalQuantityChecked=true
                }
                }
            }
           
            DispatchQueue.main.async {
                self.imageView.isHidden=true            }
            if statusList!.count==15 && TraType == "Sale" && elementValue! != "^^^^^^^^^^^^^^"
            {DispatchQueue.main.async {
                self.imageView.isHidden=true            }
                
                DispatchQueue.main.async {
                    
                    
                    if statusList![0]=="0"
                    {
                        self.showInVoiceImage.image=UIImage(named: "Iunchecked")
                        self.showInvoiceChecked=false
                    }
                    else
                    {
                        self.showInVoiceImage.image=UIImage(named: "IChecked")
                        self.showInvoiceChecked=true
                    }
                    if statusList![1]=="0"
                    {
                        self.showHSNImage.image=UIImage(named: "Iunchecked")
                        self.showHSNChecked=false
                    }
                    else
                    {
                        self.showHSNImage.image=UIImage(named: "IChecked")
                        self.showHSNChecked=true
                    }
                    if statusList![2]=="0"
                    {
                        self.showUomImage.image=UIImage(named: "Iunchecked")
                        self.showUOMChecked=false
                    }
                    else
                    {
                        self.showUomImage.image=UIImage(named: "IChecked")
                        self.showUOMChecked=true
                    }
                    if statusList![3]=="0"
                    {
                        self.showLessDiscountImage.image=UIImage(named: "Iunchecked")
                        self.shoelessDiscountChecked=false
                    }
                    else
                    {
                        self.showLessDiscountImage.image=UIImage(named: "IChecked")
                        self.shoelessDiscountChecked=true
                    }
                    if statusList![4]=="0"
                    {
                        self.showTaxableImage.image=UIImage(named: "Iunchecked")
                        self.showTaxableChecke=false
                    }
                    else
                    {
                        self.showTaxableImage.image=UIImage(named: "IChecked")
                        self.showTaxableChecke=true
                    }
                    if statusList![5]=="0"
                    {
                        self.showItemDescriptionImage.image=UIImage(named: "Iunchecked")
                        self.showItemDescriptionChecked=false
                    }
                    else
                    {
                        self.showItemDescriptionImage.image=UIImage(named: "IChecked")
                        self.showItemDescriptionChecked=true
                    }
                    if statusList![6]=="0"
                    {
                        self.roundOffAdjustmentImage.image=UIImage(named: "Iunchecked")
                        self.roundOffChecked=false
                    }
                    else
                    {
                        self.roundOffAdjustmentImage.image=UIImage(named: "IChecked")
                        self.roundOffChecked=true
                    }
                    if statusList![7]=="0"
                    {
                        self.showCGSTImage.image=UIImage(named: "Iunchecked")
                        self.showCGSChecked=false
                    }
                    else
                    {
                        self.showCGSTImage.image=UIImage(named: "IChecked")
                        self.showCGSChecked=true
                    }
                    if statusList![8]=="0"
                    {
                        self.showSGSTImage.image=UIImage(named: "Iunchecked")
                        self.showSGSTChecked=false
                    }
                    else
                    {
                        self.showSGSTImage.image=UIImage(named: "IChecked")
                        self.showSGSTChecked=true
                    }
                    if statusList![9]=="0"
                    {
                        self.showIGSTImage.image=UIImage(named: "Iunchecked")
                        self.showIGSTChecked=false
                    }
                    else
                    {
                        self.showIGSTImage.image=UIImage(named: "IChecked")
                        self.showIGSTChecked=true
                    }
                    
                    if statusList![11]=="0"
                    {
                        self.subscriptionUptoImage.image=UIImage(named: "Iunchecked")
                        self.subscriptionUptoCheck=false
                        
                    }
                    else
                    {self.subscriptionUptoImage.image=UIImage(named: "IChecked")
                        self.subscriptionUptoCheck=true
                        
                        
                    }
                    if statusList![12]=="0"
                    {
                        self.sameVoucherCheckImage.image=UIImage(named: "Iunchecked")
                        self.sameVoucherSeriesCheck=false
                        
                    }
                    else
                    {self.sameVoucherCheckImage.image=UIImage(named: "IChecked")
                        self.sameVoucherSeriesCheck=true
                        
                    }
                    if statusList![14]=="0"
                    {
                        self.sharetotalQuantityImage.image=UIImage(named: "Iunchecked")
                        self.shareTotalQuantityChecked=false
                    }
                    else
                    {
                        self.sharetotalQuantityImage.image=UIImage(named: "IChecked")
                        self.shareTotalQuantityChecked=true
                    }
                }
                
            }
            DispatchQueue.main.async {
                self.imageView.isHidden=true            }
         /*   else
            {
                self.showInvoiceChecked=false
                self.showHSNChecked=false
                self.showUOMChecked=false
                self.shoelessDiscountChecked=false
                self.showTaxableChecke=false
                self.showItemDescriptionChecked=false
                self.roundOffChecked=false
                self.showCGSChecked=false
                self.showSGSTChecked=false
                self.showIGSTChecked=false
                self.autoInvoiceChecked=false
                self.calculateOnMrpChecked=false
                self.shareTotalQuantityChecked=false
                
            }*/
            
        }
        if elementValue != nil && selection == 1
        {
            DispatchQueue.main.async {
            self.imageView.isHidden=true
            }
            
            
        
            elementValue! = string
           
           print(elementValue)
            DispatchQueue.main.async {
                if self.elementValue! == "1"
                { var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
Invoice Settings are
Saved successfully.....
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
Invoice Settings are
not Saved! Please try
Again later.........
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetInvoiceSettingsResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "SaveInvoiceSettingsResult" {
            elementValue = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    func getInvoiceSettings(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetInvoiceSettings xmlns=\"http://tempuri.org/\"><InvoiceType>\(TraType)</InvoiceType><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetInvoiceSettings></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetInvoiceSettings", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if response != nil
            {
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                
                let XMLparser = XMLParser(data: data!)
                XMLparser.delegate = self
                XMLparser.parse()
                //XMLparser.shouldResolveExternalEntities = true
                if error != nil
                {
                    print("Error: " + error!.localizedDescription)
                    
                }
            }
        })
        task.resume()
    }
    
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        saveInvoiceSettngs()
    }
}
