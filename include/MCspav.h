#ifndef MCSPAV_H_INCLUDED
#define MCSPAV_H_INCLUDED

int launch_SPAV(ATOM at[], DATA *dat, SPDAT *spdat, double *ener);
int apply_SPAV_Criterion(DATA *dat, SPDAT *spdat, ATOM at[], ATOM at_new[], ATOM ***iniArray, ATOM ***finArray, int *candidate, double *ener, int *currStep);

#endif // MCSPAV_H_INCLUDED
