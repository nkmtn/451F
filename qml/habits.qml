import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "pages"

ApplicationWindow
{
    id: aw

    property Baza activeHabits: Baza {}
    property ArchiveBaza archiveHabits: ArchiveBaza {}

//    property ListModel activeHabits: ListModel {
//        ListElement {
//            habit: "Ванная"
//            mark: false
//            reminder: ""
//        }
//        ListElement {
//            habit: "Сон"
//            mark: false
//            reminder: ""
//        }
//        ListElement {
//            habit: "Вино"
//            mark: true
//            reminder: ""
//        }
//    }

//    property ListModel archiveHabits: ListModel {
//        ListElement {
//            habit: "Встать с дивана"
//        }
//        ListElement {
//            habit: "Прочитать ту самую книгу"

//        }
//    }

    initialPage: Component { Main { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations


}
