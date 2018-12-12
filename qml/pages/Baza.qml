import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

ListModel {
    property var database;

    // Функция добавления привычки в конец списка
    function appendHabit(el) {
        aw.baza.insertTable(el.name)
        aw.baza.updateTable(el.id, el.name, el.mark)
    }

    // Функция обертка для редактирования привычки
    function editHabit(el) {
        pageStack.push(Qt.resolvedUrl("AddNew.qml"))
        aw.baza.deleteTable(el.id)
    }
    // Функция для удаления привычки
    function removeHabit(el) {
        aw.baza.deleteTable(el.id)
    }
    // Функция переноса в архив
    function addHabitToArchive(el) {
        aw.archBaza.insertTable(el.id)
        aw.baza.deleteTable(el.id)
    }

    // Изменение статуса привычки
    function updateMark(el) {
        var mark = get(el.idx).mark
//        console.log(mark)
        mark = 1 - mark
//        console.log(mark)
//        console.log(el.idx, el.id, el.habit, mark)
        set(el.idx, {"id": el.id, "habit": el.habit, "mark": mark})
//        console.log(get(el.idx).id, get(el.idx).habit, get(el.idx).mark)
        aw.activeHabits.updateTable(el.id, el.habit, mark)
    }

    // Функция уничтожение таблицы
    function destroyTabel(name) {
        database.transaction(function(tx) {
            tx.executeSql("DROP TABLE super;");
        });
    }
    // Функция создания таблицы(если не созданна) Элементы: id, name, mark
    function createTable(name) {
        database.transaction(function(tx) {
            var result = tx.executeSql("CREATE TABLE IF NOT EXISTS super (
                       id  INTEGER PRIMARY KEY AUTOINCREMENT,"
                          + "name TEXT NOT NULL,"
                          + "mark INTEGER NOT NULL);");
        });
    }
    // Функция для извлечения данных
    function retriveTable(callback) {
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM super ORDER BY id DESC;");
            callback(result.rows)
        });
    }
    // Функция добавления объекта в список
    function insertTable(name){
        database.transaction(function(tx) {
            var result = tx.executeSql("INSERT INTO super (name, mark) VALUES (?, ?);", [name, 0]);
        });
    }
    // Обновление объекта
    function updateTable(id, name, mark){
        database.transaction(function(tx) {
            tx.executeSql("UPDATE super SET name = ?, mark = ? WHERE id = ?;", [name, mark, id]);});
    }
    // Удаление объекта
    function deleteTable(id){
        database.transaction(function(tx) {
            var rs = tx.executeSql("DELETE FROM super WHERE id = ?;", [id]);
        });
    }



//    function init()
//    {
//        //        console.log("Ку-ку")

//        // Открываем базу
//        database = LocalStorage.openDatabaseSync("super", "1.0")
//        //        console.log("Ку-ку2")

//        // Создаем таблицу(если необходимо)
//        createTable();
//        //        console.log("Ку-ку3")

//        // Достаем из базы содержимое таблицы привычек
//        // В цикле добавляем в модель привычки через append()
//        retriveTable(function(rows){
////            console.log("start print")
////            console.log(JSON.stringify(rows))
//            console.log(rows.length)
//            for (var i = 0; i < rows.length; i++)
//                append({"habit": rows.item(i).name})
//        })

//    }

    Component.onCompleted: {
        //        console.log("Ку-ку")

        // Открываем базу
        database = LocalStorage.openDatabaseSync("super", "1.0")
        //        console.log("Ку-ку2")

        // уничтожаем неудачную версию таблицы
//        destroyTabel()

        // Создаем таблицу(если необходимо)
        createTable();
        //        console.log("Ку-ку3")
//                insertTable("Ванная")
//                insertTable("СОН")
        // Достаем из базы содержимое таблицы привычек
        // В цикле добавляем в модель привычки через append()
        retriveTable(function(rows){
//            console.log("start print")
//            console.log(JSON.stringify(rows))
            for (var i = 0; i < rows.length; i++) {
                append({"habit": rows.item(i).name, "id": rows.item(i).id, "mark": rows.item(i).mark})
//                console.log(rows.item(i).name + ":" + rows.item(i).id + ":" + rows.item(i).mark)
            }
        })
//        console.log(count)
        //        console.log("Ку-ку4")



//        //        console.log("Ку-ку5")

//        // Достаем из базы содержимое таблицы привычек
//        // В цикле добавляем в модель привычки через append()
//        retriveTable(function(rows){
//            //            for (var i = 0; i < rows.length; i++){
//            //                var message = rows.item(i);
//            //                dao.append({id: message.id, name: message.name});
//            //            }

//            console.log(JSON.stringify(rows.item(0)))
//            //            console.log(JSON.stringify({ "test": 123, "others": [ { "abc": 1 }, { "xyz": 999 } ] }))
//        })
//        console.log("Ку-ку6")
    }

}
