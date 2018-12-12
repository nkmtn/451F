import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string varia

    Column {
        width: parent.width
        DialogHeader { }

        TextField {
            id: newName
            color: Theme.highlightColor
            width: parent.width
            placeholderText: "Place to set a new name"
            label: "name"
        }
    }
    onDone: if (result == DialogResult.Accepted) {
                aw.activeHabits.insert(0, {"habit":newName.text, "mark": 0})
                aw.activeHabits.insertTable(newName.text)
            }
}
