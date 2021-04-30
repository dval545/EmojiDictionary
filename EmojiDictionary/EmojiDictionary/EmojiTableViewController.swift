//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Admin1 on 22/8/20.
//  Copyright © 2020 Admin1. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if !Emoji.loadFromFile().isEmpty{
            emoji = Emoji.loadFromFile()
        } else {
            emoji = Emoji.loadSampleEmojis()
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0

    }
    
    // MARK: - Model:
    var emoji: [Emoji] = []
    
    // MARK: - funcs
    func agregarEmojis(){
        let caraSonriente = Emoji(symbol: "😀", name: "Cara Sonriente", description: "Es una cara sonriente", usage:"Se utiliza para mostrar que estas contento")
        emoji.append(caraSonriente)
        let caraDesilusionada = Emoji(symbol: "☹️", name: "Cara Desilusionada", description: "Muestra Desilusion", usage: "Se usa para mostrar Desilusion")
        emoji.append(caraDesilusionada)
        let corazonEnOjos = Emoji(symbol: "😍", name: "Corazones en los ojos", description: "Es una cara sonriente con corazones en los ojos", usage: "Se utiliza para mostrar que te gusta algo")
        emoji.append(corazonEnOjos)
        let policia = Emoji(symbol: "👮", name: "Policia", description: "Es un policia", usage: "Se utiliza para mostrar autoridad")
        emoji.append(policia)
        let tortuga = Emoji(symbol: "🐢", name: "Tortuga", description: "Es una tortuga", usage: "Se mostrar lentitud")
        emoji.append(tortuga)
        let elefante = Emoji(symbol: "🐘", name: "Elefante", description: "Es un elefante", usage: "Buena memoria")
        emoji.append(elefante)
        let fideos = Emoji(symbol: "🍝", name: "Fideos", description: "Es un plato de fideos", usage: "Que queres comer fideos")
        emoji.append(fideos)
        let dado = Emoji(symbol: "🎲", name: "Dado", description: "Es un dado", usage: "Juegos de azar")
        emoji.append(dado)
        let carpa = Emoji(symbol: "⛺", name: "Carpa", description: "Es una carpa", usage: "Ir a acampar")
        emoji.append(carpa)
        let libros = Emoji(symbol: "📚", name: "Libros", description: "Una pila de libros", usage: "Aprendiendo")
        emoji.append(libros)
        let corazonRoto = Emoji(symbol: "💔", name: "Corazon roto", description: "Un corazon partido al medio", usage: "Esperanzas rotas")
        emoji.append(corazonRoto)
        let banderaDeCarreras = Emoji(symbol: "🏁", name: "Bandera de carreras", description: "Una bandera a cuadros", usage: "Carreras")
        emoji.append(banderaDeCarreras)
        let perro = Emoji(symbol: "🐶", name: "Perro", description: "Es un perro", usage: "Mascota")
        emoji.append(perro)
        let gato = Emoji(symbol: "🐱", name: "Gato", description: "Es un gato", usage: "Mascota")
        emoji.append(gato)
        let pizza = Emoji(symbol: "🍕", name: "Pizza", description: "Una porcion de pizza", usage: "Comida")
        emoji.append(pizza)
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return emoji.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as!
        EmojiTableViewCell
        let emojiIndex = emoji[indexPath.row]
        cell.update(with: emojiIndex)
        cell.showsReorderControl = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       let emojiSeleccionado = emoji.remove(at: sourceIndexPath.row)
       emoji.insert(emojiSeleccionado, at: destinationIndexPath.row)
       tableView.reloadData()
       Emoji.saveToFile(emojis: emoji)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji"{
            let indexPath = tableView.indexPathForSelectedRow!
            let emojiSeleccionado = emoji[indexPath.row]
            let navController = segue.destination as! UINavigationController
            
            let addEditEmojiTableViewController = navController.topViewController as!AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emojiSeleccionado
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emoji.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Emoji.saveToFile(emojis: emoji)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue){
        if segue.identifier == "saveUnwind"{
            let sourceViewController = segue.source as! AddEditEmojiTableViewController
            let emojiSeleccionado = sourceViewController.emoji
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    emoji[selectedIndexPath.row] = emojiSeleccionado
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                    Emoji.saveToFile(emojis: emoji)
                } else{
                    let newIndexPath = IndexPath(row: emoji.count, section: 0)
                    emoji.append(emojiSeleccionado)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                    Emoji.saveToFile(emojis: emoji)
                }
            }
        
    }
   
    
    

}
