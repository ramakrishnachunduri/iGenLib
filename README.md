iGenLib
=======

iGenLib - An IOS(Iphone &amp; Ipad) library with Generic Extensions and Components
(Just a wrapper library to hold all the re-usable code in the projects we worked with)

Documentation available at http://www.codeworth.com/c_w_files/iGenLibDoc

iGenLib is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation at http://www.gnu.org/licenses/, either version 3 of the License, or
(at your option) any later version. 

List of Components
- GridView
   - Grid in either horizontal or vertical layouts 
   - Shows pager only in horizontal mode
- MoveAndScaleImage
   - Allows to zoom the image and crop to the visible portion.
- DropDownList
   - Mimics conventional dropdown list instead of using ActionSheet in iPhone and PopOver in iPad
- Padded Label and Padded Text Field.

&nbsp;&nbsp;
&nbsp;&nbsp;

List of Extensions
- NSArray
  - Sort alphabetically when it has strings.
  - Search objects which starts with a specific string or contains specific string
  - First object (similar to default lastObject method)
- NSMutableArray
  - Search and remove objects which starts with specific string or contains specific string
- NSBundle
  - Give the path of a resource based on the active locale from specific .lproj directory.
- NSDate
  - Convert date to string based on the format.
  - Calculate difference between dates.
  - First and last dates in a month or week
  - Count days in a month - 28,29,30 and 31 based on calender year
- NSObject
  - Extension to prevent Unrecognized Selector sent when we are unaware of targeted class
- NSString
  - Convert to date based on format 
  - Extensions to help in Searching
  - Formatting - Add lines, spaces, html breaks etc
  - Calculate number of lines
  - Version Comparision - For now compares max of 3 decimals 1.1.1 is greater than 1.1.0 or 1.1
- NSThread
  - Extensions to help passing multiple objects when detaching a new thread.
- NSInvocation
  - Extensions to help passing multiple objects for invocations.
- UIColor
  - Convert Hexa to UIColor - FF0000 gives Red 
  - Convert rgb or rgba to UIColor rgb(255,0,0) or rgba(255,0,0,1) returns red
- UIImage
  - Rotate image by degrees
  - Scales image proportionally preserving aspect ratio
  - Scales to specific size either with or without aspect ratio.
  - Verify landscape or potrait image
- UIView
  - Recursively loop through all the sub views
  - Calculate height for specific content in desired width.
  - Convert view to an image - kind of screenshot but only for view
  - Draw a view in context - draw over pdf, graph or another image.