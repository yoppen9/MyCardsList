//
//  TitleListModel.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/20.
//

import Foundation

enum Section {
    case familySection
    case bfSection
    case localSection
    case highSchoolSection
    case collegeSection
    case companySection
    case otherSection
}

class TitleListModel {
    var sectionTitle: String = "家族"
    var section = Section.familySection
    let cardsList = ["家族","親友","地元友達","高校友達","大学友達","会社","その他"]
    
    var FamilyName: [String] = []
    var FamilyPhone: [String] = []
    var FamilyPhotos: [Data] = []
    
    var BfName: [String] = []
    var BfPhone: [String] = []
    var BfPhotos: [Data] = []
    
    var LocalName: [String] = []
    var LocalPhone: [String] = []
    var LocalPhotos: [Data] = []
    
    var HighSchoolName: [String] = []
    var HighSchoolPhone: [String] = []
    var HighSchoolPhotos: [Data] = []

    var CollegeName: [String] = []
    var CollegePhone: [String] = []
    var CollegePhotos: [Data] = []
    
    var CompanyName: [String] = []
    var CompanyPhone: [String] = []
    var CompanyPhotos: [Data] = []
    
    var OtherName: [String] = []
    var OtherPhone: [String] = []
    var OtherPhotos: [Data] = []
}
