import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id: storage

    property var db: null

    function openDB() {
        if(db != null) return;
        db = LocalStorage.openDatabaseSync("harbour-scientific-calculator", '', "calc storage", 100000);
        // DB VERSIONING
        if (db.version == '') {
            db.changeVersion('', 1, function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(key TEXT PRIMARY KEY, value TEXT)');
            });
        }
    }

    function setValue(key, value) {
        openDB();
        db.transaction(function(tx){
            var res = tx.executeSql('INSERT OR REPLACE INTO Settings (key, value) VALUES (?, ?)', [key, value]);
        })
    }

    function getValue(key){
        openDB();
        var res;
        db.transaction(function(tx){
            res = tx.executeSql('SELECT * FROM Settings WHERE key=?', [key]);
        });
        if (res.rows.length == 0)
            return null;
        return res.rows.item(0).value;
    }
}
