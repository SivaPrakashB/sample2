//
//  JournalVoucherNewPage.swift
//  KhataBahi
//
//  Created by Apple on 08/08/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class JournalVoucherNewPage: UIViewController,UITextFieldDelegate,XMLParserDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==journalVoucherTableView
        {
        return TypeList.count
        }
        else if tableView==ledgersTableView
        {
            return searchResults.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView==journalVoucherTableView
        {
       let cell=journalVoucherTableView.dequeueReusableCell(withIdentifier: "cell") as! JournalVoucherTableViewCell
        cell.type.text=TypeList[indexPath.row]
        cell.particulars.text=ledgersList[indexPath.row]
        if DebitList[indexPath.row] != 0
        {
            cell.debit.text="\(DebitList[indexPath.row])"
            cell.Credit.text=""
        }
        else
        {
             cell.Credit.text="\(CreditLIst[indexPath.row])"
            cell.debit.text=""
        }
            return cell
        }
        else
        {
            let cell=ledgersTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=searchResults[indexPath.row]
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView==ledgersTableView
        {
        let cell=ledgersTableView.cellForRow(at: indexPath) as! UITableViewCell
        let label:String=(cell.textLabel?.text)!
            SelectLedger.text=label
            ledgersTableView.isHidden=true
       byValue=label
        for i in 0..<cashNames.count
        {
            if cashNames[i] == label
            {byAmount=self.cashAmounts[i]
                ByID=self.cashId[i]
               
            }
        }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if tableView==journalVoucherTableView
        {
            return true
        }
        else
        {
        return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            TypeList.remove(at: indexPath.row)
            ledgersList.remove(at: indexPath.row)
            if DebitList[indexPath.row] != 0
            {
                TotalDebitAmount=TotalDebitAmount-DebitList[indexPath.row]
                totalDebit.text="\(TotalDebitAmount)"
            }
            else
            {
               TotalCreditAmount=TotalCreditAmount-CreditLIst[indexPath.row]
                totalCredit.text="\(TotalCreditAmount)"
            }
            DebitList.remove(at: indexPath.row)
            CreditLIst.remove(at: indexPath.row)
            
           
        }
         print(TypeList,"Typelist")
         print(ledgersList,"ledgersList")
         print(DebitList,"DebitList")
         print(CreditLIst,"CreditLIst")
   journalVoucherTableView.reloadData()
        
    }
    
    var posName=String()
    var posSRNO=String()
    var serverUrl=String()
    var db_name=String()
    var dashBoardElementValueForFn=String()
    var dashBoardCompanyName1=String()
    var loginUsername123=String()
    var CashPaymentSubmitResult=String()
    var CashPaymentSubmitFinalResult=String()
    var selection:Int=0
    var GetStartEndDteOfFnYearResult=String()
    
    var result=String()
    var result1=String()
    var imageview=UIImageView()
    var BillByBillStatus=String()
    
    var endDate=String()
    var startDate=String()
    var activeTextField=UITextField()
    var byValue=String()
    var byAmount=String()
    var ByID=String()
    
    var TypeList=[String]()
    var ledgersList=[String]()
    var DebitList=[Int]()
    var CreditLIst=[Int]()
    var TotalDebitAmount=0
    var TotalCreditAmount=0
    var GetLedgersCASHResult=String()
    
    var cashId=[String]()
    var cashNames=[String]()
    var cashAmounts=[String]()
    var cashStatus=String()
    var searchResults=[String]()
    
    @IBOutlet weak var remark: UITextField!
    @IBOutlet weak var datefield123: UITextField!
    @IBOutlet weak var drOrCrButton: UIButton!
    
    @IBOutlet weak var enterAmount: UITextField!
    
    @IBOutlet weak var SelectLedger: UITextField!
    
    @IBOutlet weak var journalVoucherTableView: UITableView!

    @IBOutlet weak var posNameLabel: UITextField!
    
    @IBOutlet weak var voucherNumber: UILabel!
    
    @IBOutlet weak var totalCredit: UILabel!
    @IBOutlet weak var totalDebit: UILabel!
    
    @IBOutlet weak var ledgersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         SelectLedger.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        journalVoucherTableView.separatorStyle = .none
        ledgersTableView.isHidden=true
        ledgersTableView.delegate=self
        ledgersTableView.dataSource=self
        ledgersTableView.separatorStyle = .none
        
        
        journalVoucherTableView.delegate=self
        journalVoucherTableView.dataSource=self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        SelectLedger.becomeFirstResponder()
       /* let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(PaymentcashViewController.handleTap1(_:)))
        tapGR1.delegate = self
        tapGR1.numberOfTapsRequired = 1
        SelectLedger.addGestureRecognizer(tapGR1)
        if UserDefaults.standard.object(forKey: "byValue") != nil
        {   byValue=UserDefaults.standard.object(forKey: "byValue") as! String
            byAmount=UserDefaults.standard.object(forKey: "byAmount") as! String
            ByID=UserDefaults.standard.object(forKey: "ByID") as! String
            
            print(byAmount,"123456")
            SelectLedger.text=byValue

           // byAmounttext.text=byAmount
            SelectLedger.resignFirstResponder()
            
            
        }
        else
        {
            SelectLedger.becomeFirstResponder()
        }*/
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        
        dashBoardCompanyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        loginUsername123=UserDefaults.standard.object(forKey: "loginUsername123") as! String

        
    }
    override func viewWillAppear(_ animated: Bool) {
      
        posName=UserDefaults.standard.object(forKey: "posSingleName") as! String
        posSRNO=UserDefaults.standard.object(forKey: "posSingleSrno") as! String
        posNameLabel.text="Journal Voucher (\(posName))"
       
        getVoucherNumber()
    }
    @objc func handleTap1(_ gesture: UITapGestureRecognizer){
        UserDefaults.standard.set(7, forKey: "CashPaymentCondition")
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "byListShow")
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
   /* func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField==SelectLedger
        { UserDefaults.standard.set(7, forKey: "CashPaymentCondition")
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "byListShow")
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            
        }
        return true
    }*/
    

    @IBAction func SelectDrOrCr(_ sender: UIButton) {
        if drOrCrButton.titleLabel?.text=="Dr"
        {
            drOrCrButton.setTitle("Cr", for: .normal)
        }
        else
        {
           drOrCrButton.setTitle("Dr", for: .normal)
        }
     
    }
    
    @IBAction func back(_ sender: UIButton) {
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "dashBoard")
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        if SelectLedger.text?.isEmpty==true
        {
            SelectLedger.becomeFirstResponder()
        }
        else if enterAmount.text?.isEmpty==true
        {
            enterAmount.becomeFirstResponder()
        }
        else
        {self.view.endEditing(true)
            TypeList.append((drOrCrButton.titleLabel?.text!)!)
            if drOrCrButton.titleLabel?.text == "Dr"
            {
                TotalDebitAmount=TotalDebitAmount+Int(enterAmount.text!)!
                DebitList.append(Int(enterAmount.text!)!)
                CreditLIst.append(0)
            }
            else
            {TotalCreditAmount=TotalCreditAmount+Int(enterAmount.text!)!
                CreditLIst.append(Int(enterAmount.text!)!)
                DebitList.append(0)
            }
            ledgersList.append(SelectLedger.text!)
            totalDebit.text="\(TotalDebitAmount)"
            totalCredit.text="\(TotalCreditAmount)"
            journalVoucherTableView.reloadData()
            SelectLedger.text=""
            enterAmount.text=""
            print(TypeList,"Typelist")
            print(ledgersList,"ledgersList")
            print(DebitList,"DebitList")
            print(CreditLIst,"CreditLIst")
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField.resignFirstResponder()
        return true
    }
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
        var calendar=Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        var startDateArray=startDate.components(separatedBy: "/")
        if startDateArray.count==3
        {
            minDateComponent.day = Int(startDateArray[0])
            minDateComponent.month = Int(startDateArray[1])
            minDateComponent.year = Int(startDateArray[2])
            let minDate = calendar.date(from: minDateComponent)
            print(" min date : \(String(describing: minDate))")
            picker.minimumDate = minDate! as Date
        }
        
        
        
        
        
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        var endDateArray=endDate.components(separatedBy: "/")
        if startDateArray.count==3
        {
            maxDateComponent.day = Int(endDateArray[0])
            maxDateComponent.month = Int(endDateArray[1])
            maxDateComponent.year = Int(endDateArray[2])
            let maxDate = calendar.date(from: maxDateComponent)
            print("max date : \(String(describing: maxDate))")
            
            
            picker.maximumDate =  maxDate! as Date
        }
        
        
        
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
        let formatter4 = DateFormatter()
        formatter4.dateFormat="dd-MM-yyyy"
        result1 = formatter1.string(from: picker.date)
        
        result = formatter.string(from: picker.date)
        
        datefield123.text=result
        formatter.dateFormat = "EEEE"
        let dayInWeek = formatter.string(from: picker.date)
        
        let first3:String = dayInWeek.substring(to:dayInWeek.index(dayInWeek.startIndex, offsetBy: 3))
        datefield123.text="\(result) (\(first3))"
        
        
        // datefield123.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    
    
    func getVoucherNumber()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetVoucherNo xmlns=\"http://tempuri.org/\"><MethodName>JournalVouchersEntry</MethodName><pos>\(posSRNO)</pos><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetVoucherNo></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
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
        lobj_Request.addValue("http://tempuri.org/GetVoucherNo", forHTTPHeaderField: "SOAPAction")
        
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
                self.voucherNumber.text=self.GetVoucherNoResult
               self.selection=2
             self.abc1()
            }
        })
        task.resume()
        
    }
    func abc1()
    {selection=2
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStartEndDteOfFnYear xmlns=\"http://tempuri.org/\"><FnYear>\(dashBoardElementValueForFn)</FnYear><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetStartEndDteOfFnYear></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        
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
        lobj_Request.addValue("http://tempuri.org/GetStartEndDteOfFnYear", forHTTPHeaderField: "SOAPAction")
        
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
                    //print(self.GetStartEndDteOfFnYearResult,"11/06/18")
                    var dummy:[String]=self.GetStartEndDteOfFnYearResult.components(separatedBy: "^")
                    if dummy.count==2
                    {
                        self.startDate=dummy[0]
                        self.endDate=dummy[1]
                        self.result1=dummy[1]
                        // self.fromTextField.text=dummy[0]
                        self.datefield123.text=dummy[1]
                        
                        
                        self.createDatePicker()
                        /// self.selection=2
                        
                    }
                    self.GetLedgersOthers()
                    
                }
            }
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
        
        
    }
    func GetLedgersOthers()
    {selection=3
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgersOTHER xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetLedgersOTHER></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
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
                for value in dummyList
                {
                    var dummySecondList=value.components(separatedBy: "~")
                    if dummySecondList.count == 4
                    {
                        self.cashId.append(dummySecondList[0])
                        self.cashNames.append(dummySecondList[1])
                        if dummyList[2]==""
                        {
                            self.cashAmounts.append("0.00")
                        }
                        else
                        {
                            self.cashAmounts.append(dummySecondList[2])
                        }
                        self.cashStatus.append(dummySecondList[3])
                    }
                }
                
                self.searchResults=self.cashNames
               // self.tableView.isHidden=false
                self.ledgersTableView.reloadData()
            }
        })
        task.resume()
        
    }
    
    
    
    
    
    var elementValue: String?
    var GetVoucherNoResult=String()
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetVoucherNoResult" {
            selection==0
            elementValue = String()
            
        }
        if elementName == "SubmitBR_VoucherResult" {
            selection==1
            CashPaymentSubmitResult = String()
            
        }
        if elementName == "GetStartEndDteOfFnYearResult" {
            elementValue = String()
            selection=2
        }
        if elementName == "GetLedgersOTHERResult" {
            elementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection==0 {
            elementValue! += string
            GetVoucherNoResult=elementValue!
        }
        if CashPaymentSubmitResult != nil && selection==1 {
            CashPaymentSubmitResult += string
            CashPaymentSubmitFinalResult=CashPaymentSubmitResult
            print(CashPaymentSubmitFinalResult,"08/06/18*")
        }
        if elementValue != nil && selection==2{
            elementValue! += string
            
            GetStartEndDteOfFnYearResult=elementValue!
            
        }
        if elementValue != nil && selection==3{
            elementValue! += string
            GetLedgersCASHResult=elementValue!
            print(GetLedgersCASHResult,"08/06/18**")
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetVoucherNoResult" {
            selection=0
            elementValue = String()
            
        }
        if elementName == "SubmitBR_VoucherResult" {
            selection=1
            CashPaymentSubmitResult = String()
            
        }
        if elementName == "GetStartEndDteOfFnYearResult" {
            elementValue = String()
            selection=2
        }
        if elementName == "GetLedgersOTHERResult" {
            elementValue = String()
        }
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField=textField
    }
    
    
    @objc func keyboardDidShow(notification: Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        //let parent=self.parent! as! EditProfile
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        
        let editingTextFieldY:CGFloat! = self.activeTextField.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            //Checking if the textfield is really hidden behind the keyboard
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: 0 - (editingTextFieldY! - (keyboardY - 60)), width: self.view.bounds.width,height: self.view.bounds.height)
                }, completion: nil)
            }
        }
        var array1 = [2.1, 2.2, 2.5, 3.0, 4.2, 2]
        
        var array2 = array1.sort(){ $0 > $1}
        
        print(array2)
        
        
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
       // let parent=self.parent! as! EditProfile
        //self.view.frame = CGRect(x: 0, y: 0,width: self.view.bounds.width, height: self.view.bounds.height)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y:0,width: self.view.bounds.width,height: self.view.bounds.height)
        }, completion: nil)
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        TypeList=[String]()
        ledgersList=[String]()
        DebitList=[Int]()
        CreditLIst=[Int]()
        TotalDebitAmount=0
        TotalCreditAmount=0
        SelectLedger.text=""
        enterAmount.text=""
        totalCredit.text=""
        totalDebit.text=""
        remark.text=""
        journalVoucherTableView.reloadData()
        
    }
    
    
    
    @IBAction func submit(_ sender: UIButton) {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField==SelectLedger
        {
        searchResults=cashNames
        ledgersTableView.reloadData()
        //ledgersTableView.isHidden=false
        
        }
        return true
    }
    /* func textFieldDidBeginEditing(_ textField: UITextField) {
     searchResults=names
     tableView.isHidden=false
     tableView.reloadData()
     }*/
    
    
    @objc func textFieldDidChange(_:UITextField){
        
        
        // print(customername.text!)
        
        
        // tableView.isHidden=false
        searchResults=[]
        
        
        searchResults = cashNames.filter({(coisas1:String) -> Bool in
            if (coisas1.lowercased()).contains(SelectLedger.text!) || (coisas1.contains(SelectLedger.text!))
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
        if SelectLedger.text! == nil || SelectLedger.text! == "" || SelectLedger.text!.isEmpty==true
        {
            searchResults=cashNames
            ledgersTableView.reloadData()
        }
        else
        {
            ledgersTableView.reloadData()
            ledgersTableView.isHidden=false
        }
        
    }
    
}
