//  December 15, 2019
//
//  Spotlightizer
//
//
//  Copyright (C) 1di4r 2019

#import "Tweak.h"

void reloadPreferences() {

    HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"cf.1di4r.spotlightizer_pref"];
    enabled = [([file objectForKey:@"enabled"] ?: @(YES)) boolValue];
    killBackgroundBlur = [([file objectForKey:@"killBackgroundBlur"] ?: @(YES)) boolValue]; 

}
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/cf.1di4r.spotlightizer_colorPrefs.plist"];
                

%group Hooks

    %hook SBIsolationTankWindow

        -(void)layoutSubviews{
            if(enabled){

                %orig;
                self.backgroundColor = (LCPParseColorString([prefs objectForKey:@"Color"], @"#0F171E"));

                
            }else {
                return %orig;
            }

        }

    %end
    %hook UIGroupTableViewCellBackground
        
        -(id)initWithFrame:(CGRect)frame{
            if(killBackgroundBlur){

                %orig;
                return nil;

            }else {
                return %orig;
            }
        }

    %end 

%end



void displayStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
}

%ctor{
    reloadPreferences();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPreferences, (CFStringRef)@"cf.1di4r.spotlightizer_pref/ReloadPrefs", NULL, kNilOptions);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, displayStatusChanged, CFSTR("com.apple.iokit.hid.displayStatus"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

    %init(Hooks);
}
