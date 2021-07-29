//
//  LangHelper.swift
//  Bebelo
//
//  Created by Buzzware Tech on 21/01/2022.
//

import UIKit
import Localize_Swift

enum Languages: String, CaseIterable {
    case en, ru, ar, fr, es, de, zh, hi
}

extension Languages {
    var iso: String {
        return self.rawValue
    }
    
    var displayName: String {
        let locale = Locale(identifier: self.rawValue)
        return locale.localizedString(forIdentifier: self.rawValue) ?? ""
    }
    
    var parameter: String {
        switch self {
        case .en:
            return "english"
        case .ru:
            return "russia"
        case .ar:
            return "kuwait"
        case .fr:
            return "french"
        case .es:
            return "spanish"
        case .de:
            return "german"
        case .zh:
            return "chinies"
        case .hi:
            return "indian"
        }
    }
    
    var flagName: String {
        return self.iso+"-flag"
    }
}

class LangHelper: NSObject {
    
    static var allLanguages: [Languages] {
        return Languages.allCases
    }
    
//    static var textAlignment: NSTextAlignment {
//        return Localize.isRTL ? .right : .left
//    }
    
    static var currentLang: Languages {
        return Languages(rawValue: Localize.currentLanguage()) ?? .en
    }
    
//    static var semanticAttribute: UISemanticContentAttribute {
//        return Localize.isRTL ? .forceRightToLeft : .forceLeftToRight
//    }
    
    class func setLangauge(lang: Languages) {
        Localize.setCurrentLanguage(lang.iso)
    }
}

