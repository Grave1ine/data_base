import QtQuick 2.0
import QtQuick.Controls 2.5


ItemDelegate {
    id: cell

    property string name: ""
    property string lastName: ""
    property string post: ""

    property int idPerson: 0
    property string surname: ""
    property string number: ""
    property string maritalStatus: ""


    Rectangle {
        id: background
        radius: 10
        width: 500
        height: 70
        color: "#C0C0C0"
        border.color: "#87CEEB"
        border.width: 3

        Grid {
            id: abc
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            columns: 1
            rows: 3
            spacing: 5

            Text {
               id: name
               text: cell.name      // Привязка к свойству name
               font.pixelSize: 14
               color: "#000000"
            }

            Text {
                id: lastName
                text: cell.lastName // Привязка к свойству lastName
                font.pixelSize: 14
                color: "#000000"
            }

            Text {
                id: post
                text: cell.post     // Привязка к свойству post
                font.pixelSize: 14
                color: "#000000"
            }
        }

        Button {
            id: buttonDetail

            width: 30
            height: 30

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 40
            icon.source: "qrc:/res/next.png"

            onClicked: {

                console.log("Name:", cell.name);
                console.log("Last Name:", cell.lastName);
                console.log("Surname:", cell.surname);
                console.log("Post:", cell.post);
                console.log("Number:", cell.number);
                console.log("Marital Status:", cell.maritalStatus);
                console.log("#################################");


                stackView.push("EditWindow.qml", {
                    idPerson:cell.idPerson,
                    name: cell.name,
                    lastName: cell.lastName,
                    surname: cell.surname,
                    post: cell.post,
                    number: cell.number,
                    maritalStatus: cell.maritalStatus
                });

            }

        }


    }


}


