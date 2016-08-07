#include "piecircle.h"

#include <QDebug>

PieCircle::PieCircle(QQuickItem *parent) :
    QQuickPaintedItem(parent),
    _slices(4),
    _selectedSlice(0)
{
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
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

    painter->drawEllipse(boundingRect());

    if (_slices > 1) {
        if (_selectedSlice == 0)
            brush.setColor(QColor(0, 255, 0, 255/4));
        else
            brush.setColor(QColor(255, 0, 0, 255/4));
        painter->setBrush(brush);

        const double angle = 360 / _slices;
        const double start = (90 + (angle / 2)) + (angle * -_selectedSlice);
        painter->drawPie(boundingRect(), start*16, angle*-16);
    }
}

void PieCircle::setColor(QColor &color)
{
    _color = color;
    emit colorChanged();
}

void PieCircle::setSlices(int slices)
{
    _slices = slices;
    emit slicesChanged();
}

void PieCircle::selectSlice(int slice)
{
    _selectedSlice = slice;
    update();
}
