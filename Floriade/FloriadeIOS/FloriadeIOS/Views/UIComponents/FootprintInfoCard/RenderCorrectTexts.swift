//
//  RenderCorrectTexts.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 23/03/2022.
//

import Foundation

class RenderTexts {
    static func RenderHectareTexts(pageType: FootprintInfoTitles, hectare: Double) -> String {
        if (pageType == FootprintInfoTitles.DutchFootPrintTitle || pageType == FootprintInfoTitles.InsideDutchFootprintTitle) {
            return "Our ecological footprint consists of 5 global hectares. This means that we use the average biocapacity of 5 hectares of biologically productive earth surface. Why 5 hectares? Think about what you’re eating, how much time you’re spending in a car, how much green energy you’re using and how often you’re sitting on the plane."
        }
        
        if (pageType == FootprintInfoTitles.IdealFootPrintTitle || pageType == FootprintInfoTitles.InsideIdealFootprintTitle) {
            return "Our precise ecological footprint consists of 1.6 global hectares. This means that we must use the biocapacity of 1.6 hectares of biologically productive earth surface. Why 1.6 hectares? If we divide all global hectares all over the Earth by the number of people, we currently have 1.6 hectares available on the Earth. This means that we use all available global hectares, so we’d prefer to need even less."
        }
        
        if (pageType == FootprintInfoTitles.PersonalFootPrintTitle) {
            if (hectare > 5) {
                return "Your ecological footprint is made up of".localized(langVar) + " \(hectare) " + "global hectares. This means that you use a biocapacity of".localized(langVar) + " \(hectare) " + "hectares of biologically productive earth surface. This is more than the average Dutch person, so we would advise you to start living greener, because we don't have unlimited resources and ultimately must make do with the earth we have now.".localized(langVar)
            } else {
                return "Your ecological footprint is made up of".localized(langVar) + " \(hectare) " + "global hectares. This means that you use a biocapacity of".localized(langVar) + " \(hectare) " + "hectares of biologically productive earth surface. This is less than the average Dutch person, well done! Nevertheless, this does not mean that we should not start living even greener, because in the end we all must make do with the earth we have now.".localized(langVar)
            }
        }
        
        return ""
    }
    
    static func RenderEarthTexts(pageType: FootprintInfoTitles, earths: Double) -> String {
        if (pageType == FootprintInfoTitles.DutchFootPrintTitle || pageType == FootprintInfoTitles.InsideDutchFootprintTitle) {
            return "If everyone goes through life just like the average Dutch person, we need not one, but 3.1 Earths to suffice our needs."
        }
        
        if (pageType == FootprintInfoTitles.IdealFootPrintTitle || pageType == FootprintInfoTitles.InsideIdealFootprintTitle) {
            return "If we live life like this, we can get just enough from the Earth, but are still on the brink of exhaustion."
        }
        
        if (pageType == FootprintInfoTitles.PersonalFootPrintTitle) {
            return "If we would live like you do, we need no less than".localized(langVar) + " \(earths) " + (earths <= 1.0 ? "earth".localized(langVar) : "earths".localized(langVar)) + " " + "to suffice our needs.".localized(langVar)
        }
        
        return ""
    }
    
    static func RenderOvershootTexts(pageType: FootprintInfoTitles) -> String {
        if (pageType == FootprintInfoTitles.DutchFootPrintTitle || pageType == FootprintInfoTitles.InsideDutchFootprintTitle) {
            return "On this date we have used everything that nature can renew in a whole year all over the Earth. This means that anything we use after this date, nature cannot renew it in that year."
        }
        
        if (pageType == FootprintInfoTitles.IdealFootPrintTitle || pageType == FootprintInfoTitles.InsideIdealFootprintTitle) {
            return "On this date when we have used everything that nature can renew in a whole year all over the Earth. In this way we use exactly what nature can renew, but this also shows that we are also walking on a small edge."
        }
        
        if (pageType == FootprintInfoTitles.PersonalFootPrintTitle) {
            return "If everyone would be living like you, this is the date when we have used everything nature can renew in a whole year all over the Earth. This means that anything we use after this date, nature cannot renew it in that year."
        }
        
        return ""
    }
}
