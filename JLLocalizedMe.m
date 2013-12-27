//
//  JLLocalizedMe.m
//  JLLocalized
//
//  Created by Joshua on 13/12/13.
//  Copyright (c) 2013 Joshua. All rights reserved.
//

#import "JLLocalizedMe.h"

#define JLLocalizedMeLanguageSelect @"JLL0C@l!zEdM3" // key for the userdefault

#define JLLocalizedMeInit @"JLL0C@l!z3dM3!n!T"


@interface JLLocalizedMe()

@property(nonatomic,assign)id delegation;

@end
@implementation JLLocalizedMe

@synthesize delegation = _delegation;

static NSArray *listOfImageFileType = nil; // list of image file type currently being handled

+(id)sharedInstance{
    
    static JLLocalizedMe *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JLLocalizedMe alloc] init];
        
    });
    
    return _instance;
}



-(id)init{
    self = [super init];
    if(self){
        listOfImageFileType =  @[@"png",@"jpg",@"jpeg"]; // initialized the default image that can be handled
    }
    return self;
}


/*
 
 Method that localizes the string
 
 */
-(NSString *)localizedMeString:(NSString *)string{
    
    NSString *localizedString = nil;
    
    
    //check if whether we are going to use the system setting or on the fly change
    if(KCLocalized == 1 || KCLocalized == 3){
        
        NSUserDefaults *initPref = [NSUserDefaults standardUserDefaults];
        BOOL isInit = [initPref boolForKey:JLLocalizedMeInit];
        
        //check if application is already restarted

        
        if(KCLocalized == 1||(KCLocalized == 3 && isInit)){
            NSString *selectedLang = [self selectedLanguagePref]; // get selected language preference
            
                 
            
            //get path of the localizable string
            NSString *path = [[NSBundle mainBundle]pathForResource:JLDefaultLocalizableFname ofType:JLDefaultLocalizableType inDirectory:nil forLocalization:selectedLang];
            
            if(path != nil){
                if([path respondsToSelector:@selector(length)]){
                    if([path length]>0){
                        
                        //populate the dictionary with contents of the Localizable.strings file which depends on the localization language disignation
                        NSDictionary *localizableHash = [NSDictionary dictionaryWithContentsOfFile:path];
                        
                        localizedString = localizableHash[string];
                        
                        if(localizedString == nil){
                            localizedString = string; // if it is empty means the application doesn't have a translation for the current word
                        }
                        else if(localizedString != nil){
                            
                            // check length of string 
                            if([localizedString respondsToSelector:@selector(length)]){
                                if([localizedString length]==0){
                                    localizedString = string;
                                }
                                
                            }
                            else{
                                
                                // if localizedString doesn't respond to length means ints not an NSString type
                                localizedString = [NSString stringWithFormat:@"%@",string];
                            }
                        }
                        
                    }
                }
            }
            else if (path == nil){ // if localizable is not existing
                localizedString = string;
            }
            

        }//check if is init
        else{
            localizedString = NSLocalizedString(string, nil); // if it is not init use the default localization method
        }
    }
    else{
        localizedString = NSLocalizedString(string, nil); // uses the default localization method
    }
    
    return localizedString;
}





-(UIImage *)localizedMeImage:(NSString *)imageName{
    
    UIImage *foundImage = nil;
    BOOL shouldGetDefaultType = YES;
    
    
    if(KCLocalized == 1 || KCLocalized == 3){
        
        NSUserDefaults *initPref = [NSUserDefaults standardUserDefaults];
        BOOL isInit = [initPref boolForKey:JLLocalizedMeInit];
        
        //check if application is already restarted
        if(KCLocalized == 1 ||(KCLocalized == 3 && isInit)){
        
            NSMutableArray *getExtension = [[imageName componentsSeparatedByString:@"."] mutableCopy];
            if([getExtension respondsToSelector:@selector(count)]){
               
                if([getExtension count]>1){ // check if there is a valid file type
                    NSString *theLastPiece = [getExtension lastObject]; // get the extension
                    
                    if([listOfImageFileType containsObject:[theLastPiece lowercaseString]]){ //check if fileType is valid
                        
                        shouldGetDefaultType = NO; // should not get default image
                        [getExtension removeLastObject]; // remove the last data which is supposed to be the file type
                       
                        NSString *newImageName = [getExtension componentsJoinedByString:@"."]; //
                        
                        foundImage = [self getImage:newImageName withType:theLastPiece];
                    }
                }
            }
           
            if(shouldGetDefaultType){
                foundImage = [self getImage:imageName withType:JLDefaultImageImageType];
            }
        }
        else{
            foundImage = [UIImage imageNamed:imageName]; // if its not init call the image by using imageNamed
        }
        
        
    }
    else{
        foundImage = [UIImage imageNamed:imageName]; // use imageNamed in calling the image
    }
    
   
    //we should check if it contains file type
    
    return foundImage;
}



