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
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets



Item {
    id: widgetrepresenter
    property int minimumWidth: screenData.data["Local"]["width"] * 14 / 100
    property int minimumHeight: screenData.data["Local"]["width"] * 7 / 200
    property int leftrightAlign: minimumWidth * 9 / 100
    property int lineAlign: minimumWidth * 7 / 100
    property int textAlign: minimumWidth * 4 / 100
    property int topPartHeight: screenData.data["Local"]["height"] * 17 / 100


    Rectangle {
        id: allapps
        anchors.fill: parent
        color: "#6d6f76"
        Row {
            anchors {
                top: parent.top
                topMargin: 0
                fill: parent
            }
            Item {
                id: toolbuttonappcontainer
                width: minimumWidth * 21 / 100
                height: width
                anchors {
                    left: parent.left
                    leftMargin: leftrightAlign
                    verticalCenter: parent.verticalCenter
                }
                PlasmaWidgets.IconWidget {
                    id: appIcon
                    anchors.fill: parent
                    onClicked: {
                        plasmoid.togglePopup()
                    }
                    Component.onCompleted: {
                        setIcon("eta-start-menu")
                    }
                }
            }
            Item {
                anchors {
                    left: toolbuttonappcontainer.right
                    leftMargin: textAlign
                    verticalCenter: parent.verticalCenter
                }
                Text {
                    id: allappstext
                    font.family: textFont
                    text: "TÜM\nUYGULAMALAR"
                    verticalAlignment: Text.AlignVCenter
                    color: "#ffffff"
                    font.bold: true
                    elide: Text.ElideLeft
                    horizontalAlignment: Text.AlignLeft
                    anchors {
                        left: parent.left
                        leftMargin: 0
                        verticalCenter: parent.verticalCenter
                        verticalCenterOffset: 0
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        plasmoid.togglePopup()
                    }
                }
            }
        }
    }

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
    }

    PlasmaCore.DataSource {
        id: userDataSource
        engine: "userinfo"
        connectedSources: ["Local"]
        interval: 500
    }
}
