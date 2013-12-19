JLLocalizedMe
=============

A class that can handle on the fly language change by using a custom method or by system language change



Settings
--------

* ``KCLocalized``
    * Determines whether the application will use on-the fly change or system change
       *  0 - Use system language change and application will restart
       *  1 - Use on the fly change (need not restart but must implement the view refresh)
  

* ``JLLocalizedMeLangageDefault``
  * The default selected language for the app. Uses ISO 639-1 language designation _(i.e. en, fr, es, etc.)_
   

 
* ``JLDefaultLocalizableFname``
    * Filename that the application looks up for translation mapping.
    * The default filename for the translation that the system looks into is _"Localizable"_

* ``JLDefaultLocalizableType``
    * Filetype of the translation mapping 
    *  The default filetype for the translation is _".strings"_

* ``JLDefaultImageImageType``
    * Default filetype of the image.
    * If you try to localized the image you do not need to put the filetype if the image you are looking for is the same type as the default. _(i.e. png, jpg, jpeg)_
    

Usage
-----

<b>String localization</b>

  * ``LocalizedMyString(string)``
    * Macro that handles easy instantiation/use of the class localizedMe
    * *LocalizedMyString(@"The\_string\_that\_you\_want\_to\_localized");*
    
        
    
