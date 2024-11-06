import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.3


Page {
    id: addWindow
    visible: true
    width: 400
    height: 700


    Rectangle {
        id: back
        anchors.fill: parent

        Item {
            id: blokChect



            TextField {
                id: textFieldName
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 15
                onTextChanged: textFieldName.text = text
            }

            TextField {
                id: textFieldFamily
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldName.bottom
                anchors.topMargin: 30
                onTextChanged: textFieldFamily.text = text
            }

            TextField {
                id: textFieldSecondName
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldFamily.bottom
                anchors.topMargin: 30
                onTextChanged: textFieldSecondName.text = text
            }

            TextField {
                id: textFieldJobTitle
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldSecondName.bottom
                anchors.topMargin: 30
                onTextChanged: textFieldJobTitle.text = text
            }

            TextField {
                id: textFieldNumber
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldJobTitle.bottom
                anchors.topMargin: 30
                inputMask: "+8(999)-999-9999" // Маска ввода
                //onTextChanged: textFieldNumber.text = text
            }

            TextField {
                id: textFieldStatus
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldNumber.bottom
                anchors.topMargin: 30
                onTextChanged: textFieldStatus.text = text
            }

            // Элементы текста
            Text { text: qsTr("Имя"); anchors.left: parent.left; anchors.leftMargin: 15; anchors.bottom: textFieldName.top; anchors.bottomMargin: 5; font.pixelSize: 12 }
            Text { text: qsTr("Фамилия"); anchors.left: parent.left; anchors.leftMargin: 15; anchors.bottom: textFieldFamily.top; anchors.bottomMargin: 5; font.pixelSize: 12 }
            Text { text: qsTr("Отчество"); anchors.left: parent.left; anchors.leftMargin: 15; anchors.bottom: textFieldSecondName.top; anchors.bottomMargin: 5; font.pixelSize: 12 }
            Text { text: qsTr("Должность"); anchors.left: parent.left; anchors.leftMargin: 15; anchors.bottom: textFieldJobTitle.top; anchors.bottomMargin: 5; font.pixelSize: 12 }
            Text { text: qsTr("Номер телефона"); anchors.left: parent.left; anchors.leftMargin: 15; anchors.bottom: textFieldNumber.top; anchors.bottomMargin: 5; font.pixelSize: 12 }
            Text { text: qsTr("Семейное положение"); anchors.left: parent.left; anchors.leftMargin: 15; anchors.bottom: textFieldStatus.top; anchors.bottomMargin: 5; font.pixelSize: 12 }
        }


    }

    Button {
        id: createButton
        width: 30
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 15
        icon.source: "qrc:/res/icons8-сохранить-в-сетке-50.png"

        onPressed: {
            var cleanedNumber = textFieldNumber.text.replace(/[^0-9]/g, ''); // Убираем все нецифровые символы
            var data = {
                name: textFieldName.text,
                lastName: textFieldFamily.text,
                surname: textFieldSecondName.text,
                post: textFieldJobTitle.text,
                number: parseInt(cleanedNumber) || 0,
                maritalStatus: textFieldStatus.text
            }
            mydb.newStaff(data);
        }
    }


    Button {
        id: backButton
        width: 30
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: createButton.bottom
        anchors.topMargin: 30
        icon.source: "qrc:/res/back.png"

        onPressed: {
            stackView.pop(); // Возврат
        }
    }



}








/*##^##
Designer {
    D{i:3;anchors_x:37;anchors_y:52}D{i:4;anchors_x:37;anchors_y:124}D{i:5;anchors_x:37;anchors_y:196}
D{i:6;anchors_x:37;anchors_y:270}D{i:7;anchors_x:37;anchors_y:344}D{i:8;anchors_x:37;anchors_y:416}
D{i:9;anchors_x:15}D{i:16;anchors_y:32}
}
##^##*/

