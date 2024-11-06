#ifndef MYDB_H
#define MYDB_H

#include <QObject>
#include <QtSql/QSqlDatabase>
//класс бд
class MyDB : public QObject
{
    Q_OBJECT

private:
    QSqlDatabase db;
public:
    explicit MyDB(QObject *parent = nullptr);

    void printTable();      //вывод таблицы в консоль(пока не прикручу к qml)

signals:
    //сигнал для передачи данных в qml
    void staffUpdated(const QVariant &data);

public slots:
    void newStaff(const QVariantMap & staff); //добавление сотрудника

    void changeStaff(const QVariantMap & staff);//изменение данных сотрудника

    void deleteStaff(int id); //удаление сотрудника


};

#endif // MYDB_H
