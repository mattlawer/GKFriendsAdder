SDKVERSION = 5.0
include theos/makefiles/common.mk

TWEAK_NAME = GKFriendsAdder
GKFriendsAdder_FILES = Tweak.xm
GKFriendsAdder_FRAMEWORKS = UIKit GameKit

include $(THEOS_MAKE_PATH)/tweak.mk
