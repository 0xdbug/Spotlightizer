export ARCHS = arm64 arm64e
export TARGET = iphone:clang:11.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = spotlightizer_pref

spotlightizer_pref_FILES = XXXRootListController.m
spotlightizer_pref_INSTALL_PATH = /Library/PreferenceBundles
spotlightizer_pref_FRAMEWORKS = UIKit
spotlightizer_pref_PRIVATE_FRAMEWORKS = Preferences
spotlightizer_pref_EXTRA_FRAMEWORKS += CepheiPrefs
spotlightizer_pref_CFLAGS = -fobjc-arc
spotlightizer_pref_LIBRARIES = colorpicker


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/spotlightizer_pref.plist$(ECHO_END)
