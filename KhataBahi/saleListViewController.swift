//
//  saleListViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/20/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class saleListViewController: UIViewController,XMLParserDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
var allCondition=false
    var cashCondirion=false
    var creditCondition=false
    var db_name=String()
    var dashBoardElementValueForFn=String()
    var dashBoardCompanyName1=String()
    var selection1234:Int=0
       var serverurl=String()
    var startDate=String()
    var endDate=String()
    var searchResults=["Sting"]
    var TraType=String()
     var imageView:UIImageView!
    var test1=0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        
        
        
db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
       
        /////barChartSetup
        tableView.isHidden=true
        serverurl=UserDefaults.standard.object(forKey: "server_url") as! String
        
        dashBoardCompanyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        companyName.text=dashBoardCompanyName1
        fnyear.text="(\(dashBoardElementValueForFn))"
        // Do any additional setup after loading the view.
        createDatePicker()
        createDatePicker1()
        customername.delegate=self
         customername.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.separatorStyle = .none
        abc()
        
        all1.setBackgroundImage(UIImage(named:"select.png"), for: .normal)
        allCondition=true
        
        cash1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        credit1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        cashCondirion=false
        creditCondition=false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        searchResults=names
             tableView.reloadData()
        tableView.isHidden=false
   
        
        return true
    }
   /* func textFieldDidBeginEditing(_ textField: UITextField) {
        searchResults=names
         tableView.isHidden=false
        tableView.reloadData()
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldDidChange(_:UITextField){
       
       
        print(customername.text!)
      
        
           // tableView.isHidden=false
    searchResults=[]
    
       
   searchResults = names.filter({(coisas1:String) -> Bool in
    if (coisas1.lowercased()).contains(customername.text!) || (coisas1.contains(customername.text!))
     {
            //var asc=customername.text!.characters.prefix(0)
      //let stringMatch=coisas1.customMirror
        return true
    }
    else
     {
        
            return false
    }
 
            
        })
       /* print(dummysearchResults)
        for value in dummysearchResults
        {
            print(value)
            var count=customername.text?.count
            
            var firstLetter=String(value.suffix(count!))
            print(firstLetter)
            print(customername.text!)
            if firstLetter == customername.text
            {
                searchResults.append(value)
                tableView.reloadData()
                tableView.isHidden=false
            }
        }
        
        //
        //tableView.reloadData()
       // customername.resignFirstResponder()*/
        if customername.text! == nil || customername.text! == "" || customername.text!.isEmpty==true
        {
            searchResults=names
            tableView.reloadData()
        }
        else
        {
        tableView.reloadData()
        tableView.isHidden=false
        }
        
    }
    
    
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var fnyear: UILabel!
    
    
    @IBOutlet weak var customername: UITextField!
    
    
    @IBAction func close(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard") as! UIViewController
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBOutlet weak var datefield2: UITextField!
    @IBOutlet weak var all1: UIButton!
    
    @IBAction func all(_ sender: UIButton) {
        
        all1.setBackgroundImage(UIImage(named:"select.png"), for: .normal)
            allCondition=true
       
             cash1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        credit1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
      cashCondirion=false
        creditCondition=false
        
    }
    
    @IBOutlet weak var cash1: UIButton!
    @IBAction func cash(_ sender: UIButton) {
        cash1.setBackgroundImage(UIImage(named:"select.png"), for: .normal)
        cashCondirion=true
        
        all1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        credit1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        allCondition=false
        creditCondition=false
    }
    
    @IBOutlet weak var credit1: UIButton!
    
    
    @IBAction func credit(_ sender: UIButton) {
        credit1.setBackgroundImage(UIImage(named:"select.png"), for: .normal)
        creditCondition=true
        
        all1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        cash1.setBackgroundImage(UIImage(named:"unselect.png"), for: .normal)
        allCondition=false
        cashCondirion=false
    }
   
    
    @IBOutlet weak var datefield123: UITextField!
    
    
    
    
    var picker=UIDatePicker()
    func createDatePicker()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar11.setItems([done], animated: false)
       
        datefield123.inputAccessoryView=toolBar11
   datefield123.inputView=picker
        picker.datePickerMode = .date
        
    }
    @objc func donePressed()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
      //  dateForServer=formatter1.string(from: picker.date)
      //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
       datefield123.text=formatter.string(from: picker.date)
      //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    func createDatePicker1()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolBar11.setItems([done], animated: false)
        
        datefield2.inputAccessoryView=toolBar11
        datefield2.inputView=picker
        picker.datePickerMode = .date
        
    }
    @objc func donePressed1()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        //  dateForServer=formatter1.string(from: picker.date)
        //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        datefield2.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    func abc()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgers xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetLedgers></soap:Body></soap:Envelope>"
       let is_URL: String = serverurl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
       
        //let err: NSError?
    
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverurl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
       
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetLedgers", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
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
            
        })
        task.resume()
        
    }
    
    
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=searchResults[indexPath.row]

        return cell!
    }
    
    
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetLedgersResult" {
            elementValue = String()
            
        }
    }
    var names=[String]()
    var numbers=[String]()
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if test1==0
        {
            test1=1
        if elementValue != nil && selection1234 == 0{
            elementValue! += string
           var customersNames=elementValue?.components(separatedBy: "^")
            
            for value in customersNames!
            {
                var numbAndName=value.components(separatedBy: "~")
                names.append(numbAndName[1])
                numbers.append(numbAndName[0])
                
            }
            print(names,"customersName")
            searchResults=names
            abc1()
            
        }
        if elementValue != nil && selection1234 == 1{
            elementValue! = string
           print(elementValue,"start and end date")
            var datelist = elementValue?.components(separatedBy: "^")
            startDate=datelist![0]
            endDate=datelist![1]
            DispatchQueue.main.async {
                self.datefield123.text=self.startDate
                self.datefield2.text=self.endDate
                self.imageView.isHidden=true
            }
            
            
        }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetLedgersResult" {
            elementValue = String()
            selection1234=0
        }
        if elementName == "GetLedgersResult" {
            elementValue = String()
            selection1234=1
            test1=0
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        imageView.isHidden=true
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func abc1()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStartEndDteOfFnYear xmlns=\"http://tempuri.org/\"><FnYear>\(dashBoardElementValueForFn)</FnYear><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetStartEndDteOfFnYear></soap:Body></soap:Envelope>"
        let is_URL: String = serverurl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        
        
        
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverurl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetStartEndDteOfFnYear", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
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
            
        })
        task.resume()
        
    }
    

    
  /*  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        tableView.isHidden=false
        
        searchResults = names.filter({(coisas1:String) -> Bool in
            let stringMatch = coisas1.range(of: customername.text!)
            
            return stringMatch != nil
            
        })
        print(searchResults.description)
        
        tableView.reloadData()
        customername.resignFirstResponder()
        return true
    }
    */
    
   
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       tableView.isHidden=false
        
            searchResults = names.filter({(coisas1:String) -> Bool in
                let stringMatch = coisas1.range(of: customername.text!)
       
                return stringMatch != nil
                
            })
            print(searchResults.description)
            textField.resignFirstResponder()
            tableView.reloadData()
            return true
        
    }*/
    
    
    
    @IBAction func change(_ sender: UITextField) {
        searchResults=[]
        tableView.isHidden=false
        
        searchResults = names.filter({(coisas1:String) -> Bool in
            let stringMatch = coisas1.range(of: customername.text!)
            
            return stringMatch != nil
            
        })
        print(searchResults.description)
        
        tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customername.text=searchResults[indexPath.row]
        tableView.isHidden=true
        customername.resignFirstResponder()
    }
    
    
    @IBAction func getList(_ sender: UIButton) {
        
        if allCondition == true
        {
            TraType="All"
        }
        if cashCondirion ==  true
        {
            TraType="Cash"
        }
        if creditCondition ==  true
        {
            TraType="Credit"
        }
        
        UserDefaults.standard.set(TraType, forKey: "TraType")
        if customername.text != nil
        {
            UserDefaults.standard.set(customername.text, forKey: "Cname")
        }
        UserDefaults.standard.set(startDate, forKey: "startDate")
        
        
        UserDefaults.standard.set(endDate, forKey: "endDate")
    let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "saleListView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customername.resignFirstResponder()
        tableView.isHidden=true
        return true
        
    }
    
    
    
    
}
