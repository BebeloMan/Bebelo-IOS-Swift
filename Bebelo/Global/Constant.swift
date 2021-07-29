//
//  Constant.swift
//  Futbolist
//
//  Created by Adeel on 19/12/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit

struct Constant {
    
    
    static let v2 = "v2"
    static let version = "api"
    static let mainUrl = "http://178.62.228.40/bebelo/newbeblou/login"
    //static let mainCloudFunctionUrl = "https://us-central1-bebelo-d62b2.cloudfunctions.net"
    static let mainCloudFunctionUrl = "http://178.62.195.48:3000"
    static let mapboxtoken = "sk.eyJ1IjoiYWxpam9objIwNTAiLCJhIjoiY2t0bG0zd3RmMXd2czJ6cW4yenVkN3hnOSJ9.AyuAowhykKmQq1NunjecIA"
    //MARK: CACHE KEY'S
    static let login_key = "login_key"
    static let announce_key = "announce_key"
    static let freetable_key = "freetable_key"
    static let onlyshow_key = "onlyshow_key"
    static let onlyshow_key1 = "onlyshow_key1"
    static let token_id = "token_id"
    static let locationAccessKey = "locationAccessKey"
    static let shareUrl = "https://apps.apple.com/us/app/bebelo/id1613322776"
    static let Mad_latitude = 40.416775
    static let Mad_longitude = -3.703790
    //40.4168023710554, -3.7037863132225044
    //MARK: DATABASE HELPER KEY
    static let cart = "cart"
    static let bars = "bars"
    static let cid = "cid"
    static let checkDate = "checkDate"
    
    //MARK: WEB SERVICE
    static let sucess = "sucess"
    static let success = "success"
    static let return_data = "return_data"
    static let image = "image"
    
    //MARK: firestore key
    static let userName = "userName"
    static let idTokken = "idTokken"
    static let user_id = "user_id"
    static let dob = "dob"
    static let sex = "sex"
    static let bar_id = "bar_id"
    static let status = "status"
    
    static let phoneNumber = "phoneNumber"
    static let token = "token"
    
    //MARK: MODELS KEY'S
    static let id = "id"
    static let email = "email"
    static let user_email = "user_email"
    static let user_password = "user_password"
    static let full_name = "full_name"
    static let isFirstTime = "isFirstTime"
    static let isFirstTime1 = "isFirstTime1"
    static let location = "location"
    static let maplocation = "maplocation"
    static let mobilenumber = "mobilenumber"
    static let password = "password"
    static let address_name = "address_name"
    static let address = "address"
    static let address_lat = "address_lat"
    static let address_lng = "address_lng"
    static let imageURL = "imageURL"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let lat = "lat"
    static let lng = "lng"
    static let name = "name"
    static let number = "number"
    static let isFriend = "isFriend"
    static let country = "country"
    static let thumbnail = "thumbnail"
    static let uploaderID = "uploaderID"
    static let videoLatitude = "videoLatitude"
    static let videoLocation = "videoLocation"
    static let videoLongitude = "videoLongitude"
    static let videoURL = "videoURL"
    
    //MARK: OTHERS CONSTANTS
    static let mainStoryboard = "Main"
    static let selectedBarDetailIdentifier = "SelectedBarDetailViewController"
    static let navigationBackImage = "image 13"
    static let barDetailTableViewCell = "BarDetailTableViewCell"
    static let mainCategoryTableViewCell = "MainCategoryTableViewCell"
    static let otherCategoryTableViewCell = "OtherCategoryTableViewCell"
    static let showMoreTableViewCell = "ShowMoreTableViewCell"
    static let announcementTableViewCell = "AnnouncementTableViewCell"
    static let barGalleryTableViewCell = "BarGalleryTableViewCell"
    static let drinksTableViewCell = "DrinksTableViewCell"
    static let barInfoImageTableViewCell = "BarInfoImageTableViewCell"
    static let addDrinksTableViewCell = "AddDrinksTableViewCell"
    static let onlyShowTableViewCell = "OnlyShowTableViewCell"
    static let openHoursHeaderTableViewCell = "OpenHoursHeaderTableViewCell"
    static let openingHourTableViewCell = "OpeningHourTableViewCell"
    static let contactInfoTableViewCell = "ContactInfoTableViewCell"
    static let SupplimentTableViewCell = "SupplimentTableViewCell"
    static let termsAndConditionTableViewCell = "TermsAndConditionTableViewCell"
    static let logoutBtnTableViewCell = "LogoutBtnTableViewCell"
    static let logoutBtn1TableViewCell = "LogoutBtn1TableViewCell"
    static let labelColor = "Label Text"
    static let openSansFont = "OpenSans-Bold"
    static let cabinFont = "Cabin-Bold"
    static let cabinSFont = "Cabin-SemiBold"
    static let cabinRFont = "Cabin-Regular"
    static let robotoFont = "Roboto-Bold"
    static let robotoMFont = "Roboto-Medium"
    static let robotoSFont = "Roboto-SemiBold"
    static let robotoRFont = "Roboto-Regular"
    static let robotoBFont = "Roboto-Bold"
    static let fontSize12: CGFloat = 12.0
    static let fontSize13: CGFloat = 13.0
    static let fontSize14: CGFloat = 14.0
    static let fontSize15: CGFloat = 15.0
    static let fontSize17: CGFloat = 17.0
    static let fontSize19: CGFloat = 19.0
    static let tableviewHeaderHeight: CGFloat = 50
    static let tableviewHeaderXY: CGFloat = 0.0
    static let exitIcon = "exitIcon"
    static let assetsTypeImage = "public.image"
    static let assetsTypeMovie = "public.movie"
    static let chooseImageTilte = "Choose Image"
    static let camera = "Camera"
    static let gallery = "Gallery"
    static let cancel = "Cancel"
    
    // FIREBASE NODES ....
    static let WEB_URL = "https://writearticlesforme.com"
    static let NODE_USERS = "Users"
    static let NODE_TEST_USERS = "TestUsers"
    static let NODE_TEST_USERS1 = "TestUsers1"
    static let NODE_USERS2 = "Users2"
    static let NODE_USERS1 = "User1"
    static let NODE_VISITORS = "Visitors"
    static let NODE_ANNOUNCE = "announce"
    static let NODE_CONTACT = "contact"
    static let NODE_CHARGES = "charges"
    static let NODE_LIMITS = "limits"
    static let NODE_BARS = "Bars"
    static let NODE_CURRENT_USER_UID = "currentUserUID"
    static let NODE_COUNTRY = "Country"
    static let NODE_BRANCHES = "Branches"
    static let NODE_COUNTRY_ID = "countryId"
    static let NODE_PURPOSE_TYPES = "PurposeTypes"
    static let NODE_BRANCH_ID = "branchId"
    static let NODE_PURPOSE_ID = "purposeId"
    static let NODE_CHATS = "Chats"
    static let NODE_CONVERSATIONS = "conversations"
    static let NODE_USER_BRANCHES = "userBranches"
    
}
