//
//  Localized+StringExtension.swift
//  FloriadeIOS
//
//  Created by Pieter van der Mullen on 22/03/2022.
//

import Foundation

extension String {
func localized(_ lang:String) ->String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}
