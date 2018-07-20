import QtQuick 2.0
import QtQuick.Window 2.0

// from https://github.com/rschroll/qhttpserver
import HttpServer 1.0

Item {
    id: root
    width: Screen.width
    height: Screen.height

    HttpServer {
        id: server
        Component.onCompleted: listen("127.0.0.1", 5000)
        onNewRequest: { 
            var route = /^\/\?/;
            if ( route.test(request.url) ) {
                response.writeHead(200)
                response.write(editor.text)
                response.end()
            } 
            else { 
                response.writeHead(404)
                response.end()
            }
        }
    }

    Timer {
        id: timer
        interval: 500; running: true; repeat: false
        onTriggered: viewLoader.setSource('http://localhost:5000/?'+Math.random()) // workaround for cache
    }

    Rectangle { 
        id: background
        width: root.width/2
        height: root.height
        anchors { top: parent.top; left: parent.left; bottom: parent.bottom }
        color: '#1d1f21'

        TextEdit {
            id: editor
            anchors { fill: parent; margins: 20 } 
            wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere;
            onTextChanged: timer.restart();

            // style from Atom dark theme: 
            // https://github.com/atom/atom-dark-syntax/blob/master/stylesheets/syntax-variables.less
            color: '#c5c8c6'
            selectionColor: '#444444'
            selectByMouse: true
            font { pointSize: 16; family: 'Monaco' }

            text:   "import QtQuick 2.0\n" + "Rectangle { anchors.fill: parent; color: '#ff0000' }"
        }
    }
    Item {
        width: root.width/2
        height: root.height
        anchors { top: parent.top; left: background.right; bottom: parent.bottom }
        Loader {
            id: viewLoader
            anchors.fill: parent
        }
    }
}
