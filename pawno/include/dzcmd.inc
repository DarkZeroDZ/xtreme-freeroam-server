//DZCMD by DarkZero! (C)

#include <a_samp>


#define dzcmd(%0,%1,%2,%3) \
		if (!strcmp(#%0, %1, true, (%2))) dzcmd_%0((%3), %1[(%2) + 1])
#define dzcmd2(%0,%1,%2) \
		if (!strcmp(#%0, %1, true)) dzcmd_%0((%2))
#define dzcmd_init(%0) \
		format(%0, (128), "%s", %0[1])

