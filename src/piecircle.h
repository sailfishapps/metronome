#ifndef PIECIRCLE_H
#define PIECIRCLE_H

#include <QQuickPaintedItem>
#include <QPainter>

class PieCircle : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int slices READ slices WRITE setSlices NOTIFY slicesChanged)
public:
    explicit PieCircle(QQuickItem *parent = 0);

    void paint(QPainter *painter);

    QColor color() const {return _color;}
    void setColor(QColor &color);

    int slices() const {return _slices;}
    void setSlices(int slices);

signals:
    void colorChanged();
    void slicesChanged();

public slots:
    void selectSlice(int slice);

private:
    QColor _color;
    QColor _selectedColor;
    int _slices;
    int _selectedSlice;
};

#endif // PIECIRCLE_H
