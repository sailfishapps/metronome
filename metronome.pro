TEMPLATE = subdirs

nemo-keepalive.file = 3rdparty/nemo-keepalive.pro

app.file = app.pro
app.depends = nemo-keepalive

SUBDIRS = nemo-keepalive app
