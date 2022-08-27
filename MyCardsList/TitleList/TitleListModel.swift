//
//  TitleListModel.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/20.
//

import Foundation

enum Section {
    case familySection
    case bestFriendSection
    case localFriendsSection
    case highSchoolFriendsSection
    case collegeFriendsSection
    case companyPeopleSection
    case otherPeopleSection
}

class TitleListModel {
    var sectionTitle: String = "家族"
    var section = Section.familySection
    let cardsList = ["家族","親友","地元友達","高校友達","大学友達","会社","その他"]
    
    var familyName: [String] = []
    var familyBirthday: [String] = []
    var familyPhotos: [Data] = []
    
    var bestFriendName: [String] = []
    var bestFriendBirthday: [String] = []
    var bestFriendPhotos: [Data] = []
    
    var localFriendsName: [String] = []
    var localFriendsBirthday: [String] = []
    var localFriendsPhotos: [Data] = []
    
    var highSchoolFriendsName: [String] = []
    var highSchoolFriendsBirthday: [String] = []
    var highSchoolFriendsPhotos: [Data] = []

    var collegeFriendsName: [String] = []
    var collegeFriendsBirthday: [String] = []
    var collegeFriendsPhotos: [Data] = []
    
    var companyPeopleName: [String] = []
    var companyPeopleBirthday: [String] = []
    var companyPeoplePhotos: [Data] = []
    
    var otherPeopleName: [String] = []
    var otherPeopleBirthday: [String] = []
    var otherPeoplePhotos: [Data] = []
}
