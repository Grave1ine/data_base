#include "mydb.h"
#include <QtSql/QSqlDatabase>  // Инструменты работы с базой данных
#include <QtSql/QSqlQuery>     // Класс для выполнения SQL-запросов
#include <QtSql/QSqlError>     // Обработка ошибок
#include <QDebug>


MyDB::MyDB(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");  // Используем SQL-движок SQLite
    db.setDatabaseName("example.db");           // Устанавливаем имя базы данных
    if (!db.open()) {
        qDebug() << "Ошибка: " << db.lastError().text();
        exit(-1);
    }

    QSqlQuery q;  // Создаем объект для выполнения SQL-запросов
    if (!q.exec("CREATE TABLE IF NOT EXISTS staff (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, lastName TEXT, "
                "surname TEXT, post TEXT, number TEXT, maritalStatus TEXT)")) {
        qDebug() << "Ошибка: " << q.lastError().text();
        exit(-1);
    }
}

void MyDB::newStaff(const QVariantMap& staff)               //добавление сотрудника
{
    QSqlQuery q;
    q.prepare("INSERT INTO staff (name, lastName, surname, post, number, maritalStatus) "
              "VALUES (:name, :lastName, :surname, :post, :number, :maritalStatus)");
    q.bindValue(":name", staff["name"]);
    q.bindValue(":lastName", staff["lastName"]);
    q.bindValue(":surname", staff["surname"]);
    q.bindValue(":post", staff["post"]);
    q.bindValue(":number", staff["number"]);
    q.bindValue(":maritalStatus", staff["maritalStatus"]);
    qDebug() << "New staff" << staff;
    if (!q.exec()) {
        qDebug() << "Ошибка: " << q.lastError().text();
    }
    printTable();
}

void MyDB::changeStaff(const QVariantMap& staff)              //редактирование данных сотрудника
{
    QSqlQuery q;
    q.prepare("UPDATE staff SET name = :name, lastName = :lastName, surname = :surname, post = :post, "
              "number = :number, maritalStatus = :maritalStatus WHERE id = :id");
    q.bindValue(":name", staff["name"]);
    q.bindValue(":lastName", staff["lastName"]);
    q.bindValue(":surname", staff["surname"]);
    q.bindValue(":post", staff["post"]);
    q.bindValue(":number", staff["number"]);
    q.bindValue(":maritalStatus", staff["maritalStatus"]);
    q.bindValue(":id", staff["id"]);
    qDebug() << "Change staff" << staff;
    if (!q.exec()) {
        qDebug() << "Ошибка: " << q.lastError().text();
    }
    printTable();
}

void MyDB::deleteStaff(int id)                         //удаление сотрудника
{
    QSqlQuery q;
    q.prepare("DELETE FROM staff WHERE id = :id");
    q.bindValue(0, id);
    if (!q.exec()) {
        qDebug() << "Ошибка: " << q.lastError().text();
    }
    printTable();
}

void MyDB::printTable()                              //извлекает информация из бд и отправляет в qml
{
    QSqlQuery q;
    QVariantList staffs;

    if (q.exec("SELECT * FROM staff")) {
        while (q.next()) {
            QVariantMap staff;
            staff["id"] = q.value(0).toInt();
            staff["name"] = q.value(1).toString();
            staff["lastName"] = q.value(2).toString();
            staff["surname"] = q.value(3).toString();
            staff["post"] = q.value(4).toString();
            staff["number"] = q.value(5).toString();
            staff["maritalStatus"] = q.value(6).toString();
            staffs.append(staff);
        }
    } else {
        qDebug() << "Ошибка: " << q.lastError().text();
        exit(-1);
    }

    emit staffUpdated(staffs);   //генерация сигнала
}
