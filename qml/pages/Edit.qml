import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string habit
    property int index
    property int id
    property int mark

    Column {
        width: parent.width
        DialogHeader { }

        TextField {
            id: newName
            text: habit
            color: Theme.highlightColor
            width: parent.width
            placeholderText: "Place to set a new name"
            label: "name"
        }
    }

    onDone: if (result == DialogResult.Accepted) {
                aw.activeHabits.set(index, {"habit": newName.text,
                                        "id": id, "mark": 1})
                aw.activeHabits.updateTable(id, newName.text, 1)
            }
}

