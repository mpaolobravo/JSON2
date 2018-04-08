//
//  ViewController.swift
//  JSON2
//
//  Created by Miguel Paolo Bravo on 3/10/18.
//  Copyright © 2018 Miguel Paolo Bravo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var objects = [[String: Any]]()
    let totalSearches = 200000
    let salLimitMax = 50000.0
    let salLimitMin = 45000.0
    let minSal = 3500.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let path = Bundle.main.path(forResource: "convertcsv", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
              //  print("jsonData:\(jsonObj)")
                parse2(json: jsonObj)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        
    }

    func parse2(json: JSON) {
 
        
        for result in json.arrayValue {
            
            // print("result \(result)")
            
            let name1 = result["Name"].stringValue
       
            let postion = result["Position"].stringValue

            let salary = result["Salary"].doubleValue
            let fantasyPoints = result["AvgPointsPerGame"].doubleValue

            let obj = ["playerName": name1, "playerPosition": postion, "salary": salary, "fantasyPoints": fantasyPoints] as [String : Any]
            objects.append(obj)
        }
        
        // print("\(petitions[Int(arc4random_uniform(UInt32(petitions.count)))])")
        
    
        
//        var array = [TestObj]()
//        var array2 = [[TestObj]]()
     
        var salary = [Double]()
        var salary2 = Double()
        var fPoints = Double()
        
        var lineUpObjArr = [LineUpBaskObj]()
        
        
        
        var pg = ""
        var sg = ""
        
        var sf = ""
        var pf = ""
        
        var g = ""
        var f = ""
        
        var c = ""
        var u = ""
        
        var lineUpObj = LineUpBaskObj(pg: pg, sg: sg, g: g, sf: sf, pf: pf, f: f, c: c, u: u, salary: -1, fantasyPoints: -1)
        var counter = 0
        
        print("objects.count = \(objects.count)")
        
        for _ in 0..<totalSearches  {
            
            for _ in 0..<10  {
                
                // let obj = petitions[Int(arc4random_uniform(UInt32(petitions.count)))]
                
           //     print("\(obj["playerName"])")
                
                // salary2 += obj["salary"] as! Double
                
//                let obj3 = TestObj(playerName: obj["playerName"] as! String, playerPosition: obj["playerPosition"] as! String, salary: obj["salary"] as! Double, fantasyPoints: obj["fantasyPoints"] as! Double)
                
                while (pg == "" || sg == "" || g == "" ||  sf == "" || pf == "" || f == "" || c == "" || u == "") {
                    counter += 1
                    // print("while loop \(counter)")
                    
                    let testObj = objects[Int(arc4random_uniform(UInt32(objects.count)))]
                    
                    let name = testObj["playerName"] as! String
                    var fPoints2 = String(testObj["fantasyPoints"] as! Double)
                    
                    if fPoints2 == "0.0"{
                        fPoints2 = " ZERO "
                        //  print("break")
                        break
                    }
                    
                    var sal2 = String(testObj["salary"] as! Double)
                    
                    if (testObj["salary"] as! Double) < minSal {
                        sal2 = sal2 + " null "
                        
                    }
                    
                    let playerP = testObj["playerPosition"] as! String!
                    
                    var prevP = ""
                    
                    // print("salary = \(testObj["salary"] as! Double) ")
                    
                    // name != prevP
                    if (playerP == "PG" || playerP == "PG/SG") && pg == "" && !sg.contains(name){
                        pg = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = pg
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    // name != prevP
                    if (playerP == "SG" || playerP == "PG/SG" || playerP == "SG/SF") && sg == "" && !pg.contains(name){
                        sg = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = sg
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    //  name.range(of:pg) == nil && name.range(of:sg) == nil)
                    
                    
                    if (playerP == "SF" || playerP == "SF/PF" || playerP == "SG/SF") && sf == "" && !pf.contains(name) && !sg.contains(name){
                        sf = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if (playerP == "PF" || playerP == "SF/PF" || playerP == "PF/C") && pf == "" && !sf.contains(name) && !c.contains(name) && !f.contains(name) {
                        pf = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    
                    
                    if (playerP == "C" || playerP == "PF/C") && c == "" && !pf.contains(name){
                        c = playerP! + "  S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if g == "" && (playerP == "PG" || playerP == "SG" || playerP == "PG/SG" || playerP == "SG/SF") && (pg != "" && sg != "" && !pg.contains(name) && !sg.contains(name) && !f.contains(name) && !sf.contains(name)) {
                        g = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if f == "" && (playerP == "SF" || playerP == "PF" || playerP == "SF/PF" || playerP == "PF/C" || playerP == "SG/SF") && (sf != "" && pf != "" && !sf.contains(name) && !pf.contains(name) && !c.contains(name) && !g.contains(name) && !sg.contains(name)){
                        
                        f = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if pg != "" && sg != "" && g != "" &&  sf != "" && pf != "" && f != "" && c != "" && !pg.contains(name) && !sg.contains(name) && !sf.contains(name) && !pf.contains(name) && !f.contains(name) && !g.contains(name) && !c.contains(name) {
                        u = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                        
                        //  print("n = \(name) p = \(prevP)")
                        
                    }
                    
                    
                }
                
                
                
           //     array.append(obj3)
                
            }
            // print("salary2 \(salary2)")
            if salary2 < 50000 && salary2 > salLimitMin {
             
                
                //  print("salary2 < 50000 && salary2 > 45000")
                
                lineUpObj = LineUpBaskObj(pg: pg, sg: sg, g: g, sf: sf, pf: pf, f: f, c: c, u: u, salary: salary2, fantasyPoints: fPoints)
                
                lineUpObjArr.append(lineUpObj)
                
                
                
            }
            
            pg = ""
            sg = ""
            
            sf = ""
            pf = ""
            
            g = ""
            f = ""
            
            c = ""
            u = ""
            
       //     array.removeAll()
            salary2 = 0
            fPoints = 0
        }
        
        //    print("\(salary.sorted())")
        //   array2.sort { $0.salary < $1.salary}
        //  print("\(array2)")
        var sal = 0.0
        var name = ""
        var tempArr = [Double:String]()
        var index = 0
        // print("array2.count \(array2.count)")
//        for i in array2{
//            // tempArr = i
//            //  tempArr.sorted { $0.salary < $1.salary}
//            for j in i {
//                sal += j.salary
//                index += 1
//                name += " \(index). " + j.playerName
//            }
//            //  print("\(sal)")
//            // let obj = [sal : name]
//            tempArr[sal] = name
//
//            name = ""
//            sal = 0
//            index = 0
//        }
//        let sorted = Array(tempArr).sorted(by: { $0.0 > $1.0 })
 
        
        print("lineUpObjArr.count \(lineUpObjArr.count) \n\n")
        
        
        
        let sorted3 = lineUpObjArr.sorted(by: { $0.fantasyPointsTotal > $1.fantasyPointsTotal })
        var rankCount = 0
        var rankCount1 = 0
        
        let size = Int(sorted3.count/3)
        //        for i in 0..<size{
        //            let j = sorted3[i]
        //            rankCount1 += 1
        //            print("Rank: \(rankCount1) / \(sorted3.count)")
        //            print("Salary \(j.salaryTotal!) | Points \(j.fantasyPointsTotal!) \n")
        //            print("1. \(j.PGposition!)")
        //            print("2. \(j.SGposition!)")
        //            print("3. \(j.SFposition!)")
        //            print("4. \(j.PFposition!)")
        //            print("5. \(j.Cposition!)")
        //            print("6. \(j.Gposition!)")
        //            print("7. \(j.Fposition!)")
        //            print("8. \(j.Uposition!)")
        //            print("-----------------\n")
        //        }
        let sorted2 = lineUpObjArr.sorted(by: { $0.salaryTotal > $1.salaryTotal })
        
        
        var counter257 = 0
        var counter257Less = 0
        
        let sizesorted3 = Int(sorted3.count/5)
        
        for x in 0..<50 {
            
            let i = sorted3[x]
            
            //            rankCount += 1
            //            print("Rank2: \(rankCount) / \(sorted3.count)")
            //            print("Salary2 \(i.salaryTotal!) | Points \(i.fantasyPointsTotal!) \n")
            //            print("1. \(i.PGposition!)")
            //            print("2. \(i.SGposition!)")
            //            print("3. \(i.SFposition!)")
            //            print("4. \(i.PFposition!)")
            //            print("5. \(i.Cposition!)")
            //            print("6. \(i.Gposition!)")
            //            print("7. \(i.Fposition!)")
            //            print("8. \(i.Uposition!)")
            //            print("-----------------\n")
            
            
            // if salaryTotal > 49000 && salaryPer > 3500 (null)
            rankCount += 1
            if i.salaryTotal > 40000.0 &&
                !i.PGposition.contains("null") &&
                !i.SGposition.contains("null") &&
                !i.SFposition.contains("null") &&
                !i.PFposition.contains("null") &&
                !i.Cposition.contains("null") &&
                !i.Gposition.contains("null") &&
                !i.Fposition.contains("null") &&
                !i.Uposition.contains("null") &&
                
                !i.PGposition.contains("ZERO") &&
                !i.SGposition.contains("ZERO") &&
                !i.SFposition.contains("ZERO") &&
                !i.PFposition.contains("ZERO") &&
                !i.Cposition.contains("ZERO") &&
                !i.Gposition.contains("ZERO") &&
                !i.Fposition.contains("ZERO") &&
                !i.Uposition.contains("ZERO")
                
            {
                
                print("Rank2: \(rankCount) / \(sorted3.count)")
                print("Salary2 \(i.salaryTotal!) | Points \(i.fantasyPointsTotal!) \n")
                print("PG = \(i.PGposition!)")
                print("SG = \(i.SGposition!)")
                print("SF = \(i.SFposition!)")
                print("PF = \(i.PFposition!)")
                print("C  = \(i.Cposition!)")
                print("G  = \(i.Gposition!)")
                print("F  = \(i.Fposition!)")
                print("U  = \(i.Uposition!)")
                print("-----------------\n")
                
                if i.fantasyPointsTotal > 256 {
                    counter257 += 1
                }else{
                    counter257Less += 1
                }
            }
            
            
        }
        
        print("counter257 = \(counter257)")
        print("counter257Less = \(counter257Less)")
    }


}

