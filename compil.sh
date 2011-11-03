# executer pour compilation

clear

cd /Users/mathieu/Desktop/Developer/iPhone/JBDev/Tweaks/gkfriendsadder/
#ln -s /Users/mathieu/Desktop/Developer/iPhone/JBDev/theos ./theos
#mv ./Tweak.xm ./Tweak.m
#ln -s ./Tweak.m ./Tweak.xm


make -f Makefile

mkdir -p ./layout/DEBIAN
cp ./control ./layout/DEBIAN

#mkdir -p ./layout/Library/PreferenceLoader/Preferences
#cp ./LockMessagesPreferences/entry.plist ./layout/Library/PreferenceLoader/Preferences/LockMessagesPreferences.plist

#mkdir -p ./layout/Library/PreferenceBundles/LockMessagesPreferences.bundle
#cp ./LockMessagesPreferences/Resources/*.* ./layout/Library/PreferenceBundles/LockMessagesPreferences.bundle
#cp ./LockMessagesPreferences/obj/LockMessagesPreferences ./layout/Library/PreferenceBundles/LockMessagesPreferences.bundle

mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries
cp ./obj/GKFriendsAdder.dylib ./layout/Library/MobileSubstrate/DynamicLibraries
cp ./GKFriendsAdder.plist ./layout/Library/MobileSubstrate/DynamicLibraries


sudo find ./ -name ".DS_Store" -depth -exec rm {} \;

export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

dpkg-deb -b layout
mv ./layout.deb ./GKFriendsAdder.deb
