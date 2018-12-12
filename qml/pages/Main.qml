import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        anchors.fill: parent
//        Image {
//            anchors.fill: parent;
//            source: "img/wallpaper.jpg"
//            fillMode: Image.PreserveAspectCrop
//        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Add new")
                onClicked: pageStack.push(Qt.resolvedUrl("AddNew.qml"))
            }
            MenuItem {
                text: qsTr("Show archive")
                onClicked: pageStack.push(Qt.resolvedUrl("Archive.qml"))
            }
        }

        model: aw.activeHabits // Baza
        header: PageHeader {
            title: qsTr("Active")
        }
        delegate: ListItem{
            x: {
                Theme.horizontalPageMargin
                Theme.paddingLarge
            }
            Label {
               id: markLabel
               anchors.left: parent.left
               text: model.mark === 1 ? "✔" : "✘"
               color:  model.mark === 1 ? "lightgreen" : "red"
//               opacity: 1
            }
            Label {
                id: namLabel
                text: model.habit
                anchors.left: markLabel.right
                color: Theme.primaryColor
//                opacity: 1
            }

            onClicked:{
//                console.log("Пришли", model.mark)
                aw.activeHabits.updateMark({"id": model.id, "habit": model.habit, "idx": model.index})
//                console.log("Ушли", model.mark)
            }

            menu: ContextMenu {
                MenuItem {
                    text: "Edit"
                    onClicked: {
                        onClicked: pageStack.push(Qt.resolvedUrl("Edit.qml"), {"habit": model.habit, "id": model.id, "index": model.index})
                    }//editHabit(model.id)
                }
                MenuItem {
                    text: "Add to archive"
                    onClicked: { //addHabitToArchive(model.id)
                        aw.archiveHabits.insertTable(model.habit)
                        aw.activeHabits.deleteTable(model.id)
                        aw.archiveHabits.insert(0, aw.activeHabits.get(model.index))
                        aw.activeHabits.remove(model.index)
                    }
                }
                MenuItem {
                    text: "Remove"
                    onClicked: { //removeHabit(model.id)
                        console.log(model.id)
                        aw.activeHabits.deleteTable(model.id)
                        aw.activeHabits.remove(model.index)
                    }
                }
            }
        }
        Component.onCompleted: {
//            aw.activeHabits.init()
//            console.log(model.count)
        }
        VerticalScrollDecorator {}
    }
}
