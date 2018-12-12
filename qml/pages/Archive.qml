import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page1

//    Baza { id: baza }
//    ArchiveBaza { id: archBaza }

//    // Функция для удаления привычки
//    function removeHabit(el) {
//        aw.archBaza.deleteTable(el.id)
//    }
//    // Функция переноса в активные
//    function addHabitToActive(el) {
//        aw.archBaza.insertTable(el.id)
//        aw.baza.deleteTable(el.id)
//    }

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        model: aw.archiveHabits //archBaza
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Archive")

        }
        delegate: ListItem {
            width: ListView.view.width
            Row {
                x: Theme.horizontalPageMargin
                Label {
                    id: label
                    text: model.habit
                    color: Theme.primaryColor
                    //BackgroundItem: "black"
                    //anchors.verticalCenter: parent.verticalCenter
                    //anchors.left: image.right
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: "Restore"
                    onClicked: {//addHabitToActive(model.id)
                        aw.activeHabits.insertTable(model.habit)
                        aw.archiveHabits.deleteTable(model.id)
                        aw.activeHabits.append(aw.archiveHabits.get(model.index))
                        aw.archiveHabits.remove(model.index)
                    }
                }
                MenuItem {
                    text: "Delete"
                    onClicked: {//removeHabit(model.id)
                        aw.archiveHabits.deleteTable(model.id)
                        aw.archiveHabits.remove(model.index)
                    }
                }
            }
        }

        VerticalScrollDecorator {}
    }
}
