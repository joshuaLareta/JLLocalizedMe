JLLocalizedMe
=============

A class that can handle on the fly language change by using a custom method or by system language change



Settings
--------

* ``KCLocalized``
    * Determines whether the application will use on-the fly change or system change
       *  0 - Use system language change and application will restart
       *  1 - Use on the fly change (need not restart but must implement the view refresh)
       *  2 - Use on the fly change but needs to be restarted
  

* ``JLLocalizedMeLangageDefault``
  * The default selected language for the app. Uses ISO 639-1 language designation _(i.e. en, fr, es, etc.)_
   

 
* ``JLDefaultLocalizableFname``
    * Filename that the application looks up for translation mapping.
    * The default filename for the translation that the system looks into is _"Localizable"_

* ``JLDefaultLocalizableType``
    * Filetype of the translation mapping 
    *  The default filetype for the translation is _"strings"_

* ``JLDefaultImageImageType``
    * Default filetype of the image.
    * If you try to localized the image you do not need to put the filetype if the image you are looking for is the same type as the default. _(i.e. png, jpg, jpeg)_
    
Protocol
--------

* ``JLLocalizedMeLanguageUpdateDelegate``
   * A protocol that will handle the on the fly change
   * ``-(void)localizedMeOnTheFlyUpdate;``
      * This is the method that we need to put the re-initialization of the strings or refreshing of the views



Usage
-----

<b>JLLocalizedMe Init</b>
  * ``JLLocalizedMeInit()``
    * A convenience method that handles the initialization of JLLocalizedMe class
    * It must be initialized in the _didFinishedLaunchingWithOptions_ method
    * *JLLocalizedMeInit();*

<b>String localization</b>

  * ``LocalizedMyString(string)``
    * A convenience method that handles easy instantiation/use of the class localizedMe
    * *LocalizedMyString(@"The\_string\_that\_you\_want\_to\_localized");*
    
<b>Image Localization</b>

 * ``LocalizedMyImage(string)``
   *  A convenience method that handles image based on the selected language
   *  Localized the image first by selecting the image then click "Localize" in the inspector
   * *LocalizedMeImage(@"ImageName");*
   

<b>Set up the preferred language</b>
 * ``LocalizedMeLanguageSet(string,delegate)``
   * A convenience method that handles language setting
   * It requires 2 parameters
      * The language designation with the ISO 639-1 format _(i.e. en, fr, es, etc.)_
      * An optional delegate to handle the callback to setup the on the fly language change. Pass _nil_ if you want the program to be restarted for the new language to take effect. 
   * *LocalizedMeLanguageSet(@"language_designation_ISO_639-1",@"Delegate_to_handle_refresh");*
   

        
    
