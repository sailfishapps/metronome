#include "piecircle.h"

#include <QDebug>

PieCircle::PieCircle(QQuickItem *parent) :
    QQuickPaintedItem(parent),
    _selectedSlice(0),
    _slices(4)
{
    connect(this, SIGNAL(colorChanged()), this, SLOT(update()));
    connect(this, SIGNAL(slicesChanged()), this, SLOT(update()));
}

void PieCircle::paint(QPainter *painter)
{
    painter->setPen(Qt::NoPen);

    QColor brushColor = _color;
    brushColor.setAlpha(255/4);
    QBrush brush;
    brush.setStyle(Qt::SolidPattern);
    brush.setColor(brushColor);
    painter->setBrush(brush);

    double angle = 360 / _slices;
    double currentAngle = 90 + (angle / 2);

    for (int i = 0; i < _slices; ++i) {

        if(i == _selectedSlice){
            painter->save();

            if (i == 0){
                QColor g(0, 255, 0, 255/4);
                brush.setColor(g);
            } else {
                QColor r(255, 0, 0, 255/4);
                brush.setColor(r);
            }

            painter->setBrush(brush);

            painter->drawPie(boundingRect(), currentAngle*16, angle*-16);

            painter->restore();
        } else {
            painter->drawPie(boundingRect(), currentAngle*16, angle*-16);
        }

        currentAngle -= angle;
    }

}

void PieCircle::setColor(QColor &color)
{
    _color = color;
    emit colorChanged();
}

void PieCircle::setSlices(int slices)
{
    if (slices < 2) return;
    _slices = slices;
    emit slicesChanged();
}

void PieCircle::selectSlice(int slice)
{
    _selectedSlice = slice;
    update();
}
