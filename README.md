
#### Angular Seperation Calculator
##### R package with shiny to determine the angular seperation of astronomical objects.
##### Created by Tony Gojanovic
##### May 25, 2020

***

##### Background

Oftentimes it is of interest in astronomy to determine the angular seperation of astronomical objects given their postions (right ascension and declination).

**Note:**  
Right ascension is defined as the angle from the vernal equinox to the point, going east along the celestial equator.
Declination is defined as the angle from the celestial equator to the point, going north (negative values indicate going south).  

The vernal equinox is the intersection of the celestial equator and the ecliptic where the ecliptic rises above the celestial equator going further east.

***

#### Usage

User input for two astronomical objects is provided by the user in hours, minutes and seconds for right ascension and degrees, minutes and seconds for declination.  The program converts the inputs to decimal equivalents and radians, calculates the distance, and converts the final measure back to degrees of angular seperation for the user.

**Note:**  
The arcminutes and arcseconds in DMS are not the same as the minutes and seconds in HMS. A minute in HMS is equal to 15 arcminutes in DMS and a second is equal to 15 arcseconds.

***

#### Algorithm

The algorithm used in this application is based on the haversine formula for determining distances on a "great cirlce."  The haversine formula also reduces floating point errors when two points are very close together.

***

#### References

The following is a useful resource to understand equatorial coordinate systems and the application fo the haversine formula for fidning distances:

https://astronomy.swin.edu.au/cosmos/E/Equatorial+Coordinate+System  
https://en.wikipedia.org/wiki/Great-circle_distance#Formulas  
https://en.wikipedia.org/wiki/Haversine_formula




