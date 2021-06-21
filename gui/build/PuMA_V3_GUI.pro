QT       += core gui printsupport 3dcore 3drender 3dinput 3dextras
CONFIG -= app_bundle

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = PuMA_V3_GUI
TEMPLATE = app

INCLUDEPATH += \"${CONDA_PREFIX}/include\"
INCLUDEPATH += \"${CONDA_PREFIX}/include/eigen3/Eigen\"
INCLUDEPATH += \"${PuMA_DIR}/install/include\"

LIBS += -L\"${CONDA_PREFIX}/lib\" -ltiff -lfftw3_threads -lfftw3 -lomp
LIBS += -L\"${PuMA_DIR}/install/lib\" -lPuMA

QMAKE_CXXFLAGS += --std=c++0x

SOURCES += \
        ../src/*.cpp \
        ../src/Export/*.cpp \
        ../src/Generate/*.cpp \
        ../src/Import/*.cpp \
        ../src/Log/*.cpp \
        ../src/MaterialProperties/*.cpp \
        ../src/Process/*.cpp \
        ../src/Utilities/*.cpp \
        ../src/Utilities/qcustomplot/*.cpp \
        ../src/Plugins/*.cpp \
        ../src/Visualization/*.cpp \


HEADERS += \
        ../src/*.h  \
        ../src/Export/*.h \
        ../src/Generate/*.h \
        ../src/Import/*.h \
        ../src/Log/*.h \
        ../src/MaterialProperties/*.h \
        ../src/Process/*.h \
        ../src/Utilities/*.h \
        ../src/Utilities/qcustomplot/*.h \
        ../src/Plugins/*.h \
        ../src/Visualization/*.h \


FORMS += \
        ../src/*.ui \
        ../src/Export/*.ui \
        ../src/Generate/*.ui \
        ../src/Import/*.ui \
        ../src/Log/*.ui \
        ../src/MaterialProperties/*.ui \
        ../src/Process/*.ui \
        ../src/Plugins/*.ui \
        ../src/Visualization/*.ui \

RESOURCES += \
        ../extras/resource.qrc
