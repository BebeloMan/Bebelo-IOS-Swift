//
//  FirebaseData.swift
//  MyReferral
//
//  Created by vision on 14/05/20.
//  Copyright © 2020 vision. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseMessaging
import LGSideMenuController
class FirebaseData{
    class func createUserData(email: String, password: String, completion:@escaping (_ result:AuthDataResult?,_ error:Error?) -> ()) {
        let db = Auth.auth()
        
        db.createUser(withEmail: email, password: password, completion: completion)
        
    }
    class func logoutUserData(_ completion:@escaping (_ error:Error?) -> ()) {
        let db = Auth.auth()
        do {
            try db.signOut()
        completion(nil)
        }
        catch let error{
        completion(error)
        }
    }
    class func loginUserData(email: String, password: String, completion:@escaping (_ result:AuthDataResult?,_ error:Error?) -> ()) {
        let db = Auth.auth()
        
        db.signIn(withEmail: email, password: password, completion: completion)
        
    }
    class func loginAnonymusUserData( completion:@escaping (_ result:AuthDataResult?,_ error:Error?) -> ()) {
        let db = Auth.auth()
        db.signInAnonymously(completion: completion)
        
    }
    class func reloginAnonymusUserData(id:String, completion:@escaping (_ result:AuthDataResult?,_ error:Error?) -> ()) {
            let db = Auth.auth()
            db.signIn(withCustomToken: id, completion: completion)
        
        
    }
    class func loginLinkUserData(email:String,password:String,auth:User, completion:@escaping (_ result:AuthDataResult?,_ error:Error?) -> ()) {
        
        
        let credent = EmailAuthProvider.credential(withEmail: "\(email)s", password: password)
        auth.link(with: credent, completion: completion)
        
    }
    class func deleteAnonymusUserData( completion:@escaping (_ error:Error?) -> ()) {
        let db = Auth.auth().currentUser
        db?.delete(completion: completion)
        
    }
    class func deleteAnonymusVisitorData(id:String, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_VISITORS).document(id).delete(completion: completion)
        
    }
    class func forgotUserPassword(email: String, completion:@escaping (_ error:Error?) -> ()) {
        let db = Auth.auth()
        db.sendPasswordReset(withEmail: email, completion: completion)
        
    }
    class func saveUserData(uid: String? = nil, userData: Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        let dic: [String:Any]!
        if let user = userData as? UserModel{
            
            if let id = uid{
                do {
                    try db.collection(Constant.NODE_USERS).document(id).setData(from: user) { err in
                        if let err = err {
                            completion(err)
                        } else {
                            completion(nil)
                        }
                    }
                }
                catch let err{
                    completion(err)
                }
            }
            else{
                do {
                    try db.collection(Constant.NODE_USERS).addDocument(from: user){
                        err in
                        if let err = err {
                            completion(err)
                        } else {
                            completion(nil)
                        }
                    }
                }
                catch let err{
                    completion(err)
                }
                
            }
            
        }
        else{
            dic = userData as? [String:Any]
            if let id = uid{
                db.collection(Constant.NODE_USERS).document(id).setData(dic, completion: {
                    err in
                    if let err = err {
                        completion(err)
                    } else {
                        completion(nil)
                    }
                })
            }
            else{
                db.collection(Constant.NODE_USERS).addDocument(data: dic){
                    err in
                    if let err = err {
                        completion(err)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        
        
        
    }
    class func saveVisitorData(uid: String, userData: Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        let dic: [String:Any]!
        if let user = userData as? VisitorModel{
            dic = user.dictionary
        }
        else{
            dic = userData as? [String:Any]
        }
        db.collection(Constant.NODE_VISITORS).document(uid).setData(dic, completion: {
            err in
            if let err = err {
                completion(err)
            } else {
                completion(nil)
            }
        })
        
    }
    class func saveUser2Data(uid: String, userData: Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        let dic: [String:Any]!
        if let user = userData as? User2Model{
            dic = user.dictionary
        }
        else{
            dic = userData as? [String:Any]
        }
        db.collection(Constant.NODE_USERS2).document(uid).setData(dic, completion: {
            err in
            if let err = err {
                completion(err)
            } else {
                completion(nil)
            }
        })
        
    }
    class func updateUserData(_ referId: String, dic:Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        var dics: [String:Any]!
        if let dta = dic as? UserModel{
            do {
                
                try db.collection(Constant.NODE_USERS).document(referId).setData(from: dta, merge: true){
                    err in
                    if let err = err {
                        //let erro = FIRErrorCode(raw)
                        completion(err)
                    } else {
                        completion(nil)
                    }
                }
            }
            catch let err{
                completion(err)
            }
        }
        else if let dta = dic as? [String:Any]{
            dics = dta
            db.collection(Constant.NODE_USERS).document(referId).updateData(dics, completion: {
                err in
                if let err = err {
                    //let erro = FIRErrorCode(raw)
                    completion(err)
                } else {
                    completion(nil)
                }
            })
        }
        else{
            completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]))
        }
        
        
    }
    class func updateUserData1(_ referId: String, dic:Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        var dics: [String:Any]!
        if let dta = dic as? UserModel{
            do {
                
                try db.collection(Constant.NODE_USERS).document(referId).setData(from: dta, merge: true){
                    err in
                    if let err = err {
                        //let erro = FIRErrorCode(raw)
                        completion(err)
                    } else {
                        completion(nil)
                    }
                }
            }
            catch let err{
                completion(err)
            }
        }
        else if let dta = dic as? [String:Any]{
            dics = dta
            db.collection(Constant.NODE_USERS).document(referId).updateData(dics, completion: {
                err in
                if let err = err {
                    //let erro = FIRErrorCode(raw)
                    completion(err)
                } else {
                    completion(nil)
                }
            })
        }
        else{
            completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]))
        }
        
        
    }
    class func updateUser2Data(_ referId: String, dic:Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        var dics: [String:Any]!
        if let dta = dic as? User2Model{
            dics = dta.dictionary
        }
        else if let dta = dic as? [String:Any]{
            dics = dta
        }
        else{
            completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]))
        }
        db.collection(Constant.NODE_USERS2).document(referId).updateData(dics, completion: {
            err in
            if let err = err {
                //let erro = FIRErrorCode(raw)
                completion(err)
            } else {
                completion(nil)
            }
        })
        
    }
    class func updateVisitorData(_ referId: String, dic:Any, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        var dics: [String:Any]!
        if let dta = dic as? VisitorModel{
            dics = dta.dictionary
        }
        else if let dta = dic as? [String:Any]{
            dics = dta
        }
        else{
            completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]))
        }
        db.collection(Constant.NODE_VISITORS).document(referId).updateData(dics, completion: {
            err in
            if let err = err {
                //let erro = FIRErrorCode(raw)
                completion(err)
            } else {
                completion(nil)
            }
        })
        
    }
    class func getVisitorData(uid: String, completion:@escaping (_ error:Error?, _ userData: VisitorModel?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_VISITORS).document(uid).getDocument { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                completion(nil, VisitorModel(snap: snap!))
            }
        }
        
    }
    class func getUserData(uid: String, completion:@escaping (_ error:Error?, _ userData: UserModel?) -> ()) {
        
        let db = Firestore.firestore()
        
        db.collection(Constant.NODE_USERS).document(uid).getDocument { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                do {
                    let user = try snap?.data(as: UserModel.self)
                    completion(nil, user)
                }
                catch let err{
                    
                    switch err {
                    case DecodingError.typeMismatch(_, let context):
                        print("\(err.localizedDescription): \(context.debugDescription)")
                    case DecodingError.valueNotFound(_, let context):
                        print("\(err.localizedDescription): \(context.debugDescription)")
                    case DecodingError.keyNotFound(_, let context):
                        print("\(err.localizedDescription): \(context.debugDescription)")
                    case DecodingError.dataCorrupted(let key):
                        print("\(err.localizedDescription): \(key)")
                    default:
                        print("Error decoding document: \(err.localizedDescription)")
                    }
                    print("documentID:\(snap?.documentID)")
                    let u = UserModel1(snap: snap! )!
                    var model = UserModel()
                    model.id = u.docId
                    model.uuid = u.uuid
                    model.baddress = u.baddress
                    var drinks = [DrinkPricesModel]()
                    for dic in u.barBottle{
                        if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                            let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                            drinks.append(drink)
                            
                        }
                        
                    }
                    model.barBottle = drinks
                    var barHas = [OnlyShowModel]()
                    for dic in u.barHas{
                        if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                            let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                            barHas.append(bar)
                            
                        }
                        
                    }
                    model.barHas = barHas
                    var barWeekDay = [WeekDayModel]()
                    for dic in u.barWeekDay{
                        if let b = WeekDayModel1(dictionary: dic as AnyObject){
                            let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? "Monday"))
                            barWeekDay.append(barWeek)
                            
                        }
                        
                    }
                    model.barWeekDay = barWeekDay
                    model.blat = u.blat
                    model.blng = u.blng
                    model.image = u.image
                    model.pinimage = u.pinimage
                    model.bname = u.bname
                    model.cemail = u.cemail
                    model.cname = u.cname
                    model.cpassword = u.cpassword
                    model.cphone = u.cphone
                    model.deviceType = u.deviceType
                    model.isSupliment = u.isSupliment
                    model.token = u.token
                    model.userDate = u.userDate
                    model.isAnnounce = u.isAnnounce
                    model.announce = u.announce
                    model.announceDate = u.announceDate
                    model.isFreeTable = u.isFreeTable
                    model.freeTableDate = u.freeTableDate
                    model.isopend = u.isopend
                    model.displaytime = u.displaytime
                    model.displayPrice = u.displayPrice
                    model.status = u.status
                    model.isAdded = u.isAdded
                    model.closingtype = u.closingtype
                    model.rangeKm = u.rangeKm
                    completion(nil,model)
                }
                
            }
        }
        
    }
    class func getUserFromEmailData(email: String, completion:@escaping (_ error:Error?, _ userData: UserModel?) -> ()) {
        
        let db = Firestore.firestore()
        
        db.collection(Constant.NODE_USERS).whereField(UserKeys.cemail.rawValue, isGreaterThanOrEqualTo: email).getDocuments { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                do {
                    if snap?.documents.count ?? 0 > 0 {
                        let user = try snap?.documents.first?.data(as: UserModel.self)
                        completion(nil, user)
                    }
                    else{
                        completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
                    }
                    
                }
                catch let err{
                    
                    switch err {
                    case DecodingError.typeMismatch(_, let context):
                        print("\(err.localizedDescription): \(context.debugDescription)")
                    case DecodingError.valueNotFound(_, let context):
                        print("\(err.localizedDescription): \(context.debugDescription)")
                    case DecodingError.keyNotFound(_, let context):
                        print("\(err.localizedDescription): \(context.debugDescription)")
                    case DecodingError.dataCorrupted(let key):
                        print("\(err.localizedDescription): \(key)")
                    default:
                        print("Error decoding document: \(err.localizedDescription)")
                    }
                    print("\(email)")
                    print("documentID:\(snap?.documents.first?.documentID)")
                    let u = UserModel1(snap: (snap?.documents.first)! )!
                    var model = UserModel()
                    model.id = u.docId
                    model.uuid = u.uuid
                    model.baddress = u.baddress
                    var drinks = [DrinkPricesModel]()
                    for dic in u.barBottle{
                        if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                            let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                            drinks.append(drink)
                            
                        }
                        
                    }
                    model.barBottle = drinks
                    var barHas = [OnlyShowModel]()
                    for dic in u.barHas{
                        if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                            let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                            barHas.append(bar)
                            
                        }
                        
                    }
                    model.barHas = barHas
                    var barWeekDay = [WeekDayModel]()
                    for dic in u.barWeekDay{
                        if let b = WeekDayModel1(dictionary: dic as AnyObject){
                            let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? ""))
                            barWeekDay.append(barWeek)
                            
                        }
                        
                    }
                    model.barWeekDay = barWeekDay
                    model.blat = u.blat
                    model.blng = u.blng
                    model.image = u.image
                    model.pinimage = u.pinimage
                    model.bname = u.bname
                    model.cemail = u.cemail
                    model.cname = u.cname
                    model.cpassword = u.cpassword
                    model.cphone = u.cphone
                    model.deviceType = u.deviceType
                    model.isSupliment = u.isSupliment
                    model.token = u.token
                    model.userDate = u.userDate
                    model.isAnnounce = u.isAnnounce
                    model.announce = u.announce
                    model.announceDate = u.announceDate
                    model.isFreeTable = u.isFreeTable
                    model.freeTableDate = u.freeTableDate
                    model.isopend = u.isopend
                    model.displaytime = u.displaytime
                    model.displayPrice = u.displayPrice
                    model.status = u.status
                    model.isAdded = u.isAdded
                    model.closingtype = u.closingtype
                    model.rangeKm = u.rangeKm
                    completion(err,model)
                }
                
            }
        }
        
    }
    class func getUserData1(uid: Int64, completion:@escaping (_ error:Error?, _ userData: UserModel?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_TEST_USERS).whereField(UserKeyss.uuid.rawValue, isEqualTo: uid).getDocuments { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                if snap?.documents.count ?? 0 > 0 {
                    do {
                        let user = try snap?.documents.first?.data(as: UserModel.self)
                        completion(nil, user)
                    }
                    catch let err{
                        completion(err,nil)
                    }
                }
                else{
                    completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
                }
                
            }
        }
        
    }
    class func getUserData2( completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_TEST_USERS).getDocuments { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                var referralList:[UserModel] = []
                if snap?.documents.count ?? 0 > 0 {
                    snap?.documents.forEach({ (queryDocument) in
                        do {
                            let user = try queryDocument.data(as: UserModel.self)
                            referralList.append(user)
                        }
                        catch let err{
                            completion(err,nil)
                        }
                        
                        
                    })
                    completion(nil,referralList)
                }
                else{
                    completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
                }
                
            }
        }
        
    }
    class func deleteUserData2(uid: String, completion:@escaping (_ error:Error?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_TEST_USERS).document(uid).delete { (error) in
            if let err = error {
                completion(err)
            }else {
                completion(nil)
                
            }
        }
        
    }
    class func getUser2Data(uid: String, completion:@escaping (_ error:Error?, _ userData: User2Model?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_USERS2).document(uid).getDocument { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                completion(nil, User2Model(snap: snap!))
            }
        }
        
    }
    class func getUserDataListener(uid: String, completion:@escaping (_ error:Error?, _ userData: UserModel?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_USERS).document(uid).addSnapshotListener { (snap, error) in
            if let err = error {
                completion(err,nil)
            }else {
                do {
                    let user = try snap?.data(as: UserModel.self)
                    completion(nil, user)
                }
                catch let err{
                    print("documentID:\(snap?.documentID)")
                    let u = UserModel1(snap: snap! )!
                    var model = UserModel()
                    model.id = u.docId
                    model.uuid = u.uuid
                    model.baddress = u.baddress
                    var drinks = [DrinkPricesModel]()
                    for dic in u.barBottle{
                        if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                            let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                            drinks.append(drink)
                            
                        }
                        
                    }
                    model.barBottle = drinks
                    var barHas = [OnlyShowModel]()
                    for dic in u.barHas{
                        if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                            let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                            barHas.append(bar)
                            
                        }
                        
                    }
                    model.barHas = barHas
                    var barWeekDay = [WeekDayModel]()
                    for dic in u.barWeekDay{
                        if let b = WeekDayModel1(dictionary: dic as AnyObject){
                            let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? ""))
                            barWeekDay.append(barWeek)
                            
                        }
                        
                    }
                    model.barWeekDay = barWeekDay
                    model.blat = u.blat
                    model.blng = u.blng
                    model.image = u.image
                    model.pinimage = u.pinimage
                    model.bname = u.bname
                    model.cemail = u.cemail
                    model.cname = u.cname
                    model.cpassword = u.cpassword
                    model.cphone = u.cphone
                    model.deviceType = u.deviceType
                    model.isSupliment = u.isSupliment
                    model.token = u.token
                    model.userDate = u.userDate
                    model.isAnnounce = u.isAnnounce
                    model.announce = u.announce
                    model.announceDate = u.announceDate
                    model.isFreeTable = u.isFreeTable
                    model.freeTableDate = u.freeTableDate
                    model.isopend = u.isopend
                    model.displaytime = u.displaytime
                    model.displayPrice = u.displayPrice
                    model.status = u.status
                    model.isAdded = u.isAdded
                    model.closingtype = u.closingtype
                    model.rangeKm = u.rangeKm
                    completion(nil,model)
                }
                
            }
        }
        
    }
    class func getUserTestListData(_ completion:@escaping (_ error:Error?, _ userAddData: [UserModel]?, _ userChangeData: [UserModel]?, _ userDeleteData: [UserModel]?,_ type: DocumentChangeType) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_TEST_USERS).getDocuments { (querySnapShot, error) in
            if let err = error {
                completion(err,nil,nil,nil,.added)
            }else {
                var referralAddList:[UserModel] = []
                var referralChangList:[UserModel] = []
                var referralDeleteList:[UserModel] = []
                var docType: DocumentChangeType! = .none
                if querySnapShot?.documentChanges.count ?? 0 > 0 {
                    querySnapShot?.documentChanges.forEach({ (queryDocument) in
                        switch queryDocument.type{
                        case .added:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralAddList.append(user)
                                docType = .added
                                print("loadadd:\(user.uuid)")
                            }
                            catch let err{
                                completion(err,nil,nil,nil,.added)
                            }
                            
                        case .modified:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralChangList.append(user)
                                docType = .modified
                                print("loadchange:\(user.uuid)")
                            }
                            catch let err{
                                completion(err,nil,nil,nil,.added)
                            }
                            
                        case .removed:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralDeleteList.append(user)
                                docType = .removed
                                print("loaddelete:\(user.uuid)")
                            }
                            catch let err{
                                completion(err,nil,nil,nil,.added)
                            }
                            
                        default:
                            break
                        }
                        //let u = UserModel(snap: queryDocument )!
                        //print("load:\(u.uuid)")
                        //referralList.append(u)
                        //docType = .added
                        
                    })
                    completion(nil,referralAddList,referralChangList,referralDeleteList,docType)
                }
                else{
                    completion(NSError(domain: "No Data found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No User Found", comment: "")]),nil,nil,nil,.added)
                }
            }
        }
        
    }
    class func getUserTestListDate(_ completion:@escaping (_ error:Error?, _ userAddData: [UserModel]?, _ userChangeData: [UserModel]?, _ userDeleteData: [UserModel]?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_USERS).getDocuments { (querySnapShot, error) in
            if let err = error {
                completion(err,nil,nil,nil)
            }else {
                var referralAddList:[UserModel] = []
                var referralChangList:[UserModel] = []
                var referralDeleteList:[UserModel] = []
                var docType: DocumentChangeType! = .none
                if querySnapShot?.documentChanges.count ?? 0 > 0 {
                    querySnapShot?.documentChanges.forEach({ (queryDocument) in
                        switch queryDocument.type{
                        case .added:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralAddList.append(user)
                                docType = .added
                                print("loadadd:\(user.uuid)")
                            }
                            catch let err{
                                switch err {
                                    
                                        case DecodingError.typeMismatch(_, let context):
                                          print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.valueNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.keyNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.dataCorrupted(let key):
                                          print("\(err.localizedDescription): \(key)")
                                        default:
                                          print("Error decoding document: \(err.localizedDescription)")
                                        }
                                print("documentID:\(queryDocument.document.documentID)")
                                let u = UserModel1(snap: queryDocument.document )!
                                var model = UserModel()
                                model.id = u.docId
                                model.uuid = u.uuid
                                model.baddress = u.baddress
                                var drinks = [DrinkPricesModel]()
                                for dic in u.barBottle{
                                    if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                                        let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                                        drinks.append(drink)
                                        
                                    }
                                    
                                }
                                model.barBottle = drinks
                                var barHas = [OnlyShowModel]()
                                for dic in u.barHas{
                                    if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                                        let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                                        barHas.append(bar)
                                        
                                    }
                                    
                                }
                                model.barHas = barHas
                                var barWeekDay = [WeekDayModel]()
                                for dic in u.barWeekDay{
                                    if let b = WeekDayModel1(dictionary: dic as AnyObject){
                                        let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? ""))
                                        barWeekDay.append(barWeek)
                                        
                                    }
                                    
                                }
                                model.barWeekDay = barWeekDay
                                model.blat = u.blat
                                model.blng = u.blng
                                model.image = u.image
                                model.pinimage = u.pinimage
                                model.bname = u.bname
                                model.cemail = u.cemail
                                model.cname = u.cname
                                model.cpassword = u.cpassword
                                model.cphone = u.cphone
                                model.deviceType = u.deviceType
                                model.isSupliment = u.isSupliment
                                model.token = u.token
                                model.userDate = u.userDate
                                model.isAnnounce = u.isAnnounce
                                model.announce = u.announce
                                model.announceDate = u.announceDate
                                model.isFreeTable = u.isFreeTable
                                model.freeTableDate = u.freeTableDate
                                model.isopend = u.isopend
                                model.displaytime = u.displaytime
                                model.displayPrice = u.displayPrice
                                model.status = u.status
                                model.isAdded = u.isAdded
                                model.closingtype = u.closingtype
                                model.rangeKm = u.rangeKm
                                referralAddList.append(model)

                            }
                            
                        case .modified:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralChangList.append(user)
                                docType = .modified
                                print("loadchange:\(user.uuid)")
                            }
                            catch let err{
                                switch err {
                                        case DecodingError.typeMismatch(_, let context):
                                          print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.valueNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.keyNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.dataCorrupted(let key):
                                          print("\(err.localizedDescription): \(key)")
                                        default:
                                          print("Error decoding document: \(err.localizedDescription)")
                                        }
                                print("documentID:\(queryDocument.document.documentID)")
                                let u = UserModel1(snap: queryDocument.document )!
                                var model = UserModel()
                                model.id = u.docId
                                model.uuid = u.uuid
                                model.baddress = u.baddress
                                var drinks = [DrinkPricesModel]()
                                for dic in u.barBottle{
                                    if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                                        let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                                        drinks.append(drink)
                                        
                                    }
                                    
                                }
                                model.barBottle = drinks
                                var barHas = [OnlyShowModel]()
                                for dic in u.barHas{
                                    if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                                        let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                                        barHas.append(bar)
                                        
                                    }
                                    
                                }
                                model.barHas = barHas
                                var barWeekDay = [WeekDayModel]()
                                for dic in u.barWeekDay{
                                    if let b = WeekDayModel1(dictionary: dic as AnyObject){
                                        let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? "Monday"))
                                        barWeekDay.append(barWeek)
                                        
                                    }
                                    
                                }
                                model.barWeekDay = barWeekDay
                                model.blat = u.blat
                                model.blng = u.blng
                                model.image = u.image
                                model.pinimage = u.pinimage
                                model.bname = u.bname
                                model.cemail = u.cemail
                                model.cname = u.cname
                                model.cpassword = u.cpassword
                                model.cphone = u.cphone
                                model.deviceType = u.deviceType
                                model.isSupliment = u.isSupliment
                                model.token = u.token
                                model.userDate = u.userDate
                                model.isAnnounce = u.isAnnounce
                                model.announce = u.announce
                                model.announceDate = u.announceDate
                                model.isFreeTable = u.isFreeTable
                                model.freeTableDate = u.freeTableDate
                                model.isopend = u.isopend
                                model.displaytime = u.displaytime
                                model.displayPrice = u.displayPrice
                                model.status = u.status
                                model.isAdded = u.isAdded
                                model.closingtype = u.closingtype
                                model.rangeKm = u.rangeKm
                                referralChangList.append(model)
                            
                            }
                            
                        case .removed:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralDeleteList.append(user)
                                docType = .removed
                                print("loaddelete:\(user.uuid)")
                            }
                            catch let err{
                                switch err {
                                        case DecodingError.typeMismatch(_, let context):
                                          print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.valueNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.keyNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.dataCorrupted(let key):
                                          print("\(err.localizedDescription): \(key)")
                                        default:
                                          print("Error decoding document: \(err.localizedDescription)")
                                        }
                                print("documentID:\(queryDocument.document.documentID)")
                                let u = UserModel1(snap: queryDocument.document )!
                                var model = UserModel()
                                model.id = u.docId
                                model.uuid = u.uuid
                                model.baddress = u.baddress
                                var drinks = [DrinkPricesModel]()
                                for dic in u.barBottle{
                                    if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                                        let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                                        drinks.append(drink)
                                        
                                    }
                                    
                                }
                                model.barBottle = drinks
                                var barHas = [OnlyShowModel]()
                                for dic in u.barHas{
                                    if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                                        let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                                        barHas.append(bar)
                                        
                                    }
                                    
                                }
                                model.barHas = barHas
                                var barWeekDay = [WeekDayModel]()
                                for dic in u.barWeekDay{
                                    if let b = WeekDayModel1(dictionary: dic as AnyObject){
                                        let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? "Monday"))
                                        barWeekDay.append(barWeek)
                                        
                                    }
                                    
                                }
                                model.barWeekDay = barWeekDay
                                model.blat = u.blat
                                model.blng = u.blng
                                model.image = u.image
                                model.pinimage = u.pinimage
                                model.bname = u.bname
                                model.cemail = u.cemail
                                model.cname = u.cname
                                model.cpassword = u.cpassword
                                model.cphone = u.cphone
                                model.deviceType = u.deviceType
                                model.isSupliment = u.isSupliment
                                model.token = u.token
                                model.userDate = u.userDate
                                model.isAnnounce = u.isAnnounce
                                model.announce = u.announce
                                model.announceDate = u.announceDate
                                model.isFreeTable = u.isFreeTable
                                model.freeTableDate = u.freeTableDate
                                model.isopend = u.isopend
                                model.displaytime = u.displaytime
                                model.displayPrice = u.displayPrice
                                model.status = u.status
                                model.isAdded = u.isAdded
                                model.closingtype = u.closingtype
                                model.rangeKm = u.rangeKm
                                referralDeleteList.append(model)
                            }
                            
                        default:
                            break
                        }
                        //let u = UserModel(snap: queryDocument )!
                        //print("load:\(u.uuid)")
                        //referralList.append(u)
                        //docType = .added
                        
                    })
                    completion(nil,referralAddList,referralChangList,referralDeleteList)
                }
                else{
                    completion(NSError(domain: "No Data found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No User Found", comment: "")]),nil,nil,nil)
                }
            }
        }
        
    }
    class func getUserListListener(_ completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_TEST_USERS).addSnapshotListener { (querySnapShot, error) in
            if let err = error {
                completion(err,nil)
            }else {
                var referralList:[UserModel] = []
                if querySnapShot?.documents.count ?? 0 > 0 {
                    querySnapShot?.documents.forEach({ (queryDocument) in
//                        switch queryDocument.type{
//                        case .added:
//                            referralList.append(UserModel(snap: queryDocument.document )!)
//                            docType = .added
//                        case .modified:
//                            referralList.append(UserModel(snap: queryDocument.document )!)
//                            docType = .modified
//                        case .removed:
//                            referralList.append(UserModel(snap: queryDocument.document )!)
//                            docType = .removed
//                        default:
//                            referralList.append(UserModel(snap: queryDocument.document )!)
//                            docType = .removed
//                        }
                        do {
                            let user = try queryDocument.data(as: UserModel.self)
                            referralList.append(user)
                        }
                        catch let err{
                            completion(err,nil)
                        }
                        
                    })
                    completion(nil,referralList)
                }
                else{
                    completion(NSError(domain: "No Data found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No User Found", comment: "")]),nil)
                }
            }
        }
        
    }
    class func getUserListListener(_ completion:@escaping (_ error:Error?, _ userAddData: [UserModel]?, _ userChangeData: [UserModel]?, _ userDeleteData: [UserModel]?,_ type: DocumentChangeType) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_USERS).addSnapshotListener { (querySnapShot, error) in
            if let err = error {
                completion(err,nil,nil,nil,.added)
            }else {
                var referralAddList:[UserModel] = []
                var referralChangList:[UserModel] = []
                var referralDeleteList:[UserModel] = []
                var docType: DocumentChangeType! = .added
                if querySnapShot?.documentChanges.count ?? 0 > 0 {
                    querySnapShot?.documentChanges.forEach({ (queryDocument) in
                        switch queryDocument.type{
                        case .added:
                            do {
                                var user = try Firestore.Decoder().decode(UserModel.self, from: queryDocument.document.data())
                                //let user = try queryDocument.document.data(as: UserModel.self)
                                user.id = queryDocument.document.documentID
                                referralAddList.append(user)
                                docType = .added
                                print("loadadd:\(user.uuid)")
                            }
                            catch let err{
                                switch err {
                                    
                                        case DecodingError.typeMismatch(_, let context):
                                          print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.valueNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.keyNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.dataCorrupted(let key):
                                          print("\(err.localizedDescription): \(key)")
                                        default:
                                          print("Error decoding document: \(err.localizedDescription)")
                                        }
                                print("documentID:\(queryDocument.document.documentID)")
                                let u = UserModel1(snap: queryDocument.document )!
                                var model = UserModel()
                                model.id = u.docId
                                model.uuid = u.uuid
                                model.baddress = u.baddress
                                var drinks = [DrinkPricesModel]()
                                for dic in u.barBottle{
                                    if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                                        let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                                        drinks.append(drink)
                                        
                                    }
                                    
                                }
                                model.barBottle = drinks
                                var barHas = [OnlyShowModel]()
                                for dic in u.barHas{
                                    if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                                        let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                                        barHas.append(bar)
                                        
                                    }
                                    
                                }
                                model.barHas = barHas
                                var barWeekDay = [WeekDayModel]()
                                for dic in u.barWeekDay{
                                    if let b = WeekDayModel1(dictionary: dic as AnyObject){
                                        let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? ""))
                                        barWeekDay.append(barWeek)
                                        
                                    }
                                    
                                }
                                model.barWeekDay = barWeekDay
                                model.blat = u.blat
                                model.blng = u.blng
                                model.image = u.image
                                model.pinimage = u.pinimage
                                model.bname = u.bname
                                model.cemail = u.cemail
                                model.cname = u.cname
                                model.cpassword = u.cpassword
                                model.cphone = u.cphone
                                model.deviceType = u.deviceType
                                model.isSupliment = u.isSupliment
                                model.token = u.token
                                model.userDate = u.userDate
                                model.isAnnounce = u.isAnnounce
                                model.announce = u.announce
                                model.announceDate = u.announceDate
                                model.isFreeTable = u.isFreeTable
                                model.freeTableDate = u.freeTableDate
                                model.isopend = u.isopend
                                model.displaytime = u.displaytime
                                model.displayPrice = u.displayPrice
                                model.status = u.status
                                model.isAdded = u.isAdded
                                model.closingtype = u.closingtype
                                model.rangeKm = u.rangeKm
                                referralAddList.append(model)
                            }
                            
                        case .modified:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralChangList.append(user)
                                docType = .modified
                                print("loadchange:\(user.uuid)")
                            }
                            catch let err{
                                switch err {
                                        case DecodingError.typeMismatch(_, let context):
                                          print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.valueNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.keyNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.dataCorrupted(let key):
                                          print("\(err.localizedDescription): \(key)")
                                        default:
                                          print("Error decoding document: \(err.localizedDescription)")
                                        }
                                print("documentID:\(queryDocument.document.documentID)")
                                let u = UserModel1(snap: queryDocument.document )!
                                var model = UserModel()
                                model.id = u.docId
                                model.uuid = u.uuid
                                model.baddress = u.baddress
                                var drinks = [DrinkPricesModel]()
                                for dic in u.barBottle{
                                    if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                                        let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                                        drinks.append(drink)
                                        
                                    }
                                    
                                }
                                model.barBottle = drinks
                                var barHas = [OnlyShowModel]()
                                for dic in u.barHas{
                                    if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                                        let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                                        barHas.append(bar)
                                        
                                    }
                                    
                                }
                                model.barHas = barHas
                                var barWeekDay = [WeekDayModel]()
                                for dic in u.barWeekDay{
                                    if let b = WeekDayModel1(dictionary: dic as AnyObject){
                                        let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? "Monday"))
                                        barWeekDay.append(barWeek)
                                        
                                    }
                                    
                                }
                                model.barWeekDay = barWeekDay
                                model.blat = u.blat
                                model.blng = u.blng
                                model.image = u.image
                                model.pinimage = u.pinimage
                                model.bname = u.bname
                                model.cemail = u.cemail
                                model.cname = u.cname
                                model.cpassword = u.cpassword
                                model.cphone = u.cphone
                                model.deviceType = u.deviceType
                                model.isSupliment = u.isSupliment
                                model.token = u.token
                                model.userDate = u.userDate
                                model.isAnnounce = u.isAnnounce
                                model.announce = u.announce
                                model.announceDate = u.announceDate
                                model.isFreeTable = u.isFreeTable
                                model.freeTableDate = u.freeTableDate
                                model.isopend = u.isopend
                                model.displaytime = u.displaytime
                                model.displayPrice = u.displayPrice
                                model.status = u.status
                                model.isAdded = u.isAdded
                                model.closingtype = u.closingtype
                                model.rangeKm = u.rangeKm
                                referralChangList.append(model)
                            }
                            
                        case .removed:
                            do {
                                let user = try queryDocument.document.data(as: UserModel.self)
                                referralDeleteList.append(user)
                                docType = .removed
                                print("loaddelete:\(user.uuid)")
                            }
                            catch let err{
                                switch err {
                                        case DecodingError.typeMismatch(_, let context):
                                          print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.valueNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.keyNotFound(_, let context):
                                    print("\(err.localizedDescription): \(context.debugDescription)")
                                        case DecodingError.dataCorrupted(let key):
                                          print("\(err.localizedDescription): \(key)")
                                        default:
                                          print("Error decoding document: \(err.localizedDescription)")
                                        }
                                print("documentID:\(queryDocument.document.documentID)")
                                let u = UserModel1(snap: queryDocument.document )!
                                var model = UserModel()
                                model.id = u.docId
                                model.uuid = u.uuid
                                model.baddress = u.baddress
                                var drinks = [DrinkPricesModel]()
                                for dic in u.barBottle{
                                    if let d = DrinkPricesModel1(dictionary: dic as AnyObject){
                                        let drink = DrinkPricesModel(drinkName: DrinkNameKeys(rawValue: d.drinkName) ?? .Doble, drinkImage: d.drinkImage, drinkPrice: d.drinkPrice)
                                        drinks.append(drink)
                                        
                                    }
                                    
                                }
                                model.barBottle = drinks
                                var barHas = [OnlyShowModel]()
                                for dic in u.barHas{
                                    if let b = OnlyShowModel1(dictionary: dic as AnyObject){
                                        let bar = OnlyShowModel(title: b.title, isSelected: b.isSelected)
                                        barHas.append(bar)
                                        
                                    }
                                    
                                }
                                model.barHas = barHas
                                var barWeekDay = [WeekDayModel]()
                                for dic in u.barWeekDay{
                                    if let b = WeekDayModel1(dictionary: dic as AnyObject){
                                        let barWeek = WeekDayModel(svalue: b.svalue, evalue: b.evalue, name: b.name, weekDay: weekfullDay(rawValue: b.weekDay ?? "Monday"))
                                        barWeekDay.append(barWeek)
                                        
                                    }
                                    
                                }
                                model.barWeekDay = barWeekDay
                                model.blat = u.blat
                                model.blng = u.blng
                                model.image = u.image
                                model.pinimage = u.pinimage
                                model.bname = u.bname
                                model.cemail = u.cemail
                                model.cname = u.cname
                                model.cpassword = u.cpassword
                                model.cphone = u.cphone
                                model.deviceType = u.deviceType
                                model.isSupliment = u.isSupliment
                                model.token = u.token
                                model.userDate = u.userDate
                                model.isAnnounce = u.isAnnounce
                                model.announce = u.announce
                                model.announceDate = u.announceDate
                                model.isFreeTable = u.isFreeTable
                                model.freeTableDate = u.freeTableDate
                                model.isopend = u.isopend
                                model.displaytime = u.displaytime
                                model.displayPrice = u.displayPrice
                                model.status = u.status
                                model.isAdded = u.isAdded
                                model.closingtype = u.closingtype
                                model.rangeKm = u.rangeKm
                                referralDeleteList.append(model)
                            }
                            
                        default:
                            break
                        }
                        //let u = UserModel(snap: queryDocument )!
                        //print("load:\(u.uuid)")
                        //referralList.append(u)
                        //docType = .added
                        
                    })
                    completion(nil,referralAddList,referralChangList,referralDeleteList,docType)
                }
                else{
                    completion(NSError(domain: "No Data found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No User Found", comment: "")]),nil,nil,nil,.added)
                }
            }
        }
        
    }
    class func getUserbyPhoneData(uid: String, completion:@escaping (_ error:Error?, _ userData: UserModel?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_USERS).whereField(UserKeys.phoneNumber.rawValue, isEqualTo: uid).getDocuments { querySnapShot, error in
            if let err = error {
                completion(err,nil)
            }else {
                if querySnapShot?.documents.count ?? 0 > 0 {
                    querySnapShot?.documents.forEach({ (queryDocument) in
                        do {
                            let user = try queryDocument.data(as: UserModel.self)
                            completion(nil,user)
                        }
                        catch let err{
                            completion(err,nil)
                        }
                        
                    })
                }
                else{
                    completion(NSError(domain: "No Data found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No User Found", comment: "")]),nil)
                }
                
            }
        }
        
    }
    class func getUserbyEmailData(uid: String, completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constant.NODE_TEST_USERS).whereField(UserKeys.cemail.rawValue, isEqualTo: uid).getDocuments { querySnapShot, error in
            if let err = error {
                completion(err,nil)
            }else {
                var referralList:[UserModel] = []
                if querySnapShot?.documents.count ?? 0 > 0 {
                    querySnapShot?.documents.forEach({ (queryDocument) in
                        do {
                            let user = try queryDocument.data(as: UserModel.self)
                            referralList.append(user)
                        }
                        catch let err{
                            completion(err,nil)
                        }
                        
                    })
                    completion(nil,referralList)
                }
                else{
                    completion(NSError(domain: "No Data found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No User Found", comment: "")]),nil)
                }
                
            }
        }
        
    }
    
