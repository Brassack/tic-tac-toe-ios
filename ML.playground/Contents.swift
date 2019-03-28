import CreateML
import CreateMLUI
import ModelBridge

extension Int32: MLDataValueConvertible {
    public static var dataValueType: MLDataValue.ValueType {
        return .int
    }
    
    public init?(from dataValue: MLDataValue) {
        if let intValue = dataValue.intValue {
            self = Int32(intValue)
        }else{
            return nil
        }
    }
    
    public var dataValue: MLDataValue {
        return MLDataValue.int(Int(self))
    }
}


let converter = TTGameFileldConverter()
let resultCalculator = TTGameStepResultCalculator()
var indexConverter = TTGameFieldIndexConverter()


let data: [String: MLDataValueConvertible] = {
    
    //MLRegressor is very limited in tuning, so i play with coefficients
    let loose = 1.5
    let draw = 0.5
    let game = 0.0
    let win = -2.0
    
    var looseFields = Set<Int32>()
    var winFields = Set<Int32>()
    var gameFields = Set<Int32>()
    var drawField = Set<Int32>()

    //Can takes a time, 3349 variants
    //http://www.mathrec.org/old/2002jan/solutions.html
    //https://math.stackexchange.com/a/486548
    //Subtracting these from your 6046 gets 5,478, which matches the computer.

    func step(model: TTGameModel, figure: TTGameModel.Figure) {
        
        let key = converter.number(from: model)
        
        guard !winFields.contains(key) else { return }
        guard !looseFields.contains(key) else { return }
        guard !drawField.contains(key) else { return }
        guard !gameFields.contains(key) else { return }
        
        for row in 0..<3 {
            for column in 0..<3{
                
                let existingFigure = model.figure(atRow: row, column: column)
                guard existingFigure == .none else { continue }
                
                var testModel = model
                testModel.put(figure, intoRow: row, column: column)
                let stepKey = converter.number(from: testModel)
                
                let state = testModel.state
                
                if state == .win || (figure == .o && resultCalculator.isLeadsToHumanWin(model: testModel)) {
                    
                    winFields.insert(stepKey)
                }else if state == .loose {
                    
                    looseFields.insert(stepKey)
                }else if state == .draw {
                    
                    drawField.insert(stepKey)
                }else if state == .game {
                    
                    step(model: testModel, figure: figure == .x ? .o : .x)
                    gameFields.insert(stepKey)
                }
            }
        }
    }
    
    step(model: TTGameModel(), figure: .x)

    var fields = [[String]](repeating: [String](), count: 9)
    var fieldCost = [Double]()
    
    looseFields.map({ field in

        for row in 0..<3 {
            for column in 0..<3 {
                
                let model = converter.model(from: field)
                let figure = model.figure(atRow: row, column: column)
                fields[indexConverter.indexFor(row, column)].append(figure.rawValue)
            }
        }
        
        fieldCost.append(loose)
    })
    
    winFields.map({ field in
        for row in 0..<3 {
            for column in 0..<3 {
                
                let model = converter.model(from: field)
                let figure = model.figure(atRow: row, column: column)
                fields[indexConverter.indexFor(row, column)].append(figure.rawValue)
            }
        }
        fieldCost.append(win)
    })
    
    drawField.map({ field in
        
        for row in 0..<3 {
            for column in 0..<3 {
                
                let model = converter.model(from: field)
                let figure = model.figure(atRow: row, column: column)
                fields[indexConverter.indexFor(row, column)].append(figure.rawValue)
            }
        }
        
        fieldCost.append(draw)
    })
    
    gameFields.map({ field in

        for row in 0..<3 {
            for column in 0..<3 {
                
                let model = converter.model(from: field)
                let figure = model.figure(atRow: row, column: column)
                fields[indexConverter.indexFor(row, column)].append(figure.rawValue)
            }
        }

        fieldCost.append(game)
    })
    
    return ["0x0": fields[0],
            "0x1": fields[1],
            "0x2": fields[2],
            "1x0": fields[3],
            "1x1": fields[4],
            "1x2": fields[5],
            "2x0": fields[6],
            "2x1": fields[7],
            "2x2": fields[8],
            "cost": fieldCost]
}()

let table = try MLDataTable(dictionary: data)
print("Data: ", table)

var path = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first!

let regressor = try? MLRegressor(trainingData: table, targetColumn: "cost")
print("Path: ", path)

do{
    let metadata = MLModelMetadata(author: "Dmytro Platov", shortDescription: "Model to predict cost of step for tic toe game", license: "CC BY-NC-SA 4.0", version: "1.0", additional: nil)
    try regressor?.write(to: URL(fileURLWithPath: path).appendingPathComponent("MLStepCostPredictor.mlmodel"), metadata: metadata)
}catch{
    print("Error saving model: ", error.localizedDescription)
}
