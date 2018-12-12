import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

ListModel {
    property var database;

// Функция создания таблицы(если не созданна) Элементы: id, name, mark
    function createTable(name) {
        database.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS old (
                       id  INTEGER PRIMARY KEY AUTOINCREMENT,"
                          +"name TEXT NOT NULL);")
        });
    }
// Функция для извлечения данных
    function retriveTable(callback) {
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM old ORDER BY id DESC;");
//            console.log(JSON.stringify(result))
//            console.log(result.rows.length)
            callback(result.rows)
        });
    }

// Функция добавления объекта в список
    function insertTable(name){
        database.transaction(function(tx) {
            var result = tx.executeSql("INSERT INTO old (name) VALUES (?);", [name]);
//            console.log(JSON.stringify(result))
        });

    }

// Обновление объекта
    function updateTable(id, name){
        database.transaction(function(tx) {
            tx.executeSql("UPDATE old SET name = ? WHERE id = ?;", [name, id]);});
    }

// Удаление объекта
    function deleteTable(id){
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM old WHERE id = ?;", [id])
            ;});
    }

    Component.onCompleted: {
//        console.log("Ку-ку")

// Открываем базу
        database = LocalStorage.openDatabaseSync("old", "1.0")
//        console.log("Ку-ку2")

// Создаем таблицу(если необходимо)
        createTable();
//        console.log("Ку-ку3")

        // Достаем из базы содержимое таблицы привычек
        // В цикле добавляем в модель привычки через append()
//        retriveTable(function(rows){
//            console.log("start print")
//            console.log(JSON.stringify(rows))
//        })
//        console.log("Ку-ку4")

//        insertTable("Ванная")
//        insertTable("СОН")

//        console.log("Ку-ку5")

        // Достаем из базы содержимое таблицы привычек
        // В цикле добавляем в модель привычки через append()
        retriveTable(function(rows){
//            console.log(rows.length)
            for (var i = 0; i < rows.length; i++){
                var message = rows.item(i);
                append({"id": message.id, "habit": message.name});
//                console.log(rows.item(i).name + ":" + rows.item(i).id)
            }

//            console.log(JSON.stringify(rows.item(0)))
            //            console.log(JSON.stringify({ "test": 123, "others": [ { "abc": 1 }, { "xyz": 999 } ] }))
        })
//        console.log("Ку-ку6")




    }

}
