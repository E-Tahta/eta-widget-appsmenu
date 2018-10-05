/*****************************************************************************
 *   Copyright (C) 2018 by Yunusemre Şentürk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/

import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents

Item {
    id: title
    height: 28

    signal itemSelected(int index)

    property int currentIndex
    property int fontPointSize
    property int leftSideMargin : 6

    function insert(index, value) {
        repeater.model.insert(index, {"text" : value});
    }
    function set(index, value) {
        repeater.model.set(index, {"text" : value});
    }
    function remove(index) {
        if (repeater.model.count > index)
            repeater.model.remove(index);
    }
    function text(index) {
        return repeater.model.get(index).text;
    }

    Row {
        id: row
        width: parent.width
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 1
        spacing: 3

        Repeater {
            id: repeater
            model: ListModel {}
            delegate: Rectangle {
                color: title.currentIndex === index ? "#FF6C00" : "#6d6f76"
                radius: 3
                width: title.width / repeater.count - 2
                height: title.height
                PlasmaComponents.Label {
                    id: text
                    width: parent.width - 12
                    anchors.centerIn: parent
                    font.pointSize: title.fontPointSize * 2 / 3
                    //font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData.toUpperCase()
                    elide: Text.ElideRight
                    color: "#ffffff"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        forceActiveFocus()
                        title.itemSelected(index)
                    }
                }
            }
        }
        add: Transition {
            NumberAnimation {
                properties: "x, width"
                duration: 150
                easing.type: Easing.Linear
            }
        }
        move: Transition {
            NumberAnimation {
                properties: "x, width"
                duration: 150
                easing.type: Easing.Linear
            }
        }
    }
}
