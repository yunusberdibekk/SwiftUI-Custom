//
//  DropdownMenuOption.swift
//  CustomDropdownMenu
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import Foundation

struct DropdownMenuOption: Identifiable, Hashable {
    let id = UUID()
    let option: String
}

extension DropdownMenuOption {
    static let testSingleMonth: DropdownMenuOption = DropdownMenuOption(option: "Mart")
    
    static let testAllMonths: [DropdownMenuOption] = [
        DropdownMenuOption(option: "Ocak"),
        DropdownMenuOption(option: "Şubat"),
        DropdownMenuOption(option: "Mart"),
        DropdownMenuOption(option: "Nisan"),
        DropdownMenuOption(option: "Mayıs"),
        DropdownMenuOption(option: "Haziran"),
        DropdownMenuOption(option: "Temmuz"),
        DropdownMenuOption(option: "Ağustos"),
        DropdownMenuOption(option: "Eylül"),
        DropdownMenuOption(option: "Ekim"),
        DropdownMenuOption(option: "Kasım"),
        DropdownMenuOption(option: "Aralık")
    ]
}

/*
 struct LocationResponseElement: Codable, Hashable {
     let ulkeID, ulkeAdi, sehirID, sehirAdi: String?
     let ulkeIDFk, ilceID, ilceAdi, sehirIDFk: String?

     enum CodingKeys: String, CodingKey {
         case ulkeID = "ulke_id"
         case ulkeAdi = "ulke_adi"
         case sehirID = "sehir_id"
         case sehirAdi = "sehir_adi"
         case ulkeIDFk = "ulke_id_fk"
         case ilceID = "ilce_id"
         case ilceAdi = "ilce_adi"
         case sehirIDFk = "sehir_id_fk"
     }
 }

 typealias LocationResponse = [[LocationResponseElement]]
 
 let ulkeler = response[0]
 let iller = response[1]
 let ilceler = response[2]
 */
