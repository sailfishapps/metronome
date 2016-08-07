/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0

import harbour.metronome.Components 1.0
import org.nemomobile.keepalive 1.0

import "../components"

Page {
    id: metronome

    width: parent.width
    height: parent.height

    property int currentBeat: 0
    property alias _beats: beats.value
    property int _bpm: tempo.value
    property alias _running: metronomeTimer.running

    onStatusChanged: {
        if (status === PageStatus.Activating) {
//            beats.maximumValue = storage.getValue("beats/to") == null ? 14 : storage.getValue("beats/to")
//            beats.minimumValue = storage.getValue("beats/from") == null ? 2 : storage.getValue("beats/from")
            tempo.maximumValue = storage.getValue("tempo/to") == null ? 300 : storage.getValue("tempo/to")
            tempo.minimumValue = storage.getValue("tempo/from") == null ? 30 : storage.getValue("tempo/from")
            tempo.stepSize = storage.getValue("tempo/step") == null ? 10 : storage.getValue("tempo/step")

            tempo.value = tempo.minimumValue
//            beats.value = beats.minimumValue
        }
    }

    Audio{ id: audio } // Using system volume

    SoundEffect{
        id: bip
        source: "qrc:/bip.wav"
        volume: audio.volume
    }

    SoundEffect {
        id: bop
        source: "qrc:/bop.wav"
        volume: audio.volume
    }

    Timer {
        id: metronomeTimer
        interval: 60000 / tempo.value
        repeat: true

        onTriggered: {
            currentBeat = (currentBeat + 1)%beats.value
            pie.selectSlice(currentBeat)
            if(currentBeat === 0) {
                bip.play()
                return
            }
            bop.play()
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: {
                    metronome._running = false
                    DisplayBlanking.preventBlanking = false

                    pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                }
            }
        }

        PageHeader {
            id: title
            title: "Metronome"
        }

        Column {
            width: parent.width - (Theme.paddingLarge * 2)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: title.bottom

            spacing: Theme.paddingLarge


            PieCircle {
                id: pie

                width: parent.width
                height: width

                color: Theme.primaryColor

                slices: beats.value

                Image {
                    anchors.centerIn: parent
                    source: metronomeTimer.running ? "image://theme/icon-l-pause" : "image://theme/icon-l-play"
                }

                MouseArea{
                    anchors.fill: parent

                    onPressed: pie.scale = 0.8

                    onReleased: pie.scale = 1
                    onCanceled: pie.scale =  1

                    onClicked: {
                        metronomeTimer.running = !metronomeTimer.running;
                        DisplayBlanking.preventBlanking = metronomeTimer.running;
                    }
                }

                Behavior on scale {
                    NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                }
            }

            MeterSelector {
                id: beats
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Slider{
                id: tempo

                width: parent.width
                valueText: qsTr("Tempo %1 bpm").arg(value)
            }
        }
    }
}


