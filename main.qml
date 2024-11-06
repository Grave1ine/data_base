import QtQuick 2.12
import QtQuick.Controls 2.5



ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Сотрудники")      //заголовок


    StackView {
        id: stackView
        initialItem: "MainPage.qml"   //указание что  этас траница первая в стеке
        anchors.fill: parent
    }


}
