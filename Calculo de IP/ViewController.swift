//
//  ViewController.swift
//  Calculo de IP
//
//  Created by Mary Béds on 26/09/16.
//  Copyright © 2016 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txt1: UITextField!
    @IBOutlet var txt2: UITextField!
    @IBOutlet var txt3: UITextField!
    @IBOutlet var txt4: UITextField!
    @IBOutlet var txt5: UITextField!
    
    @IBOutlet var view_dados: UIView!
    
    @IBOutlet var lb_mascara: UILabel!
    @IBOutlet var lb_endIP: UILabel!
    @IBOutlet var lb_broadcast: UILabel!
    @IBOutlet var lb_primeiroHost: UILabel!
    @IBOutlet var lb_ultimoHost: UILabel!
    @IBOutlet var lb_rangeIPs: UILabel!
    @IBOutlet var lb_totalIPs: UILabel!
    @IBOutlet var lb_totalIPsUso: UILabel!
    
    //MARK: - VARIÁVEIS
    
    var a_binario: String!
    var b_binario: String!
    var c_binario: String!
    var d_binario: String!
    var e_binario: String!
    
    var valorIP_binario: String!
    
    var a: String!
    var b: String!
    var c: String!
    var d: String!
    var e: String!
    
    var aBITS: String!
    var bBITS: String!
    var cBITS: String!
    var dBITS: String!
    
    var mascara: String!
    
    var aBITS_broadcast: String!
    var bBITS_broadcast: String!
    var cBITS_broadcast: String!
    var dBITS_broadcast: String!

    var mascara_broadcast: String!

    
    var countValidacao: Int!
    
    var countBitsValidos: Double!
    
    var valorIP: String!
    
    var primeiroHost: String!
    var ultimoHost: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         //MARK: - TEXFIELD DELEGATES
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        txt5.delegate = self
        
        view_dados.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     //MARK: - BOTÃO CALCULAR IP
    @IBAction func bt_calcularIP(_ sender: AnyObject) {
        
        capturarIP()
        
        countValidacao = 0
        
        verificarSeValorValido(valor: a)
        verificarSeValorValido(valor: b)
        verificarSeValorValido(valor: c)
        verificarSeValorValido(valor: d)
        verificarSeBitsValido(bits: e)
        
        print("VALIDAÇÃO: ", countValidacao)
        
        if countValidacao == 5 {
            
            calcularMascaraDeRede()
            calcularBroadcast()
            calcularEnderecoRede()
            calcularPrimeiroHots()
            calcularUltimoHots()
            
        }
        
        view.endEditing(true)
        
    }
    
     //MARK: - FUNÇÃO CAPTURAR VALORES TEXFIELD
    func capturarIP(){
        
        a = txt1.text
        b = txt2.text
        c = txt3.text
        d = txt4.text
        e = txt5.text

        a_binario = String(Int(a) ?? 0, radix: 2)
        b_binario = String(Int(b) ?? 0, radix: 2)
        c_binario = String(Int(c) ?? 0, radix: 2)
        d_binario = String(Int(d) ?? 0, radix: 2)
        
        verificarQuantidadeBits()
        
    }
    
    //MARK: - FUNÇÃO VERIFICAR BITS
    func verificarQuantidadeBits(){
        
        if a_binario.characters.count < 8
        {
            let quantidadeRestante: Int! = 8 - a_binario.characters.count
            var string0: String! = ""
            for _ in 0 ..< quantidadeRestante {
                string0 = string0 + "0"
                
            }
            a_binario = string0 + a_binario
        }
            
        if b_binario.characters.count < 8
        {
            let quantidadeRestante: Int! = 8 - b_binario.characters.count
            var string0: String! = ""
            for _ in 0 ..< quantidadeRestante {
                string0 = string0 + "0"
                
            }

            b_binario = string0 + b_binario
        }
            
        if c_binario.characters.count < 8
        {
            let quantidadeRestante: Int! = 8 - c_binario.characters.count
            var string0: String! = ""
            for _ in 0 ..< quantidadeRestante {
                string0 = string0 + "0"
                
            }
            c_binario = string0 + c_binario
            print(string0)
        }
            
        if d_binario.characters.count < 8
        {
            let quantidadeRestante: Int! = 8 - d_binario.characters.count
            var string0: String! = ""
            for _ in 0 ..< quantidadeRestante {
                string0 = string0 + "0"
                
            }
            d_binario = string0 + d_binario
            print(string0)
        }
        
        valorIP_binario = a_binario + "." + b_binario + "." + c_binario + "." + d_binario
        
        print("IP BINÁRIO: ", valorIP_binario)

    }
    
    //MARK: - FUNÇÃO VERIFICAR SE IP É VÁLIDO
    func verificarSeValorValido(valor: String){
        
        if let texto:Int = Int(valor) {
        
            if  texto < 0 || texto > 256 {
                
                let alert = UIAlertController(title: "Alerta", message: "O valor digitado deve ser maior que 0 e menor que 256.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                countValidacao = countValidacao + 1
            }
            
        } else{
            
            let alert = UIAlertController(title: "Alerta", message: "Campo vazio", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    //MARK: - FUNÇÃO VERIFICAR O VALOR DE BITS
    func verificarSeBitsValido (bits: String){
        
        if let texto:Int = Int(bits) {
        
            if  texto < 0 || texto > 32 {
                
                let alert = UIAlertController(title: "Alerta", message: "O valor de Bits deve ser maior que 0 e menor que 33.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                countValidacao = countValidacao + 1;
            }
        } else{
            let alert = UIAlertController(title: "Alerta", message: "Campo vazio", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    //MARK: - FUNÇÃO CÁLCULO DA MÁSCARA DE REDE
    func calcularMascaraDeRede() {
        
        let bits: Int? = Int(e)
        
        countBitsValidos = 0
        mascara = ""
        
        for i in 0 ..< 32 {
            
            if i == 8 || i == 16 || i == 24 {

                if i == 8 {
                    aBITS = mascara;
                } else if i == 16{
                    bBITS = String(mascara.replacingOccurrences(of: aBITS + ".", with: ""))
                }else if i == 24 {
                    cBITS = String(mascara.replacingOccurrences(of: aBITS + "." + bBITS + ".", with: ""))
                }
                
                 mascara = mascara + "."
                
            }
        

            if(i < bits!){
                mascara = mascara + "1"
            }else{
                mascara = mascara + "0"
                countBitsValidos = countBitsValidos + 1
            }
            
            if i == 31{
                //print("MASCARA D: ", mascara)
                dBITS = String(mascara.replacingOccurrences(of: aBITS + "." + bBITS + "." + cBITS + ".", with:""))
            }
        
        }
        
        mascara = "\(strtoul(aBITS, nil, 2)).\(strtoul(bBITS, nil, 2)).\(strtoul(cBITS, nil, 2)).\(strtoul(dBITS, nil, 2))"
        
    }
    
    //MARK: - FUNÇÃO CÁLCULO BROADCAST
    func calcularBroadcast(){
        
        var bits: Int? = Int(e)
        
        if bits! > 8 {
            if bits! < 9 {
                bits! = bits! + 1
            }
            else if bits! < 19 {
                bits! = bits! + 2
            }
            else{
                bits! = bits! + 3
            }
        }
        
    
        let result = valorIP_binario.replacingOccurrences(of: "0", with: "1", options: NSString.CompareOptions.literal, range: valorIP_binario.index(valorIP_binario.startIndex, offsetBy: bits!)..<valorIP_binario.endIndex)
    
        
        print(result)
        
        let myStringArr = result.components(separatedBy: ".")
  
        let newA_binario = myStringArr[0]
        let newB_binario = myStringArr[1]
        let newC_binario = myStringArr[2]
        let newD_binario = myStringArr[3]
        
        mascara_broadcast = "\(strtoul(newA_binario, nil, 2)).\(strtoul(newB_binario, nil, 2)).\(strtoul(newC_binario, nil, 2)).\(strtoul(newD_binario, nil, 2))"
    
    }
    
     //MARK: - FUNÇÃO CÁLCULO DA REDE
    func calcularEnderecoRede(){
        
        var bits: Int? = Int(e)
        
        if bits! > 8 {
            if bits! < 9 {
                bits! = bits! + 1
            }
            else if bits! < 19 {
                bits! = bits! + 2
            }
            else{
                bits! = bits! + 3
            }
        }
        
        
        let result = valorIP_binario.replacingOccurrences(of: "1", with: "0", options: NSString.CompareOptions.literal, range: valorIP_binario.index(valorIP_binario.startIndex, offsetBy: bits!)..<valorIP_binario.endIndex)
        
        
        print(result)
        
        let myStringArr = result.components(separatedBy: ".")
        
        let newA_binario = myStringArr[0]
        let newB_binario = myStringArr[1]
        let newC_binario = myStringArr[2]
        let newD_binario = myStringArr[3]
        
        valorIP = "\(strtoul(newA_binario, nil, 2)).\(strtoul(newB_binario, nil, 2)).\(strtoul(newC_binario, nil, 2)).\(strtoul(newD_binario, nil, 2))"

    }
    
    //MARK: - FUNÇÃO CÁLCULO DO PRIMEIRO HOST
    func calcularPrimeiroHots(){
        
        //pegar ultimo range do valorIP e somar 1
        let mudarBits: Int = valorIP.characters.count
        let novoBits: Int = mudarBits - 1
        
        primeiroHost = valorIP.replacingOccurrences(of: "0", with: "1", options: NSString.CompareOptions.literal, range: valorIP.index(valorIP.startIndex, offsetBy: novoBits)..<valorIP.endIndex)
        
        print(primeiroHost)
        
    }
    
    //MARK: - FUNÇÃO CÁLCULO DO ÚLTIMO HOST
    func calcularUltimoHots(){
        
        let myStringArr = mascara_broadcast.components(separatedBy: ".")
        
        let newD: Int = Int(myStringArr[3])!
        
        let newD_mascara = newD - 1
        
        ultimoHost = "\(myStringArr[0]).\(myStringArr[1]).\(myStringArr[2]).\(newD_mascara)"
        
        print(ultimoHost)
        
        preencherCampos()
    }

    
    
    //MARK: - FUNÇÃO PEENCHER CAMPOS
    func preencherCampos(){
        
       view_dados.isHidden = false
        
        lb_mascara.text = mascara
        lb_endIP.text = valorIP + "/" + e
        lb_broadcast.text = mascara_broadcast
        lb_primeiroHost.text = primeiroHost
        lb_ultimoHost.text = ultimoHost
        lb_rangeIPs.text = valorIP + "  -  " + mascara_broadcast
        lb_totalIPs.text = "\(pow(2, countBitsValidos))"
        lb_totalIPsUso.text = "2"
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

