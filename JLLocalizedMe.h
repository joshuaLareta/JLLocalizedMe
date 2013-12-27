//
//  JLLocalizedMe.h
//  JLLocalized
//
//  Created by Joshua on 13/12/13.
//  Copyright (c) 2013 Joshua. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//  The application should contain a file that has all the required translation.
//
//  The default file that the system uses is "Localizable.strings".
//
//  If we intend to make the application localization behave like the system behaviour it is advisable to use "Localizable.strings" in creating the resource for the translations otherwise, we can select a custom file that handles the system translation by changing the value for the definition "JLDefaultLocalizableFname" and the file type "JLDefaultLocalizableType".
 




/*
 
 Determines whether the application will use on-the fly change or system change
 
 0 = Use system language change and application will restart
 1 = Use on the fly change
 2 = Use on the fly change but needs to be restarted
 */

#define KCLocalized 1    



/*
 
 The default selected language for the app. Uses ISO 639-1 language designation
 
 */

#define JLLocalizedMeLangageDefault @"en" 



/*
 
 Filename that the application looks up for translation mapping.
 
 The default filename for the translation that the system looks into is "Localizable.strings"
 
 */

#define JLDefaultLocalizableFname @"Localizable"



/*
 
 Filetype of the translation mapping.
 
 The default filetype for the translation is ".strings"
 
 */

#define JLDefaultLocalizableType @"strings"



/*
 
 Default filetype of the image.
 
 */

#define JLDefaultImageImageType @"png"




/*
 
 Macro that handles the initialization of localizedMe
 
 Usage:
 
    JLLocalizedMeInit();
 
 
 */

#define JLLocalizedMeInit()\
        [[JLLocalizedMe sharedInstance]localizedMeInit];


/*
 
 Macro that handles easy instantiation/use of the class localizedMe
 
usage:
 
    LocalizedMyString(@"The_string_that_you_want_to_localized");
 
 */

#define LocalizedMyString(string)\
        [[JLLocalizedMe sharedInstance]localizedMeString:string]





/*
 Macro that handles image based on the selected language
 
 usage :
 LocalizedMeImage(@"ImageName");
 
 */

#define LocalizedMyImage(string)\
        [[JLLocalizedMe sharedInstance]localizedMeImage:string]




/*
 
 Macro that handles language setting
 
 usage: 
        LocalizedMeLanguageSet(@"language_designation_ISO_639-1",@"Delegate_to_handle_refresh");
 
 */

#define LocalizedMeLanguageSet(string,delegate)\
        [[JLLocalizedMe sharedInstance]localizeMeLanguageSet:string forDelegate:delegate]





/*
 
 Protocol that handles on the fly changes
 
 */
@protocol JLLocalizedMeLanguageUpdateDelegate <NSObject>

-(void)localizedMeOnTheFlyUpdate;


@end


@interface JLLocalizedMe : NSObject




+(id)sharedInstance; // Use singleton to handle allocation and instantiation across the whole application

-(NSString *)localizedMeString:(NSString *)string; // Method that localizes string

-(void)localizeMeLanguageSet:(NSString *)lang forDelegate:(id<JLLocalizedMeLanguageUpdateDelegate>)delegate; // Uses ISO 639-1 language designation (i.e. en,es,fr, etc.) and delegation for view refresh

-(UIImage *)localizedMeImage:(NSString *)ImageName; // method to fetched localized Image

-(void)localizedMeInit; // init the JLLocalizedMe Class



@end