/*
 
 Sets the language to use
 Needs ISO 639-1 for the lang designation
 
 */
-(void)localizeMeLanguageSet:(NSString *)lang forDelegate:(id<JLLocalizedMeLanguageUpdateDelegate>)delegate{
    
    BOOL isValid = NO;
    if(lang != nil){
        if([lang respondsToSelector:@selector(length)]){
            if([lang length]>0){
                if(delegate != nil){
                    _delegation = delegate;
                }
                isValid = YES;
                NSUserDefaults *langPref = [NSUserDefaults standardUserDefaults];
                [langPref setObject:lang forKey:JLLocalizedMeLanguageSelect];
                [langPref setBool:NO forKey:JLLocalizedMeInit];
                [langPref synchronize];
                
                // must reload view
                [self updateScreenView];
            }
        }
    }
    
    if(!isValid){
        NSLog(@"Lang cannot be nil");
    }
    
}

/*
 
 Method that handles the fetching of image with type
 
 */
-(UIImage *)getImage:(NSString *)imageName withType:(NSString *)type{
    
    UIImage *image =nil;

    NSString *selectedLang = [self selectedLanguagePref];// get the selected language
    
    if([UIScreen mainScreen].scale == 2.0){ // check if we are going to use @2x images
        
        NSString *tempImageName = [NSString stringWithFormat:@"%@@2x",imageName];
        NSString *tempPath = [[NSBundle mainBundle]pathForResource:tempImageName ofType:type inDirectory:nil forLocalization:selectedLang];
        if([[NSFileManager defaultManager]fileExistsAtPath:tempPath]){
            imageName = tempImageName;
        }
    }
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:imageName ofType:type inDirectory:nil forLocalization:selectedLang]; // get the path based on the image name, selected type and selectedLang
    
    image = [UIImage imageWithContentsOfFile:path]; // get the image based on the path
    
    return image;
}



/*
 
Gets the selected languange by designation, if the designation is empty we use the default value 
 
 */



-(NSString *)selectedLanguagePref{
    
     //check for the selected language preference if it is not existing we can use a default value
    
    NSUserDefaults *langPref = [NSUserDefaults standardUserDefaults];
    NSString *selectedLang = [langPref objectForKey:JLLocalizedMeLanguageSelect];
    
    if(selectedLang == nil){ // check if it nil
        selectedLang = JLLocalizedMeLangageDefault;
    }
    else if (selectedLang != nil){
        
        // check if its not nil but length is == 0
        if([selectedLang respondsToSelector:@selector(length)]){
            if([selectedLang length]==0){
                selectedLang = JLLocalizedMeLangageDefault;
            }
        }
        else{
            
            
            // if selectedLang doesn't respond to length means its not an NSString type
            selectedLang = [NSString stringWithFormat:@"%@", JLLocalizedMeLangageDefault];
        }
    }
    
    return selectedLang;
}
/*
 
 Calls the update protocol
 
 */

-(void)updateScreenView{
    
    if([_delegation respondsToSelector:@selector(localizedMeOnTheFlyUpdate)]){
        [_delegation localizedMeOnTheFlyUpdate];
    }

}

/*

 Call to set init for localizedMe
 
    * Should be called in applicationDidFinishedLaunching

*/

-(void)localizedMeInit{
    NSUserDefaults *initPref = [NSUserDefaults standardUserDefaults];
    [initPref setBool:YES forKey:JLLocalizedMeInit];
    [initPref synchronize];
}

@end