//    class func saveContactSupportData(userData: CSModel, completion:@escaping (_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        userData.userId = getCurrentUserId()!
//        db.collection(Constant.NODE_CONTACT).addDocument(data: userData.dictionary) { error in
//            if let err = error {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        }
//        
//    }
//    
//    class func getAccountData(_ accountName: String, completion:@escaping (_ error:Error?, _ userData: AccountModel?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_ACCOUNT).whereField(Constant.accountName, isEqualTo: accountName).getDocuments { (querySnapShot, error) in
//            if let err = error {
//                completion(err,nil)
//            }else {
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    for queryDocument in querySnapShot?.documents ?? [] {
//                        completion(nil,AccountModel(snap: queryDocument))
//                        return
//                    }
//                }
//                else{
//                    completion(nil,nil)
//                }
//                //completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Account details", comment: "")]),nil)
//            }
//        }
//        
//    }
//    class func getAccountList(uid: String, completion:@escaping (_ error:Error?, _ userData: [AccountModel]?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_USERS).document(uid).collection(Constant.NODE_ACCOUNT).addSnapshotListener { querySnapShot, error in
//            if let err = error {
//                completion(err,nil)
//            }else {
//                getAccount(querySnapShot: querySnapShot, error: error, completion: completion)
//                //completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Account details", comment: "")]),nil)
//            }
//        }
//    }
//    class func getAccount(querySnapShot:QuerySnapshot?, error:Error?,completion:@escaping (_ error:Error?, _ referrals:[AccountModel]?) -> ()) {
//        if let err = error {
//            completion(err,nil)
//        }else {
//            var referralList:[AccountModel] = []
//            if querySnapShot?.documents.count ?? 0 > 0 {
//                querySnapShot?.documents.forEach({ (queryDocument) in
//                    
//                    referralList.append(AccountModel(snap: queryDocument )!)
//                })
//            }
//            referralList = referralList.sorted(by: { $0.createdAt.dateValue() > $1.createdAt.dateValue() })
//            completion(nil,referralList)
//        }
//    }
//    class func getChargesList(_ completion:@escaping (_ error:Error?, _ userData: [TransectionTypeModel]?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_CHARGES).getDocuments { querySnapShot, error in
//            if let err = error {
//                completion(err,nil)
//            }else {
//                getCharges(querySnapShot: querySnapShot, error: error, completion: completion)
//                //completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Account details", comment: "")]),nil)
//            }
//        }
//    }
//    class func getCharges(querySnapShot:QuerySnapshot?, error:Error?,completion:@escaping (_ error:Error?, _ referrals:[TransectionTypeModel]?) -> ()) {
//        if let err = error {
//            completion(err,nil)
//        }else {
//            var referralList:[TransectionTypeModel] = []
//            if querySnapShot?.documents.count ?? 0 > 0 {
//                querySnapShot?.documents.forEach({ (queryDocument) in
//                    
//                    referralList.append(TransectionTypeModel(snap: queryDocument )!)
//                })
//            }
//            completion(nil,referralList)
//        }
//    }
//    class func getLimitList(_ completion:@escaping (_ error:Error?, _ userData: [TransectionLimitModel]?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_LIMITS).getDocuments { querySnapShot, error in
//            if let err = error {
//                completion(err,nil)
//            }else {
//                getLimits(querySnapShot: querySnapShot, error: error, completion: completion)
//                //completion(NSError(domain: "No Data", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Account details", comment: "")]),nil)
//            }
//        }
//    }
//    class func getLimits(querySnapShot:QuerySnapshot?, error:Error?,completion:@escaping (_ error:Error?, _ referrals:[TransectionLimitModel]?) -> ()) {
//        if let err = error {
//            completion(err,nil)
//        }else {
//            var referralList:[TransectionLimitModel] = []
//            if querySnapShot?.documents.count ?? 0 > 0 {
//                querySnapShot?.documents.forEach({ (queryDocument) in
//                    
//                    referralList.append(TransectionLimitModel(snap: queryDocument )!)
//                })
//            }
//            completion(nil,referralList)
//        }
//    }
    
//    class func fetchReferrals(role:UserRole,completion:@escaping (_ error:Error?, _ referrals:[ReferralModel]?) -> ()) {
//        let db = Firestore.firestore()
//        if role == UserRole.Admin {
//            db.collection(Constant.NODE_REFERRALS).getDocuments(completion: { (querySnapShot, error) in
//                getRefers(querySnapShot: querySnapShot, error: error, completion: completion)
//                })
//        }else if role == UserRole.BranchManager {
//            db.collection(Constant.NODE_REFERRALS).whereField(Constant.NODE_BRANCH_ID, in: Helper.getCachedUserData()?.userBranches ?? []).getDocuments { (querySnapShot, error) in
//                getRefers(querySnapShot: querySnapShot, error: error, completion: completion)
//            }
//        }else {
//            db.collection(Constant.NODE_REFERRALS).whereField(Constant.NODE_CURRENT_USER_UID, isEqualTo: getCurrentUserId()).getDocuments { (querySnapShot, error) in
//                getRefers(querySnapShot: querySnapShot, error: error, completion: completion)
//            }
//        }
//        
//    }
//    class func fetchUserReferrals(id:String,completion:@escaping (_ error:Error?, _ referrals:[ReferralModel]?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_REFERRALS).whereField(Constant.NODE_CURRENT_USER_UID, isEqualTo: id).getDocuments { (querySnapShot, error) in
//            getRefers(querySnapShot: querySnapShot, error: error, completion: completion)
//        }
//        
//    }
//    class func getReferrals(id:String,completion:@escaping (_ error:Error?, _ referrals:ReferralModel?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_REFERRALS).document(id).getDocument(completion: { (snap, error) in
//            if let err = error {
//                completion(err,nil)
//            }else {
//                completion(nil, ReferralModel(snap: snap!))
//            }
//        })
//        
//    }
//    class func fetchUsers(completion:@escaping (_ error:Error?, _ referrals:[UserModel]?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_USERS).getDocuments { (querySnapShot, error) in
//            getUsers(querySnapShot: querySnapShot, error: error, completion: completion)
//        }
//        
//    }
////    class func fetchAllUsersClaimHistory(completion:@escaping (_ error:Error?, _ referrals:[ClaimHistoryModel]?) -> ()) {
////        let db = Firestore.firestore()
////        db.collection(Constant.NODE_USERS).getDocuments { (querySnapShot, error) in
////            getUsers1(querySnapShot: querySnapShot, error: error, completion: completion)
////        }
////        
////    }
//    class func fetchClaimed(completion:@escaping(_ error:Error?, _ users:[UserModel]?) -> ()){
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_USERS).whereField(Constant.NODE_CURRENT_USER_UID, isEqualTo: getCurrentUserId()).getDocuments { (querySnapShot, error) in
//            
//        }
//    }
//    
//    class func getRefers(querySnapShot:QuerySnapshot?, error:Error?,completion:@escaping (_ error:Error?, _ referrals:[ReferralModel]?) -> ()) {
//        if let err = error {
//            completion(err,nil)
//        }else {
//            var referralList:[ReferralModel] = []
//            if querySnapShot?.documents.count ?? 0 > 0 {
//                querySnapShot?.documents.forEach({ (queryDocument) in
//                    
//                    referralList.append(ReferralModel(snap: queryDocument )!)
//                })
//            }
//            referralList = referralList.sorted(by: { $0.date > $1.date })
//            completion(nil,referralList)
//        }
//    }
//    class func getUsers(querySnapShot:QuerySnapshot?, error:Error?,completion:@escaping (_ error:Error?, _ referrals:[UserModel]?) -> ()) {
//        if let err = error {
//            completion(err,nil)
//        }else {
//
//            var referralList:[UserModel] = []
//            if querySnapShot?.documents.count ?? 0 > 0 {
//                querySnapShot?.documents.forEach({ (queryDocument) in
//                    let dic = UserModel(snap: queryDocument )!
//                    if dic.id != getCurrentUserId(){
//                        referralList.append(dic)
//                    }
//                    
//
//                })
//                completion(nil,referralList)
//            }
//
//        }
//    }
//    class func getUsers1(querySnapShot:QuerySnapshot?, error:Error?,completion:@escaping (_ error:Error?, _ referrals:[ClaimHistoryModel]?) -> ()) {
//        if let err = error {
//            completion(err,nil)
//        }else {
//
//            //var userList:[UserModel] = []
//            var claimHistoryList:[ClaimHistoryModel] = []
//            if querySnapShot?.documents.count ?? 0 > 0 {
//                querySnapShot?.documents.forEach({ (queryDocument) in
//                    let userdic = UserModel(snap: queryDocument )!
//                    var referralPoints = 0
//                    fetchUserReferrals(id: userdic.id) { (error, list) in
//                        if list != nil && list?.count ?? 0 > 0{
//                            for referral in list ?? [] {
//                                if !referral.points.isEmpty {
//                                    referralPoints += Int(referral.points) ?? 0
//                                }
//                            }
//                        }
//                        let array = userdic.arrayClaimedPoints
//
//                        if array.count > 0 {
//
//                            array.forEach({ (data) in
//                                let clampoint = data as! NSDictionary
//
//                                let claimdic = ClaimedModel(dictionary: clampoint)!
//
//                                let claimhistory = ClaimHistoryModel()
//                                claimhistory.userName = userdic.userName
//                                claimhistory.userEmail = userdic.userEmail
//                                claimhistory.phoneNumber = userdic.phoneNumber
//                                claimhistory.date = claimdic.time
//                                claimhistory.claimedPoints = claimdic.claimedPoints
//                                referralPoints = referralPoints - claimdic.claimedPoints
//                                claimhistory.balancePoints = referralPoints
//                                claimHistoryList.append(claimhistory)
//
//                            })
//
//
//                        }
//                        claimHistoryList = claimHistoryList.sorted(by: { $0.date > $1.date })
//                        completion(nil,claimHistoryList)
//                        //dic.earnedPoints = referralPoints
//                        //dic.claimedPoints = claimedPoints
//                        //dic.balancePoints = referralPoints - claimedPoints
//                    }
//                    //userList.append(dic)
//                })
//            }
//
//        }
//    }
//    class func updateBarData(_ referId: String, dic:BarModel, completion:@escaping (_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        
//        db.collection(Constant.NODE_BOOKINGS).document(referId).updateData(dic.dictionary, completion: {
//            err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        })
//        
//    }
//    class func  getbrachesUserData(referalData: ReferralModel, completion:@escaping (_ error:Error?) -> ()) {
//            let db = Firestore.firestore()
//        db.collection(Constant.NODE_USERS).whereField(Constant.NODE_USER_BRANCHES, arrayContains:  referalData.branchId).getDocuments { (querySnapShot, error) in
//            if let err = error {
//                completion(err)
//            } else {
//                
//             completion(nil)
//            }
//        }
//    }
//    
//    class func getPurposeList(completion:@escaping (_ purpose:[PurposeModel]?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_PURPOSE_TYPES).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                var purposeList:[PurposeModel] = []
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    querySnapShot?.documents.forEach({ (queryDocument) in
//                        purposeList.append(PurposeModel(snap: queryDocument )!)
//                    })
//                }
//                completion(purposeList,nil)
//            }
//
//        })
//        
//    }
//    
//    class func getCountriesList(completion:@escaping (_ countries:[CountryModel]?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_COUNTRY).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                var countriesList:[CountryModel] = []
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    querySnapShot?.documents.forEach({ (queryDocument) in
//                        countriesList.append(CountryModel(snap: queryDocument )!)
//                    })
//                }
//                countriesList = countriesList.sorted(by: { $0.countryName < $1.countryName })
//                completion(countriesList,nil)
//            }
//
//        })
//        
//    }
//    
//    class func getBranchesListForCountry(countryID:String,completion:@escaping (_ branches:[BranchModel]?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_BRANCHES).whereField(Constant.NODE_COUNTRY_ID, isEqualTo: countryID).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                var brachesList:[BranchModel]?
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    brachesList = []
//                    querySnapShot?.documents.forEach({ (queryDocument) in
//                        brachesList?.append(BranchModel(snap: queryDocument)!)
//                    })
//                }
//                completion(brachesList,nil)
//            }
//
//        })
//        
//    }
//    
//    class func getCountry(countryID:String,completion:@escaping (_ country:CountryModel?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_COUNTRY).whereField(Constant.NODE_COUNTRY_ID, isEqualTo: countryID).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    for queryDocument in querySnapShot?.documents ?? [] {
//                        completion(CountryModel(snap: queryDocument), nil)
//                        return
//                    }
//                }
//                completion(nil,nil)
//            }
//            
//        })
//        
//    }
//    
//    class func getBranch(branchID:String,completion:@escaping (_ branch:BranchModel?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_BRANCHES).whereField(Constant.NODE_BRANCH_ID, isEqualTo: branchID).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    for queryDocument in querySnapShot?.documents ?? [] {
//                        completion(BranchModel(snap: queryDocument), nil)
//                        return
//                    }
//                }
//                completion(nil,nil)
//            }
//            
//        })
//        
//    }
//    
//    class func getPurpose(purposeID:String,completion:@escaping (_ purpose:PurposeModel?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_PURPOSE_TYPES).whereField(Constant.NODE_PURPOSE_ID, isEqualTo: purposeID).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    for queryDocument in querySnapShot?.documents ?? [] {
//                        completion(PurposeModel(snap: queryDocument), nil)
//                        return
//                    }
//                }
//                completion(nil,nil)
//            }
//            
//        })
//        
//    }
//    
//    class func updateReferalData(referId: String, dic:[AnyHashable:Any], completion:@escaping (_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        
//        db.collection(Constant.NODE_REFERRALS).document(referId).updateData(dic, completion: {
//            err in
//            if let err = err {
//                completion(err)
//            } else {
//             completion(nil)
//            }
//        })
//        
//    }
//    
//    class func updateUserClaimData(Id: String, dic:[Any], completion:@escaping (_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        //db.collection(Constant.NODE_USERS).document(Id).updateData(FieldValue.arrayUnion(dic))
//        db.collection(Constant.NODE_USERS).document(Id).updateData(["arrayClaimedPoints":FieldValue.arrayUnion(dic)], completion: {
//            err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        })
//        
//    }
//    
//    class func getBranchesList(completion:@escaping (_ branches:[BranchModel]?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_BRANCHES).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                var branchList:[BranchModel] = []
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    querySnapShot?.documents.forEach({ (queryDocument) in
//                        branchList.append(BranchModel(snap: queryDocument )!)
//                    })
//                }
//                completion(branchList,nil)
//            }
//
//        })
//    }
//    
//    class func getCountriesWithBranches(countryIds:[Any],completion:@escaping (_ countries:[CountryModel]?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_COUNTRY).whereField(Constant.NODE_COUNTRY_ID, in: countryIds).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                var countriesList:[CountryModel] = []
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    querySnapShot?.documents.forEach({ (queryDocument) in
//                        countriesList.append(CountryModel(snap: queryDocument )!)
//                    })
//                }
//                countriesList = countriesList.sorted(by: { $0.countryName < $1.countryName })
//                completion(countriesList,nil)
//            }
//            
//        })
//    }
//
    class func logout(){
        self.logoutUserData { error in
            let date = UserDefaults.standard.value(forKey: Constant.checkDate) as? Int64
            let user_id = UserDefaults.standard.value(forKey:Constant.user_id)
            let dob = UserDefaults.standard.value(forKey:Constant.dob)
            let sex = UserDefaults.standard.value(forKey:Constant.sex)
            CommonHelper.removeCachedUserData()
            UserDefaults.standard.set(true, forKey: Constant.isFirstTime)
            UserDefaults.standard.set(date, forKey: Constant.checkDate)
            UserDefaults.standard.set(user_id, forKey: Constant.user_id)
            UserDefaults.standard.set(dob, forKey: Constant.dob)
            UserDefaults.standard.set(sex, forKey: Constant.sex)
            //UserDefaults.standard.set(userid, forKey: Constant.user_id)
//                if selftimer != nil{
//                    selftimer.invalidate()
//                    selftimer = nil
//                }
            self.loginAnonymusUserData { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let dashboardViewController = storyboard.instantiateViewController(identifier: "LGSideMenuController") as! LGSideMenuController
                LangHelper.setLangauge(lang: Languages.es)
                UIApplication.shared.windows.first?.rootViewController = dashboardViewController
                
            }
            
            
        }
        
    }
    class func getCurrentUserId() -> (String,Bool) {
        
        let id = Auth.auth().currentUser?.uid
        print("uid: \(id ?? "")")
        if let di = id{
            if let providerData = Auth.auth().currentUser {
                return (di,!providerData.isAnonymous)
            }
            return (di,false)
        }
        else{
            //self.logout()
            return ("",false)
        }
    }
    class func getCurrentAuth() -> User {
        return Auth.auth().currentUser!
    }
    class func getIdTokken(completion: @escaping (_ url: String?,_ error: Error?) -> Void){
        
        Auth.auth().currentUser?.getIDToken(completion: completion)
    }
//    
//    class func getBranchManagerFromBranchId(branchId:String, completion:@escaping (_ user:UserModel?,_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_USERS).whereField(Constant.NODE_USER_BRANCHES, arrayContains: branchId).getDocuments(completion: { (querySnapShot, error) in
//            if let err = error {
//                completion(nil,err)
//            }else {
//                if querySnapShot?.documents.count ?? 0 > 0 {
//                    for queryDocument in querySnapShot?.documents ?? [] {
//                        completion(UserModel(snap: queryDocument), nil)
//                        return
//                    }
//                }
//                completion(nil,nil)
//            }
//            
//        })
//    }
//
    class func uploadProfileImage(image:UIImage ,completion: @escaping (_ url: String?,_ error: Error?) -> Void) {
        let storageRef = Storage.storage().reference().child("Images/\(getCurrentUserId().0).png")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    completion(nil, error)
                } else {
                    storageRef.downloadURL { (url, error) in
                        if error != nil {
                            completion(nil, error)
                        }else {
                            completion(url?.absoluteString ?? "", nil)
                        }
                    }
                }
            }
        }
    }
//    class func updateTokkenData(dic:[String:Any], completion:@escaping (_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        
//        db.collection(Constant.NODE_USERS).document(getCurrentUserId() ?? "").updateData(dic, completion: {
//            err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        })
//        
//    }
//    
//    class func updateUserData(uid: String, userData: [String:Any], completion:@escaping (_ error:Error?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection(Constant.NODE_USERS).document(uid).updateData(userData, completion: {
//            err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        })
//        
//    }
}
