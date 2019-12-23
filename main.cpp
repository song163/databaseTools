#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "database/data_base_helper.h"
#include <QQmlEngine>
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_DisableShaderDiskCache);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
//   QQmlEngine qmlengine;
     engine.rootContext()->setContextProperty("dataBase",     DatabaseHelper::instance());
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
