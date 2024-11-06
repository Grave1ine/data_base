#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include "mydb.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


    QGuiApplication app(argc, argv);
   //qRegisterMetaType<Staff>();         //регистрация структуры для qml
    MyDB mydb;                                 //класс для работы с бд (провайдер данных)

    QQmlApplicationEngine engine;
    //передаем объект в qml
    engine.rootContext()->setContextProperty("mydb", &mydb);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    //загружаем qml файл
    engine.load(url);
    mydb.printTable();
    return app.exec();
}
