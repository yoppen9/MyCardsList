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
    
    var familyName: [String] = []
    var familyPhone: [String] = []
    var familyPhotos: [Data] = []
    
    var bfName: [String] = []
    var bfPhone: [String] = []
    var bfPhotos: [Data] = []
    
    var localName: [String] = []
    var localPhone: [String] = []
    var localPhotos: [Data] = []
    
    var highSchoolName: [String] = []
    var highSchoolPhone: [String] = []
    var highSchoolPhotos: [Data] = []

    var collegeName: [String] = []
    var collegePhone: [String] = []
    var collegePhotos: [Data] = []
    
    var companyName: [String] = []
    var companyPhone: [String] = []
    var companyPhotos: [Data] = []
    
    var otherName: [String] = []
    var otherPhone: [String] = []
    var otherPhotos: [Data] = []
}
