import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.3

Page {
    id: redactWindow
    visible: true
    width: 400
    height: 700

    property string name: ""
    property string lastName: ""
    property string post: ""

    property int idPerson: 0
    property string surname: ""
    property string number: ""
    property string maritalStatus: ""


    function handleEditData(idPerson, name, lastName, surname, post, number, maritalStatus) {
        redactWindow.idPerson = idPerson;
        redactWindow.name = name;
        redactWindow.lastName = lastName;
        redactWindow.surname = surname;
        redactWindow.post = post;
        redactWindow.number = number;
        redactWindow.maritalStatus = maritalStatus;
    }

    Component.onCompleted: {                                      //создание компонента и его исполнение
        if (stackView.currentItem && stackView.currentItem.data) {//проверяет наличие текущего элемента в stackView и наличие у этого элемента свойства data
            handleEditData(
                        stackView.currentItem.data.idPerson,
                        stackView.currentItem.data.name,
                        stackView.currentItem.data.lastName,
                        stackView.currentItem.data.surname,
                        stackView.currentItem.data.post,
                        stackView.currentItem.data.number,
                        stackView.currentItem.data.maritalStatus
                        );
        }
    }


    Rectangle{
        id: back
        anchors.fill: parent


        Item {
            id: blokChect
            enabled: false                 //блокирует область


            TextField {
                id: textFieldName
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 15
                text: name
                onTextChanged: {name = text} //при завершении ввода текст из поля ввода input копируется в элемент Text.

            }


            TextField {
                id: textFieldFamily
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldName.bottom
                anchors.topMargin: 30
                text: lastName
                onTextChanged: {lastName = text}

            }

            TextField {
                id: textFieldSecondName
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldFamily.bottom
                anchors.topMargin: 30
                text: surname
                onTextChanged: {surname = text}

            }

            TextField {
                id: textFieldJobTitle
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldSecondName.bottom
                anchors.topMargin: 30
                text: post
                onTextChanged: {post = text}

            }

            TextField {
                id: textFieldNomber
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldJobTitle.bottom
                anchors.topMargin: 30
                text: number
                onTextChanged: {number = text}

                inputMask:"+8(999)-999-9999"   //маска ввода

            }

            TextField {
                id: textFieldStatus
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: textFieldNomber.bottom
                anchors.topMargin: 30
                text: maritalStatus
                onTextChanged: {maritalStatus = text}

            }

            Text {
                id: element
                x: 15
                y: 30
                text: qsTr("Имя")
                anchors.bottom: textFieldName.top
                anchors.bottomMargin: 5
                font.pixelSize: 12
            }

            Text {
                id: element1
                x: 15
                y: 100
                text: qsTr("Фамилия")
                anchors.bottom: textFieldFamily.top
                anchors.bottomMargin: 5
                font.pixelSize: 12
            }

            Text {
                id: element2
                x: 15
                y: 150
                text: qsTr("Отчество")
                anchors.bottom: textFieldSecondName.top
                anchors.bottomMargin: 5
                font.pixelSize: 12
            }

            Text {
                id: element3
                x: 15
                y: 220
                text: qsTr("должноссть")
                anchors.bottom: textFieldJobTitle.top
                anchors.bottomMargin: 5
                font.pixelSize: 12
            }

            Text {
                id: element4
                x: 15
                y: 290
                text: qsTr("номер телефона")
                anchors.bottom: textFieldNomber.top
                anchors.bottomMargin: 5
                font.pixelSize: 12
            }

            Text {
                id: element5
                x: 15
                y: 360
                text: qsTr("семейное положение")
                anchors.bottom: textFieldStatus.top
                anchors.bottomMargin: 5
                font.pixelSize: 12
            }
        }

        Button {
            id: redactButton
            width: 30
            height: 30
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 15
            icon.source: "qrc:/res/icons8-редактировать-свойство-50.png"

            onPressed: {
                blokChect.enabled = true                          //разрешаем редактирование


            }
        }

        Button {
            id: saveButtom
            x: 0
            width: 30
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.top: redactButton.bottom
            anchors.topMargin: 30
            icon.source: "qrc:/res/icons8-сохранить-50.png"

            onPressed: {
                blokChect.enabled = false                     //запрещаем редактирование
                console.log("id:", idPerson);
                console.log("Name:", name);
                console.log("Last Name:", lastName);
                console.log("Surname:", surname);
                console.log("Post:", post);
                console.log("Number:", number);
                console.log("Marital Status:", maritalStatus);
                console.log("#################################");

                var data = {
                    id: idPerson,
                    name: name,
                    lastName: lastName,
                    surname: surname,
                    post: post,
                    number: number,
                    maritalStatus: maritalStatus
                }
                mydb.changeStaff(data);
            }

        }

        Button {
            id: deleteButton
            x: 266
            width: 30
            height: 30
            text: qsTr("Button")
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.top: saveButtom.bottom
            anchors.topMargin: 30
            icon.source: "qrc:/res/icons8-мусор-50.png"

            onPressed: {
            mydb.deleteStaff(idPerson)
                stackView.pop()
                console.log("id:", idPerson);
            }

        }

        Button {
            id: backButton
            x: 355
            y: 150
            width: 30
            height: 30
            anchors.top: deleteButton.bottom
            anchors.topMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 15
            icon.source: "qrc:/res/back.png"

            onPressed: {
                stackView.pop()               //выходим из страницы редактирования

            }
        }
    }
}




