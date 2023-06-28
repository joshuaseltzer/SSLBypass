ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
TARGET := iphone:clang:16.2:15.0
ARCHS := arm64 arm64e
else
TARGET := iphone:clang:14.5:8.0
ARCHS := armv7 arm64 arm64e
endif

PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SSLBypass
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS += -DTHEOS_LEAN_AND_MEAN -Wdeprecated-declarations -Wno-deprecated-declarations
$(TWEAK_NAME)_FRAMEWORKS = UIKit Security

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
