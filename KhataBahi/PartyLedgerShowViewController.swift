//
//  PartyLedgerShowViewController.swift
//  KhataBahi
//
//  Created by Narayan on 6/12/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class PartyLedgerShowViewController: UIViewController,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var PartyLedgerName: UILabel!
    
    @IBOutlet weak var PartyLedgerDuration: UILabel!
    
    @IBOutlet weak var openingBalanceDebit: UILabel!
    
    @IBOutlet weak var OpeningBalanceCredit: UILabel!
    
    
    @IBOutlet weak var CurrentTotalDebit: UILabel!
    
    @IBOutlet weak var CurrentTotalCredit: UILabel!
    
    @IBOutlet weak var ClosingBalanceDebit: UILabel!
    
    @IBOutlet weak var ClosingBalanceCredit: UILabel!
    
    @IBOutlet weak var companyname: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var border1: UIView!
    @IBOutlet weak var border2: UIView!
    @IBOutlet weak var fnYear: UILabel!
    var imageView:UIImageView!
    @IBOutlet weak var companyName1: UILabel!
    var pdf123=String()
    var a=0
    var picker=UIDatePicker()
    var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    var fnYear1=String()
    var dashBoardCompanyName123=String()
    var db_name=String()
    var server_url=String()
    var selection=0
    var startDate=String()
    var endDate=String()
    var srno=String()
    var GetPartyLedgerTransactionsResult=String()
    
    
    var cashId=[String]()
    var cashNames=[String]()
    var cashAmounts=[String]()
    var cashStatus=String()
    var searchResults=[String]()
    var GetLedgersCASHResult=String()
    
    var dateList=[String]()
    var particularList=[String]()
    var debitList=[String]()
    var creditList=[String]()
    var voucherList=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        border1.layer.borderWidth=0.5
        border1.layer.borderColor=UIColor.gray.cgColor
        border2.layer.borderWidth=0.5
        border2.layer.borderColor=UIColor.gray.cgColor
    let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        self.view.isUserInteractionEnabled=false
        tableView.separatorStyle = .none
        
        
    }
    
    
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        fnYear1=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        dashBoardCompanyName123=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        server_url=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        
        companyName1.text=dashBoardCompanyName123
        fnYear.text="(\(fnYear1))"
        
        let dummy:String=UserDefaults.standard.object(forKey: "Info") as! String
        let dummy1:[String]=dummy.components(separatedBy: ",")
        if dummy1.count==4
        {
            PartyLedgerName.text=dummy1[0]
            srno=dummy1[1]
            PartyLedgerDuration.text="\(dummy1[2]) to \(dummy1[3])"
            startDate=dummy1[2]
            endDate=dummy1[3]
            abc1()
        }
        
       // abc1()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var dismiss: UIButton!
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        dismiss(animated: false, completion: nil)
    }
    
   
    func abc1()
    {selection=0
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPartyLedgerTransactions xmlns=\"http://tempuri.org/\"><ledger_id>\(srno)</ledger_id><dte_from>\(startDate)</dte_from><dte_to>\(endDate)</dte_to><CompanyName>\(dashBoardCompanyName123)</CompanyName><FnYear>\(fnYear1)</FnYear><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetPartyLedgerTransactions></soap:Body></soap:Envelope>"
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetPartyLedgerTransactions", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            if data != nil
            {
                DispatchQueue.main.async {
                    print(self.GetPartyLedgerTransactionsResult,"12/06/18")
                    let dummy=self.GetPartyLedgerTransactionsResult.components(separatedBy: "@")
                    if dummy.count==2
                    {
                        let dummyString=dummy[0]
                        let dummyStringArray:[String]=dummyString.components(separatedBy: "^")
                        let PartyLedgerListString=dummy[1]
                        let dummyPartyLedgerListArray:[String]=PartyLedgerListString.components(separatedBy: "^")
                        if dummyPartyLedgerListArray.count != 0
                        {
                            for value in dummyPartyLedgerListArray
                            {
                                let dummyPartyListArrayList:[String]=value.components(separatedBy: ",")
                                print(dummyPartyListArrayList,"12/06/18dummyPartyLedgerListArray")
                                  print(dummyPartyListArrayList.count,"12/06/18dummyPartyLedgerListArraycount")
                                if dummyPartyListArrayList.count==5
                                {self.dateList.append(dummyPartyListArrayList[0])
                                    self.particularList.append(dummyPartyListArrayList[1])
                                    self.voucherList.append(dummyPartyListArrayList[2])
                                    self.debitList.append(dummyPartyListArrayList[3])
                                    self.creditList.append(dummyPartyListArrayList[4])
                                    
                                }
                                
                            }
                            self.tableView.reloadData()
                        }
                        
                        if dummyStringArray.count==3
                        {
                              var openigBalanceString=dummyStringArray[0]
                            var CurrentTotalString=dummyStringArray[1]
                            var ClosingBalanceString=dummyStringArray[2]
                            var openigBalanceArray:[String]=openigBalanceString.components(separatedBy: ",")
                            var CurrentTotalArray:[String]=CurrentTotalString.components(separatedBy: ",")
                            var ClosingBalanceArray:[String]=ClosingBalanceString.components(separatedBy: ",")
                            if openigBalanceArray.count==2
                            {self.openingBalanceDebit.text=openigBalanceArray[0]
                                self.OpeningBalanceCredit.text=openigBalanceArray[1]
                                
                            }
                            if CurrentTotalArray.count==2
                            {self.CurrentTotalDebit.text=CurrentTotalArray[0]
                                self.CurrentTotalCredit.text=CurrentTotalArray[1]
                                
                            }
                            if ClosingBalanceArray.count==2
                            {self.ClosingBalanceDebit.text=ClosingBalanceArray[0]
                                self.ClosingBalanceCredit.text=ClosingBalanceArray[1]
                                
                            }
                        }
                        
                    }
                    self.imageView.isHidden=true
                    self.view.isUserInteractionEnabled=true
                }
            }
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
        
    }
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetPartyLedgerTransactionsResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "GetLedgersOTHERResult" {
            elementValue = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection==0{
            elementValue! += string
            
            GetPartyLedgerTransactionsResult=elementValue!
            
        }
        if elementValue != nil && selection==1{
            elementValue! += string
            
            GetLedgersCASHResult=elementValue!
            
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetPartyLedgerTransactionsResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "GetLedgersOTHERResult" {
            elementValue = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    func GetLedgersCASH()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgersOTHER xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName123)</CompanyName><DB>\(db_name)</DB><FnYear>\(fnYear1)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetLedgersOTHER></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetLedgersOTHER", forHTTPHeaderField: "SOAPAction")
        
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
            DispatchQueue.main.async {
                
                var dummyList=self.GetLedgersCASHResult.components(separatedBy:"^")
            }
        })
        task.resume()
        
    }
    
    // Table View Declaration
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell=tableView.dequeueReusableCell(withIdentifier: "cell") as! PartyLedgerShowTableViewCell
        cell.date.text=dateList[indexPath.row]
        cell.particular.text=particularList[indexPath.row]
        cell.debit.text=debitList[indexPath.row]
        cell.credit.text=creditList[indexPath.row]
        return cell
        
    }
    
    
    
}
