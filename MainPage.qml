import QtQuick 2.0
import QtQuick.Controls 2.5



Page {
    id: mainPage
    visible: true
    width: 640
    height: 480

    // Модель данных для сотрудников
    ListModel {
        id: staffModel
    }

    Connections {
        target: mydb
        onStaffUpdated: {
            staffModel.clear(); // Очищаем модель
            for (let i = 0; i < data.length; i++) {
                let item = data[i];
                // Добавляем сотрудников в модель
                staffModel.append({
                    id: item.id,
                    name: item.name,
                    lastName: item.lastName,
                    surname: item.surname,
                    post: item.post,
                    number: item.number,
                    maritalStatus: item.maritalStatus
                });
                //console.log("Добавляем сотрудника:", item.name);
            }
        }
    }

    ScrollView {
        id: scrollView
        width: 500
        height: mainPage.height         // Задать высоту по окну
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 3
        anchors.topMargin: 3

        ListView {
            id: listView
            spacing: 3                  // Отступы между элементами
            model: staffModel


            delegate: Cell {
                id: delegat
                width: scrollView.width // Ширина ячейки
                height: 70               // Высота ячейки

                name: model.name
                lastName: model.lastName
                post: model.post

                idPerson: model.id
                surname: model.surname
                number: model.number
                maritalStatus: model.maritalStatus

            }

        }
    }

    Button {
        id: buttonAdd
        width:30
        height:30
        icon.source: "qrc:/res/icons8-добавить-32.png"
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15

        onClicked: {

            stackView.push("AdditionEmploy.qml")

        }
    }
}


