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
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets


Item {
	id: menuItem
	height: childrenRect.height

	signal clicked()
	signal entered()
	signal addFavorite()
	signal removeFavorite()
	signal moveFavoriteDown()
	signal moveFavoriteUp()

	property string iconName
	property alias name: label.text
	property alias genericName: subLabel.text
	property string entryPath
	property bool isApp: true
    property int leftSideMargin: 6
    property bool isEditing: false
    property int iconSize: 22
    property int smallIconSize: 16
    property int fontPointSize: 18
	property bool showDescription: true	

	Item { // don't use Row so that we can add a left margin to icon
		id: row
		width: parent.width
        height: icon.height + leftSideMargin // use fixed height because otherwise menuListView.contentHeight is not calculated correctly (and even varies during scroll)

        Item {
			id: icon
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: leftSideMargin
			width: iconSize
			height: iconSize
            PlasmaWidgets.IconWidget {
                anchors.fill: parent
                Component.onCompleted: {
                    setIcon(iconName)
                }
            }
		}

		Column {
			id: column
			anchors.left: icon.right
			anchors.verticalCenter: icon.verticalCenter;
            anchors.leftMargin: leftSideMargin

			PlasmaComponents.Label {
				id: label
                width: menuItem.width - 2 * leftSideMargin - icon.width - (arrowLoader.sourceComponent == arrow ? arrowLoader.width + leftSideMargin : 0)
				height: theme.defaultFont.mSize.height
                font.pointSize: fontPointSize
                elide: Text.ElideRight
                color: "white"
			}

			PlasmaComponents.Label {
				id: subLabel
                anchors {
                    top:label.bottom
                    topMargin:3
                }
				width: label.width
				height: showDescription ? label.height : 0
                font.pointSize: 8
                opacity: 0.8
				visible: showDescription && text != ""
				elide: Text.ElideRight
                color: "#FF6C00"

			}
		}

		Loader {
			id: arrowLoader
			sourceComponent: isApp ? undefined : arrow
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: leftSideMargin
		}
		Component {
			id: arrow
			RightArrow {
				size: smallIconSize
			}
		}
	}


	MouseArea {
		anchors.fill: parent
        hoverEnabled: true
        visible: true
        onClicked: {
            forceActiveFocus()
            menuItem.clicked()
            if (menuItem.isApp) {
                main.reset()
            }
        }
        onEntered: menuItem.entered();
        onPressed: {label.color = "#FF6C00";}
        onPressAndHold: {label.color = "#FF6C00";}
        onReleased: {label.color = "white";}
	}


}
